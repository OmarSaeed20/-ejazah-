class GetAccompanyingModel {
  bool? status;
  String? message;
  Data? data;

  GetAccompanyingModel({this.status, this.message, this.data});

  GetAccompanyingModel.fromJson(Map<String, dynamic> json) {
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
  List<Accompanyings>? accompanyings;

  Data({this.accompanyings});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['accompanyings'] != null) {
      accompanyings = <Accompanyings>[];
      json['accompanyings'].forEach((v) {
        accompanyings!.add(new Accompanyings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accompanyings != null) {
      data['accompanyings'] =
          this.accompanyings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accompanyings {
  int? id;
  String? name;

  Accompanyings({this.id, this.name});

  Accompanyings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
