class CategoryModel {
  bool? status;
  String? message;
  Data? data;

  CategoryModel({this.status, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Ads>? ads;

  Data({this.ads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add(new Ads.fromJson(v));
      });
    }
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

class Ads {
  String? travel_type;
  String? language;
  String? country;
  int? id;
  String? area;
  dynamic streetId;
  String? street_name;
  String? license_number;
  String? categoryName;
  String? categoryId;
  String? name;
  String? desc;
  String? price;
  String? totalPrice;
  String? currency;
  List<Accompanying>? accompanying;
  String? lat;
  String? long;
  String? city;
  String? adsOwner;
  String? national_image;
  String? license_image;
  String? sellerImage;
  String? token;
  List<Commenets>? commenets;
  List<Images>? images;
  List<Terms>? terms;
  String? families;
  String? insurance;
  String? privateHouse;
  String? sharedAccommodation;
  String? animals;
  String? visits;
  String? group_travel;
  String? bedRoom;
  String? bathrooms;
  String? council;
  String? kitchenTable;
  String? insuranceValue;
  String? smoking;
  String? individual;
  String? main_meal;
  String? breakfast;
  String? lunch;
  String? dinner;
  String? go;
  String? back;
  String? count_days;
  String? travel_name;
  dynamic rate;
  int? rate_count;
  dynamic passengers;
  String? from;
  String? to;
  String? iban;
  String? hour_work;
  String? to_hours;
  String? from_hours;
  String? ticket_count;
  String? additionValue;
  bool? favourite;
  bool? isMine;
  String? date;
  dynamic commenetCounts;
  int? offer;
  String? driverName;
  String? ads_user_name;
  String? ads_user_id;
  String? address;
  String? order_address;
  String? is_pay;
  String? moodle;
  String? guide_image;
  String? hour_price;
  String? payment_type;
  String? payment_icon;
  String? documentation;
  String? car_type;
  bool isSelected = false;
  // List<RateUsers>? rate_users;

  Ads({
    this.id,
    this.moodle,
    this.isSelected = false,
    this.guide_image,
    this.back,
    this.go,
    this.payment_type,
    this.payment_icon,
    this.main_meal,
    this.count_days,
    this.ads_user_id,
    this.ads_user_name,
    this.lunch,
    this.dinner,
    this.breakfast,
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
    this.travel_name,
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
    this.order_address,
    this.lat,
    this.long,
    this.city,
    this.is_pay,
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
    this.totalPrice,
    this.street_name,
    // this.rate_users,
    this.rate_count,
    this.to_hours,
    this.from_hours,
    this.documentation,
    this.car_type,
  });

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerImage = json['sellerImage'].toString();
    streetId = json['street_id'];
    categoryName = json['categoryName'].toString();
    categoryId = json['category_id'].toString();
    street_name = json['street_name'].toString();
    name = json['name'].toString();
    desc = json['desc'].toString();
    back = json['back'].toString();
    go = json['go'].toString();
    main_meal = json['main_meal'].toString();
    lunch = json['lunch'].toString();
    dinner = json['dinner'].toString();
    breakfast = json['breakfast'].toString();
    price = json['price'].toString();
    area = json['area'].toString();
    address = json['address'].toString();
    order_address = json['order_address'].toString();
    ads_user_id = json['ads_user_id'].toString();
    ads_user_name = json['ads_user_name'].toString();
    lat = json['lat'];
    long = json['long'];
    city = json['city'];
    adsOwner = json['AdsOwner'].toString();
    token = json['token'].toString();
    is_pay = json['is_pay'].toString();
    rate_count = json['rate_count'];
    // if (json['rate_users'] != null) {
    //   rate_users = <RateUsers>[];
    //   json['rate_users'].forEach((element) {
    //     return rate_users!.add(new RateUsers.fromJson(element));
    //   });
    // }

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
    families = json['families'].toString();
    insurance = json['insurance'].toString();
    privateHouse = json['private_house'].toString();
    sharedAccommodation = json['Shared_accommodation'].toString();
    animals = json['animals'].toString();
    visits = json['visits'].toString();
    bedRoom = json['bed_room'].toString();
    bathrooms = json['Bathrooms'].toString();
    council = json['council'].toString();
    kitchenTable = json['kitchen_table'].toString();
    favourite = json['favourite'];
    isMine = json['isMine'];
    date = json['date'].toString();
    rate = json['rate'].toString();
    offer = json['offer'];
    totalPrice = json['totalPrice'].toString();
    currency = json['currency'].toString();
    insuranceValue = json['insurance_value'].toString();
    smoking = json['smoking'].toString();
    individual = json['individual'].toString();
    additionValue = json['addition_value'].toString();
    commenetCounts = json['commenetCounts'];
    ticket_count = json['ticket_count'].toString();
    from = json['from'].toString();
    to = json['to'].toString();
    hour_work = json['hour_work'].toString();
    group_travel = json['group_travel'].toString();
    travel_type = json['travel_type'].toString();
    travel_name = json['travel_name'].toString();
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
    count_days = json['count_days'].toString();
    payment_type = json['payment_type'].toString();
    payment_icon = json['payment_icon'].toString();
    to_hours = json['to_hours'].toString();
    from_hours = json['from_hours'].toString();
    documentation = json['documentation'].toString();
    car_type = json['car_type'].toString();
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
}

class Images {
  String? image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }
}

class Terms {
  String? term;

  Terms({this.term});

  Terms.fromJson(Map<String, dynamic> json) {
    term = json['term'];
  }
}

class RateUsers {
  final String? id;
  final String? rate;
  final String? userId;
  final String? housingsId;
  final String? createdAt;
  final String? updatedAt;
  const RateUsers(
      {this.id,
      this.rate,
      this.userId,
      this.housingsId,
      this.createdAt,
      this.updatedAt});
  RateUsers copyWith(
      {String? id,
      String? rate,
      String? userId,
      String? housingsId,
      String? createdAt,
      String? updatedAt}) {
    return RateUsers(
        id: id ?? this.id,
        rate: rate ?? this.rate,
        userId: userId ?? this.userId,
        housingsId: housingsId ?? this.housingsId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rate': rate,
      'user_id': userId,
      'housings_id': housingsId,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  factory RateUsers.fromJson(Map<String, dynamic> json) {
    return RateUsers(
        id: json['id'] == null ? null : json['id'] as String,
        rate: json['rate'] == null ? null : json['rate'] as String,
        userId: json['user_id'] == null ? null : json['user_id'] as String,
        housingsId:
            json['housings_id'] == null ? null : json['housings_id'] as String,
        createdAt:
            json['created_at'] == null ? null : json['created_at'] as String,
        updatedAt:
            json['updated_at'] == null ? null : json['updated_at'] as String);
  }
}
