class RegisterSuccessModel {
  bool? status;
  String? message;
  Data? data;

  RegisterSuccessModel({this.status, this.message, this.data});

  RegisterSuccessModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  int? code;
  int? isActive;

  Data({this.user, this.code, this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    code = json['code'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['code'] = this.code;
    data['isActive'] = this.isActive;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? phone;
  String? link;
  String? image;
  String? token;
  String? country;

  User(
      {this.name,
        this.email,
        this.phone,
        this.link,
        this.image,
        this.token,
        this.country});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    link = json['link'];
    image = json['image'];
    token = json['token'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['link'] = this.link;
    data['image'] = this.image;
    data['token'] = this.token;
    data['country'] = this.country;
    return data;
  }
}
