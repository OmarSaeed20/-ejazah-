class TravelCountryModel {
  bool? status;
  String? message;
  Data? data;

  TravelCountryModel({this.status, this.message, this.data});

  TravelCountryModel.fromJson(Map<String, dynamic> json) {
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
  List<TravelCountry>? travelCountry;

  Data({this.travelCountry});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['travelCountry'] != null) {
      travelCountry = <TravelCountry>[];
      json['travelCountry'].forEach((v) {
        travelCountry!.add(new TravelCountry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.travelCountry != null) {
      data['travelCountry'] =
          this.travelCountry!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelCountry {
  int? id;
  String? name;
  String? image;

  TravelCountry({this.id, this.name, this.image});

  TravelCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
