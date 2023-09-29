class GetFavouriteModel {
  bool? status;
  String? message;
  Data? data;

  GetFavouriteModel({this.status, this.message, this.data});

  GetFavouriteModel.fromJson(Map<String, dynamic> json) {
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
  List<Categories>? categories;
  List<Favourites>? favourites;

  Data({this.categories, this.favourites});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['favourites'] != null) {
      favourites = <Favourites>[];
      json['favourites'].forEach((v) {
        favourites!.add(new Favourites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.favourites != null) {
      data['favourites'] = this.favourites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? name;
  String? image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
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

class Favourites {
  dynamic id;
  String? categoryName;
  String? categoryId;
  String? name;
  String? desc;
  String? price;
  String? area;
  String? address;
  String? lat;
  String? long;
  String? city;
  String? adsOwner;
  String? token;
  String? sellerImage;
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
  dynamic rate;
  String? commenetCounts;
  dynamic offer;
  String? totalPrice;

  Favourites(
      {this.id,
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
      this.token,
      this.sellerImage,
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
      this.commenetCounts,
      this.offer,
      this.totalPrice});

  Favourites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    sellerImage = json['sellerImage'];
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
    commenetCounts = json['commenetCounts'].toString();
    offer = json['offer'];
    totalPrice = json['totalPrice'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['area'] = this.area;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['city'] = this.city;
    data['AdsOwner'] = this.adsOwner;
    data['token'] = this.token;
    data['sellerImage'] = this.sellerImage;
    if (this.commenets != null) {
      data['commenets'] = this.commenets!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.terms != null) {
      data['terms'] = this.terms!.map((v) => v.toJson()).toList();
    }
    data['families'] = this.families;
    data['insurance'] = this.insurance;
    data['private_house'] = this.privateHouse;
    data['Shared_accommodation'] = this.sharedAccommodation;
    data['animals'] = this.animals;
    data['visits'] = this.visits;
    data['bed_room'] = this.bedRoom;
    data['Bathrooms'] = this.bathrooms;
    data['council'] = this.council;
    data['kitchen_table'] = this.kitchenTable;
    data['favourite'] = this.favourite;
    data['isMine'] = this.isMine;
    data['date'] = this.date;
    data['rate'] = this.rate;
    data['commenetCounts'] = this.commenetCounts;
    data['offer'] = this.offer;
    data['totalPrice'] = this.totalPrice;
    return data;
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
