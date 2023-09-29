// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/model/chats/chats_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/chats/messages_model.dart';
import '../../utils/enums.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;
bool isHasNoData = false;
class ChatScreen extends StatefulWidget {
  static const chatRoute = 'chat_screen';
  final String? token;
  final String? adsOwner;
  final String? img;

  const ChatScreen({super.key, required this.token, required this.adsOwner, required this.img});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
// List<Messages> messages = [];

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String? messageText;
  RequestState requestState = RequestState.waiting;

  // Future<void> getMessages([String uid = 'aGECdK2Zr8jT4rrUJ2eT']) async {
  //   requestState = RequestState.loading;
  //   await FirebaseFirestore.instance.collection('users/IEAajzMhE25eLtqlAXP0/chats/$uid/messages').get().then((value) {
  //     messages = [];
  //     value.docs.forEach((element) {
  //       messages.add(Messages.fromJson(element.data()));
  //       print(element.data());
  //     });
  //     requestState = RequestState.success;
  //   }).catchError((e){
  //     requestState = RequestState.error;
  //   });
  //   setState(() {});
  // }

  @override
  void initState() {
    print(widget.adsOwner);
    print(widget.token);
    print(widget.img);
    super.initState();
  }


  String? chatImageUrl;
  XFile? chatImage;
  XFile? chatImageUpload;

