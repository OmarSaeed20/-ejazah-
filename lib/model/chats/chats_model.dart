import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsModel {
  List<Chats>? chats;

  ChatsModel({this.chats});

  ChatsModel.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  Timestamp? lastMessageTime;
  String? lastMessageText;
  String? uid;
  String? name;
  String? image;
  bool? isReadFromMe;
  bool? isReadFromUser;

  Chats(
      {this.lastMessageTime,
        this.lastMessageText,
        this.uid,
        this.name,
        this.image,
        this.isReadFromMe,
        this.isReadFromUser});

  Chats.fromJson(Map<String, dynamic> json) {
    lastMessageTime = json['lastMessageTime'];
    lastMessageText = json['lastMessageText'];
    uid = json['uid'];
    name = json['name'];
    image = json['image'];
    isReadFromMe = json['isReadFromMe'];
    isReadFromUser = json['isReadFromUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastMessageTime'] = this.lastMessageTime;
    data['lastMessageText'] = this.lastMessageText;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['isReadFromMe'] = this.isReadFromMe;
    data['isReadFromUser'] = this.isReadFromUser;
    return data;
  }
}
