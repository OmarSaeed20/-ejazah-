import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customBottomNavBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/model/chats/chats_model.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'chat_screen.dart';

class ChatHomeScreen extends StatefulWidget {

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}
List<Chats> chats = [];

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  RequestState requestState = RequestState.waiting;
  @override
  void initState() {
    getChats();
    super.initState();
  }

  Future<void> getChats() async {
    requestState = RequestState.loading;
    // print('object');
    CollectionReference reference = await FirebaseFirestore.instance.collection('users/${CurrentUser.token}/chats');
    reference.snapshots().listen((event) {
      print('object');
      chats = [];
      event.docs.forEach((change) {
        print(change.data());
        chats.add(Chats.fromJson(change.data() as Map<String, dynamic>));
      });
      requestState = RequestState.success;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      bottomNavigationBar: CustomBottomNavBar(
        navigationTabsIndex: 3,
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (requestState == RequestState.loading)
              return Center(child: CircularProgressIndicator());
            if (requestState == RequestState.error)
              return Text('حدث خطأ');
            if (chats.isEmpty)
              return Center(child: Text('لا توجد رسائل حتى الأن...', style: context.textTheme.titleLarge!.copyWith(
                color: Colors.amber[900]
              ),));
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                final Chats chat = chats[index];
                return GestureDetector(
                  onTap: () => myNavigate(
                      screen: ChatScreen(
                        token: chat.uid,
                        adsOwner: chat.name,
                        img: chat.image,
                      ),
                      context: context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 1.h,
                    ),
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 2.0),
                            blurRadius: 12.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(1),
                            margin: EdgeInsets.only(left: 3.w, top: 1.h),
                            decoration: !chat.isReadFromMe!
                                ? BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    border: Border.all(
                                      width: 1.w,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                            child: Container(
                              width: 65,
                              height: 65,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99)
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: chat.image??'https://scontent.fcai20-1.fna.fbcdn.net/v/t39.30808-6/347258932_1018739812840970_5916240586609442823_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=5cd70e&_nc_ohc=hv-1yWRolAYAX-69wXd&_nc_oc=AQknyKLG4Ml2Elr9EuXtBM4q5d8i7CZPiZ40TuUxK1SWQ33_RF5IQCEGM8k-ADAZtyw&_nc_ht=scontent.fcai20-1.fna&oh=00_AfCmsATxdYewNsG-vkD8bzyPTTZ8Rx1EMalGe0CIfOgtow&oe=646F16F2',
      
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * .68,
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          chat.name!,
                                          style: TextStyle(
                                            fontSize: AppFonts.t3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        !chat.isReadFromMe!
                                            ? Container(
                                                margin:
                                                    const EdgeInsets.only(left: 5),
                                                width: 20,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      Theme.of(context).primaryColor,
                                                ),
                                              )
                                            : Container(
                                                child: null,
                                              ),
                                      ],
                                    ),
                                    Text(
                                      DateFormat('kk:mm').format(chat.lastMessageTime!.toDate()),
                                      style: TextStyle(
                                        fontSize: AppFonts.t4,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    chat.lastMessageText??'صورة...',
                                    style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      color: Colors.black54,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