  Future uploadImageChat() async {
    if (chatImage != null) {
      chatImageUpload = chatImage;
      chatImage = null;
      setState(() {});
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('chats/img/${chatImageUpload!.path.split('/').last}')
          .putFile(File(chatImageUpload!.path))
          .then((val) async {
        chatImageUpload = null;
        setState(() {});
        await val.ref.getDownloadURL().then((value) {
          chatImageUrl = value;
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/svg/white_backarrow.svg',
                        width: 80,
                        height: 70,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 75,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.adsOwner}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppFonts.t3),
                    ),
                  ],
                ),
              )
            ],
          ),
          MessageStreamBuilder(token: widget.token!, adsOwner: widget.adsOwner!, img: widget.img??''),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'برجاء العلم ان المحادثه مراقبه منعا للتواصل الخراجي مع صاحب العقار',
              style:
                  TextStyle(fontSize: AppFonts.t4, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(248, 243, 243, 243),
              border: Border(
                top: BorderSide(
                    color: Color.fromRGBO(102, 185, 208, 1), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    IconButton(
                        onPressed: () async {
                          if (messageTextController.text.isEmpty &&
                              chatImage == null) return;
                          final text = messageTextController.text.isEmpty
                              ? null
                              : messageTextController.text;
                          if (isHasNoData) {
                            Chats hisChat = Chats(
                              name: CurrentUser.name,
                              uid: CurrentUser.token,
                              image: CurrentUser.image,
                              isReadFromMe: false,
                              isReadFromUser: true,
                              lastMessageText: text,
                              lastMessageTime: Timestamp.now(),
                            );
                            Chats myChat = Chats(
                              name: widget.adsOwner,
                              uid: widget.token,
                              image: widget.img,
                              isReadFromMe: true,
                              isReadFromUser: false,
                              lastMessageText: text,
                              lastMessageTime: Timestamp.now(),
                            );
                            // return;
                            await FirebaseFirestore.instance.collection('users/${CurrentUser.token}/chats').doc(widget.token).set(myChat.toJson());
                            await FirebaseFirestore.instance.collection('users/${widget.token}/chats').doc(CurrentUser.token).set(hisChat.toJson());
                          }
                          messageTextController.clear();
                          await uploadImageChat();
                          final time = Timestamp.now();

                          final Messages message = Messages(
                            message: text,
                            receiverUid: '${widget.token}',
                            senderUid: '${CurrentUser.token}',
                            time: time,
                            img: chatImageUrl,
                          );
                          chatImageUrl = null;
                          _firestore.collection('users/${CurrentUser.token}/chats/${widget.token}/messages').add(message.toJson());
                          _firestore.collection('users/${widget.token}/chats/${CurrentUser.token}/messages').add(message.toJson());
                          Chats hisChat = Chats(
                            name: CurrentUser.name,
                            uid: CurrentUser.token,
                            image: CurrentUser.image,
                            isReadFromMe: true,
                            isReadFromUser: true,
                            lastMessageText: text,
                            lastMessageTime: time
                          );
                          Chats myChat = Chats(
                            name: widget.adsOwner,
                            uid: widget.token,
                            image: widget.img,
                            isReadFromMe: true,
                            isReadFromUser: true,
                            lastMessageText: text,
                            lastMessageTime: time,
                          );
                          await FirebaseFirestore.instance.collection('users/${CurrentUser.token}/chats').doc(widget.token).update(myChat.toJson());
                          await FirebaseFirestore.instance.collection('users/${widget.token}/chats').doc(CurrentUser.token).update(hisChat.toJson());
                        },
                        icon: SvgPicture.asset(
                          'assets/svg/group28776.svg',
                          width: 80,
                          height: 80,
                        )),
                    Expanded(
                      child: TextFormField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: 'أكتب رسالتك هنا...',
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          chatImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        icon: Icon(
                          size: 30,
                          Icons.photo_size_select_actual_outlined,
                          color: Color.fromRGBO(234, 145, 78, 1),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: IconButton(
                            onPressed: () async {
                              chatImage = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              setState(() {});
                            },
                            icon: SvgPicture.asset(
                              'assets/svg/camera.svg',
                              width: 40,
                              height: 40,
                            )),
                      ),
                    ),
                  ]),
                  if (chatImage != null)
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(File(chatImage!.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Image(image: FileImage(File('')), width: 100, height: 100),

                                IconButton(
                                    splashRadius: .1,
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      chatImage = null;
                                      // chatImage = null;
                                      setState(() {});
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                50),
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 4,
                                            color: Colors.red.withOpacity(.8),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.close_sharp,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  String token;
  String adsOwner;
  String img;



  MessageStreamBuilder({super.key, required this.token, required this.adsOwner, required this.img});

  @override
  Widget build(BuildContext context) {
    // token = 'aGECdK2Zr8jT4rrUJ2eT';
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users/${CurrentUser.token}/chats/$token/messages')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messageWidgets = [];
          if (snapshot.data?.docs.isEmpty??true) {
            isHasNoData = true;
            return Center(
              child: Text('أبدا التحدث مع ${adsOwner}', style: TextStyle(
                fontSize: 24,
                color: Colors.amber[900]
              )),
            );
          }
          FirebaseFirestore.instance.collection('users/${CurrentUser.token}/chats').doc(token).update({'isReadFromMe' : true});
          FirebaseFirestore.instance.collection('users/${token}/chats').doc(CurrentUser.token).update({'isReadFromUser' : true});
          snapshot.data!.docs.forEach((element) {
            final Messages messages = Messages.fromJson(element.data() as Map<String, dynamic>);
            messageWidgets.add(MessageLine(messages: messages, myImg: CurrentUser.image??'', hisImg: img,));
          });
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets,
            ),
          );
        });
  }
}

class MessageLine extends StatelessWidget {
  MessageLine({
    super.key,
    required this.messages,
    required this.myImg,
    required this.hisImg,
  });

  final Messages messages;
  final String myImg;
  final String hisImg;

  @override
  Widget build(BuildContext context) {
    final bool isMe = messages.senderUid == CurrentUser.token;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isMe)
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 45,
            height: 45,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99)
            ),
              child: CachedNetworkImage(imageUrl: isMe?myImg:hisImg)),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Card(
                color: isMe ? Color.fromRGBO(65, 181, 180, 100) : Colors.white60,
                elevation: 8,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    if (messages.img != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: isMe
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))
                                    : BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: messages.img!,
                                width: MediaQuery.of(context).size.width * 0.6,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (messages.message != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          messages.message!,
                          style: TextStyle(
                              fontSize: AppFonts.t4_2,
                              color: isMe ? Colors.white : Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(DateFormat('kk:mm').format(messages.time!.toDate())))
          ],
        ),
        if (!isMe)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 45,
                height: 45,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99)
                ),
                child: CachedNetworkImage(imageUrl: isMe?myImg:hisImg)),
          ),
      ],
    );
  }
}
