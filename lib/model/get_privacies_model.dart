class GetPrivaciesModel {
  bool? status;
  String? message;
  Data? data;

  GetPrivaciesModel({this.status, this.message, this.data});

  GetPrivaciesModel.fromJson(Map<String, dynamic> json) {
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
  List<Privacies>? privacies;

  Data({this.privacies});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['privacies'] != null) {
      privacies = <Privacies>[];
      json['privacies'].forEach((v) {
        privacies!.add(new Privacies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.privacies != null) {
      data['privacies'] = this.privacies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Privacies {
  String? name;

  Privacies({this.name});

  Privacies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
