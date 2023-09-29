import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesModel {
  List<Messages>? messages;

  MessagesModel({this.messages});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? message;
  String? senderUid;
  String? receiverUid;
  Timestamp? time;
  String? img;

  Messages({this.message, this.senderUid, this.receiverUid, this.time, this.img});

  Messages.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderUid = json['senderUid'];
    receiverUid = json['receiverUid'];
    time = json['time'];
    img = json['img'];
    // time = Timestamp.fromDate(DateTime.parse(json['time']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['senderUid'] = this.senderUid;
    data['receiverUid'] = this.receiverUid;
    data['time'] = this.time;
    data['img'] = this.img;
    return data;
  }
}
