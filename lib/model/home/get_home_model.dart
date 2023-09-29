import '../add_service_models/get_cities_model.dart';

class GetHomeModel {
  bool? status;
  String? message;
  Data? data;

  GetHomeModel({this.status, this.message, this.data});

  GetHomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Sliders>? sliders;
  List<Sliders>? adspace;
  List<Categories>? categories;
  List<Cities>? cities;
  int? countNotification;
  String? homeText;
  String? descText;

  Data({
    this.sliders,
    this.adspace,
    this.categories,
    this.cities,
    this.countNotification,
    this.homeText,
    this.descText,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(new Sliders.fromJson(v));
      });
    }
    if (json['Adspace'] != null) {
      adspace = <Sliders>[];
      json['Adspace'].forEach((v) {
        adspace!.add(new Sliders.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    countNotification = json['countNotification'];
    homeText = json['home_text'];
    descText = json['desc_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    if (this.adspace != null) {
      data['Adspace'] = this.adspace!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    data['countNotification'] = this.countNotification;
    data['home_text'] = this.homeText;
    data['desc_text'] = this.descText;
    return data;
  }
}

class Sliders {
  int? id;
  String? title;
  String? desc;
  String? image;

  Sliders({this.id, this.title, this.desc, this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['image'] = this.image;
    return data;
  }
}

class Categories {
  String? id;
  String? title;
  String? image;

  Categories({this.id, this.title, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}
