class SplashModel {
  bool? status;
  String? message;
  Data? data;

  SplashModel({this.status, this.message, this.data});

  SplashModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Splachs>? splachs;

  Data({this.splachs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['splachs'] != null) {
      splachs = <Splachs>[];
      json['splachs'].forEach((v) {
        splachs!.add(new Splachs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.splachs != null) {
      data['splachs'] = this.splachs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Splachs {
  int? id;
  String? title;
  String? desc;
  String? image;

  Splachs({this.id, this.title, this.desc, this.image});

  Splachs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['image'] = this.image;
    return data;
  }
}
