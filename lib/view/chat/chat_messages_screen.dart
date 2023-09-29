// import 'package:ejazah/Widgets/app_colors.dart';
// import 'package:ejazah/Widgets/app_fonts.dart';
// import 'package:ejazah/Widgets/custom_text.dart';
// import 'package:ejazah/model/chats/messages_model.dart';
// import 'package:ejazah/model/message_model.dart';
// import 'package:ejazah/model/user/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// class ChatScreen extends StatefulWidget {
//   final User user;
//
//   ChatScreen({required this.user});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   _chatBubble(Messages message, bool isMe, bool isSameUser) {
//     if (isMe) {
//       return Column(
//         children: <Widget>[
//           Container(
//             alignment: Alignment.topRight,
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.80,
//               ),
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Text(
//                 message.message!,
//                 style: TextStyle(
//                   fontSize: AppFonts.t4_2,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           !isSameUser
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Text(
//                       message.time!,
//                       style: TextStyle(
//                         fontSize: AppFonts.t5,
//                         color: Colors.black45,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                           ),
//                         ],
//                       ),
//                       child: CircleAvatar(
//                         radius: 22,
//                         backgroundImage: AssetImage(message.),
//                       ),
//                     ),
//                   ],
//                 )
//               : Container(
//                   child: null,
//                 ),
//         ],
//       );
//     } else {
//       return Column(
//         children: <Widget>[
//           Container(
//             alignment: Alignment.topLeft,
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.80,
//               ),
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Text(
//                 message.text,
//                 style: TextStyle(
//                   fontSize: AppFonts.t4_2,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ),
//           !isSameUser
//               ? Row(
//                   children: <Widget>[
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                           ),
//                         ],
//                       ),
//                       child: CircleAvatar(
//                         radius: 22,
//                         backgroundImage: AssetImage(message.sender.imageUrl),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       message.time,
//                       style: TextStyle(
//                         fontSize: AppFonts.t5,
//                         color: Colors.black45,
//                       ),
//                     ),
//                   ],
//                 )
//               : Container(
//                   child: null,
//                 ),
//         ],
//       );
//     }
//   }
//
//   _sendMessageArea() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8),
//       height: 70,
//       color: Colors.white,
//       child: Row(
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.photo),
//             iconSize: 25,
//             color: Theme.of(context).primaryColor,
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration.collapsed(
//                 hintText: 'أكتب رسالتك هنا....',
//               ),
//               textCapitalization: TextCapitalization.sentences,
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             iconSize: 25,
//             color: Theme.of(context).primaryColor,
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int? prevUserId;
//     return Scaffold(
//       backgroundColor: AppColor.backGroundColor,
//       body: Column(
//         children: <Widget>[
//           Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(15),
//               margin: EdgeInsets.only(top: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       padding: EdgeInsets.all(1.5.w),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(2.w),
//                           color: AppColor.whiteColor),
//                       child: Icon(
//                         Icons.arrow_back,
//                         color: AppColor.grayColor,
//                         size: 4.5.w,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       CustomText(
//                         textAlign: TextAlign.center,
//                         text: widget.user.name,
//                         fontSize: AppFonts.t1,
//                         fontweight: FontWeight.bold,
//                         fontFamily: 'Tajawal',
//                       ),
//                       widget.user.isOnline
//                           ? Text(
//                               'Online',
//                               style: TextStyle(
//                                 fontSize: AppFonts.t4,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             )
//                           : Text(
//                               'Offline',
//                               style: TextStyle(
//                                 fontSize: AppFonts.t4,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 2.w,
//                   ),
//                 ],
//               )),
//           Expanded(
//             child: ListView.builder(
//               physics: BouncingScrollPhysics(),
//               reverse: true,
//               padding: EdgeInsets.all(20),
//               itemCount: messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final Message message = messages[index];
//                 final bool isMe = message.sender.id == currentUser.id;
//                 final bool isSameUser = prevUserId == message.sender.id;
//                 prevUserId = message.sender.id;
//                 return _chatBubble(message, isMe, isSameUser);
//               },
//             ),
//           ),
//           _sendMessageArea(),
//         ],
//       ),
//     );
//   }
// }
