class WheelSpinModel {
  bool? status;
  String? message;
  Data? data;

  WheelSpinModel({this.status, this.message, this.data});

  WheelSpinModel.fromJson(Map<String, dynamic> json) {
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
  List<Wheels>? wheels;

  Data({this.wheels});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['wheels'] != null) {
      wheels = <Wheels>[];
      json['wheels'].forEach((v) {
        wheels!.add(new Wheels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wheels != null) {
      data['wheels'] = this.wheels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wheels {
  int? id;
  String? key;
  String? value;
  bool? canTry;
  String? timetotryagain;

  Wheels({this.id, this.key, this.value, this.canTry, this.timetotryagain});

  Wheels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    canTry = json['canTry'];
    timetotryagain = json['timetotryagain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['canTry'] = this.canTry;
    data['timetotryagain'] = this.timetotryagain;
    return data;
  }
}
