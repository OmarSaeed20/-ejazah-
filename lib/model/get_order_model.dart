import 'package:ejazah/model/search_models/search_result_model.dart';

class OrdersModel {
  bool? status;
  String? message;
  Data? data;

  OrdersModel({this.status, this.message, this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<Categories>? categories;
  List<Ads>? favourites;

  Data({this.categories, this.favourites});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['favourites'] != null) {
      favourites = <Ads>[];
      json['favourites'].forEach((v) {
        favourites!.add(new Ads.fromJson(v));
      });
    }
  }

}

class Categories {
  dynamic id;
  String? name;
  String? image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
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

class Accompanying {
  String? name;
  int? status;

  Accompanying({this.name, this.status});

  Accompanying.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
  }
}
class Favourites {
  String? id;
  String? sellerImage;
  String? token;
  String? streetId;
  String? categoryName;
  String? categoryId;
  String? name;
  String? driverName;
  String? desc;
  String? price;
  String? area;
  String? address;
  String? lat;
  String? long;
  String? city;
  String? adsOwner;
  List<Commenets>? commenets;
  List<Images>? images;
  List<Terms>? terms;
  String? families;
  String? insurance;
  String? privateHouse;
  String? sharedAccommodation;
  String? animals;
  String? visits;
  String? bedRoom;
  String? bathrooms;
  String? council;
  String? kitchenTable;
  bool? favourite;
  bool? isMine;
  String? date;
  String? rate;
  String? offer;
  String? totalPrice;

  String? currency;
  String? insuranceValue;
  String? smoking;
  String? individual;
  String? additionValue;
  String? commenetCounts;
  String? ticket_count;
  String? from;
  String? to;
  String? hour_work;
  String? group_travel;
  String? language;
  String? travel_type;
  String? country;
  String? iban;
  String? passengers;
  String? license_number;
  String? moodle;
  String? guide_image;
  String? national_image;
  String? license_image;
  String? hour_price;
  bool isSelected = false;

  List<Accompanying>? accompanying;
  Favourites(
      {this.id,
        this.moodle,
        this.isSelected = false,
        this.guide_image,
        this.driverName,
        this.national_image,
        this.license_image,
        this.hour_price,
        this.passengers,
        this.hour_work,
        this.license_number,
        this.country,
        this.iban,
        this.group_travel,
        this.language,
        this.travel_type,
        this.sellerImage,
        this.ticket_count,
        this.from,
        this.to,
        this.accompanying,
        this.streetId,
        this.categoryName,
        this.categoryId,
        this.name,
        this.desc,
        this.price,
        this.area,
        this.address,
        this.lat,
        this.long,
        this.city,
        this.adsOwner,
        this.commenets,
        this.images,
        this.terms,
        this.families,
        this.insurance,
        this.privateHouse,
        this.sharedAccommodation,
        this.animals,
        this.visits,
        this.bedRoom,
        this.bathrooms,
        this.council,
        this.kitchenTable,
        this.favourite,
        this.isMine,
        this.date,
        this.rate,
        this.offer,
        this.token,
        this.totalPrice});

  Favourites.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    sellerImage = json['sellerImage'].toString();
    streetId = json['street_id'];
    categoryName = json['categoryName'];
    categoryId = json['category_id'].toString();
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    area = json['area'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    city = json['city'];
    adsOwner = json['AdsOwner'];
    token = json['token'];
    if (json['commenets'] != null) {
      commenets = <Commenets>[];
      json['commenets'].forEach((v) {
        commenets!.add(new Commenets.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(new Terms.fromJson(v));
      });
    }
    if (json['Accompanying'] != null) {
      accompanying = <Accompanying>[];
      json['Accompanying'].forEach((v) {
        accompanying!.add(new Accompanying.fromJson(v));
      });
    }
    families = json['families'];
    insurance = json['insurance'];
    privateHouse = json['private_house'];
    sharedAccommodation = json['Shared_accommodation'];
    animals = json['animals'];
    visits = json['visits'];
    bedRoom = json['bed_room'];
    bathrooms = json['Bathrooms'];
    council = json['council'];
    kitchenTable = json['kitchen_table'];
    favourite = json['favourite'];
    isMine = json['isMine'];
    date = json['date'];
    rate = json['rate'];
    offer = json['offer'].toString();
    totalPrice = json['totalPrice'].toString();
    currency = json['currency'].toString();
    insuranceValue = json['insurance_value'].toString();
    smoking = json['smoking'].toString();
    individual = json['individual'].toString();
    additionValue = json['addition_value'].toString();
    commenetCounts = json['commenetCounts'].toString();
    ticket_count = json['ticket_count'].toString();
    from = json['from'].toString();
    to = json['to'].toString();
    hour_work = json['hour_work'].toString();
    group_travel = json['group_travel'].toString();
    travel_type = json['travel_type'].toString();
    country = json['country'].toString();
    iban = json['iban'].toString();
    language = json['language'].toString();
    passengers = json['passengers'].toString();
    license_number = json['license_number'].toString();
    moodle = json['moodle'].toString();
    guide_image = json['guide_image'].toString();
    national_image = json['national_image'].toString();
    license_image = json['license_image'].toString();
    hour_price = json['hour_price'].toString();
    driverName = json['driverName'].toString();
  }
}

class Commenets {
  String? name;
  String? commenet;
  String? rate;
  String? createdAt;

  Commenets({this.name, this.commenet, this.rate, this.createdAt});

  Commenets.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    commenet = json['commenet'];
    rate = json['rate'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['commenet'] = this.commenet;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Images {
  String? image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Terms {
  String? term;

  Terms({this.term});

  Terms.fromJson(Map<String, dynamic> json) {
    term = json['term'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term'] = this.term;
    return data;
  }
}
