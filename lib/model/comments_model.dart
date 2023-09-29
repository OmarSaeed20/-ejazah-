class CommentsModel {
  bool? status;
  String? message;
  Data? data;

  CommentsModel({this.status, this.message, this.data});

  CommentsModel.fromJson(Map<String, dynamic> json) {
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
  List<Commenets>? commenets;

  Data({this.commenets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['commenets'] != null) {
      commenets = <Commenets>[];
      json['commenets'].forEach((v) {
        commenets!.add(Commenets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commenets != null) {
      data['commenets'] = this.commenets!.map((element) => element.toJson()).toList();
    }
    return data;
  }
}

class Commenets {
  String? name;
  // String? image;
  String? commenet;
  String? rate;
  String? createdAt;

  Commenets({
    this.name,
    // this.image,
    this.commenet,
    this.rate,
    this.createdAt,
  });

  Commenets.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    // image = json['image'];
    commenet = json['commenet'];
    rate = json['rate'].toString();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    // data['image'] = this.image;
    data['commenet'] = this.commenet;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    return data;
  }
}
