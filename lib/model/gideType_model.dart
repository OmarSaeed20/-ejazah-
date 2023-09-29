class GideTypeModel {
  bool? status;
  String? message;
  Data? data;

  GideTypeModel({this.status, this.message, this.data});

  GideTypeModel.fromJson(Map<String, dynamic> json) {
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
  List<GideType>? gideType;

  Data({this.gideType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['gideType'] != null) {
      gideType = <GideType>[];
      json['gideType'].forEach((v) {
        gideType!.add(new GideType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gideType != null) {
      data['gideType'] = this.gideType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GideType {
  int? id;
  String? name;

  GideType({this.id, this.name});

  GideType.fromJson(Map<String, dynamic> json) {
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
