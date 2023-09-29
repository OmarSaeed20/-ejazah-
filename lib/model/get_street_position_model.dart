class GetStreetsPositionModel {
  bool? status;
  String? message;
  Data? data;

  GetStreetsPositionModel({this.status, this.message, this.data});

  GetStreetsPositionModel.fromJson(Map<String, dynamic> json) {
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
  Street? street;

  Data({this.street});

  Data.fromJson(Map<String, dynamic> json) {
    street =
    json['street'] != null ? new Street.fromJson(json['street']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.street != null) {
      data['street'] = this.street!.toJson();
    }
    return data;
  }
}

class Street {
  String? lat;
  String? long;

  Street({this.lat, this.long});

  Street.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
