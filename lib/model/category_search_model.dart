// import 'comments_model.dart';
//
// class CategorySearchModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   CategorySearchModel({this.status, this.message, this.data});
//
//   CategorySearchModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<AdsSearch>? ads;
//
//   Data({this.ads});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['ads'] != null) {
//       ads = <AdsSearch>[];
//       json['ads'].forEach((v) {
//         ads!.add(new AdsSearch.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.ads != null) {
//       data['ads'] = this.ads!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Accompanying {
//   String? name;
//   int? status;
//
//   Accompanying({this.name, this.status});
//
//   Accompanying.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class AdsSearch {
//   String? id;
//   String? token;
//   String? streetId;
//   String? categoryName;
//   String? categoryId;
//   String? name;
//   String? desc;
//   String? price;
//   String? totalPrice;
//   String? area;
//   String? currency;
//   String? lat;
//   String? long;
//   String? city;
//   String? adsOwner;
//   String? sellerImage;
//   List<Commenets>? commenets;
//   List<Images>? images;
//   List<Terms>? terms;
//   String? additionValue;
//   String? families;
//   String? insurance;
//   String? privateHouse;
//   String? sharedAccommodation;
//   String? animals;
//   String? visits;
//   String? bedRoom;
//   String? bathrooms;
//   String? council;
//   String? kitchenTable;
//   String? insuranceValue;
//   String? smoking;
//   String? individual;
//   bool? favourite;
//   bool? isMine;
//   String? date;
//   String? rate;
//   String? offer;
//   String? from;
//   String? to;
//   String? hour_work;
//
//   List<Accompanying>? accompanying;
//
//
//   AdsSearch(
//       {this.id,
//         this.streetId,
//         this.hour_work,
//         this.from,
//         this.to,
//         this.categoryName,
//         this.accompanying,
//         this.categoryId,
//         this.name,
//         this.desc,
//         this.price,
//         this.totalPrice,
//         this.area,
//         this.currency,
//         this.lat,
//         this.long,
//         this.city,
//         this.adsOwner,
//         this.token,
//         this.sellerImage,
//         this.commenets,
//         this.images,
//         this.terms,
//         this.additionValue,
//         this.families,
//         this.insurance,
//         this.privateHouse,
//         this.sharedAccommodation,
//         this.animals,
//         this.visits,
//         this.bedRoom,
//         this.bathrooms,
//         this.council,
//         this.kitchenTable,
//         this.insuranceValue,
//         this.smoking,
//         this.individual,
//         this.favourite,
//         this.isMine,
//         this.date,
//         this.rate,
//         this.offer});
//
//   AdsSearch.fromJson(Map<String, dynamic> json) {
//     id = json['id'].toString();
//     streetId = json['street_id'];
//     categoryName = json['categoryName'];
//     categoryId = json['category_id'].toString();
//     name = json['name'];
//     desc = json['desc'];
//     price = json['price'];
//     totalPrice = json['totalPrice'].toString();
//     area = json['area'];
//     currency = json['currency'];
//     lat = json['lat'];
//     long = json['long'];
//     city = json['city'];
//     adsOwner = json['AdsOwner'];
//     token = json['token'];
//     sellerImage = json['sellerImage'];
//     if (json['commenets'] != null) {
//       commenets = <Commenets>[];
//       json['commenets'].forEach((v) {
//         commenets!.add(new Commenets.fromJson(v));
//       });
//     }
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     if (json['terms'] != null) {
//       terms = <Terms>[];
//       json['terms'].forEach((v) {
//         terms!.add(new Terms.fromJson(v));
//       });
//     }
//     if (json['Accompanying'] != null) {
//       accompanying = <Accompanying>[];
//       json['Accompanying'].forEach((v) {
//         accompanying!.add(new Accompanying.fromJson(v));
//       });
//     }
//     additionValue = json['addition_value'];
//     families = json['families'];
//     insurance = json['insurance'];
//     privateHouse = json['private_house'];
//     sharedAccommodation = json['Shared_accommodation'];
//     animals = json['animals'];
//     visits = json['visits'];
//     bedRoom = json['bed_room'];
//     bathrooms = json['Bathrooms'];
//     council = json['council'];
//     kitchenTable = json['kitchen_table'];
//     insuranceValue = json['insurance_value'];
//     smoking = json['smoking'];
//     individual = json['individual'];
//     favourite = json['favourite'];
//     isMine = json['isMine'];
//     date = json['date'];
//     rate = json['rate'];
//     offer = json['offer'].toString();
//     from = json['from'].toString();
//     to = json['to'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['street_id'] = this.streetId;
//     data['categoryName'] = this.categoryName;
//     data['category_id'] = this.categoryId;
//     data['name'] = this.name;
//     data['desc'] = this.desc;
//     data['price'] = this.price;
//     data['totalPrice'] = this.totalPrice;
//     data['area'] = this.area;
//     data['currency'] = this.currency;
//     data['lat'] = this.lat;
//     data['long'] = this.long;
//     data['city'] = this.city;
//     data['AdsOwner'] = this.adsOwner;
//     data['token'] = this.token;
//     data['sellerImage'] = this.sellerImage;
//     if (this.commenets != null) {
//       data['commenets'] = this.commenets!.map((v) => v.toJson()).toList();
//     }
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     if (this.terms != null) {
//       data['terms'] = this.terms!.map((v) => v.toJson()).toList();
//     }
//     data['addition_value'] = this.additionValue;
//     data['families'] = this.families;
//     data['insurance'] = this.insurance;
//     data['private_house'] = this.privateHouse;
//     data['Shared_accommodation'] = this.sharedAccommodation;
//     data['animals'] = this.animals;
//     data['visits'] = this.visits;
//     data['bed_room'] = this.bedRoom;
//     data['Bathrooms'] = this.bathrooms;
//     data['council'] = this.council;
//     data['kitchen_table'] = this.kitchenTable;
//     data['insurance_value'] = this.insuranceValue;
//     data['smoking'] = this.smoking;
//     data['individual'] = this.individual;
//     data['favourite'] = this.favourite;
//     data['isMine'] = this.isMine;
//     data['date'] = this.date;
//     data['rate'] = this.rate;
//     data['offer'] = this.offer;
//     data['from'] = this.from;
//     data['to'] = this.to;
//     data['hour_work'] = this.hour_work;
//     return data;
//   }
// }
//
// class Images {
//   String? image;
//
//   Images({this.image});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     return data;
//   }
// }
//
// class Terms {
//   String? term;
//
//   Terms({this.term});
//
//   Terms.fromJson(Map<String, dynamic> json) {
//     term = json['term'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['term'] = this.term;
//     return data;
//   }
// }
