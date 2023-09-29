class GetStreetsModel {
  bool? status;
  String? message;
  Data? data;

  GetStreetsModel({this.status, this.message, this.data});

  GetStreetsModel.fromJson(Map<String, dynamic> json) {
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
  List<Streets>? streets;

  Data({this.streets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['streets'] != null) {
      streets = <Streets>[];
      json['streets'].forEach((v) {
        streets!.add(new Streets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.streets != null) {
      data['streets'] = this.streets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Streets {
  int? id;
  String? name;
  String? lat;
  String? long;

  Streets({this.id, this.name, this.lat, this.long});

  Streets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
