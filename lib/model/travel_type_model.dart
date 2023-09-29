class TravelTypeModel {
  bool? status;
  String? message;
  Data? data;

  TravelTypeModel({this.status, this.message, this.data});

  TravelTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<TravelType>? travelType;

  Data({this.travelType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['travelType'] != null) {
      travelType = <TravelType>[];
      json['travelType'].forEach((v) {
        travelType!.add(new TravelType.fromJson(v));
      });
    }
  }
}

class TravelType {
  int? id;
  String? name;

  TravelType({this.id, this.name});

  TravelType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
