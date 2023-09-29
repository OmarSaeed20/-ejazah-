import 'package:ejazah/database/local/cache_helper.dart';

class CurrentUser {
  static String? id;
  static String? token;
  static String? deviceToken;
  static String? name;
  static String? email;
  static String? countryName;
  static String languageId = '1';
  static String? phone;
  static String? password;
  static String? confirmPassword;
  static String? link;
  static String? image;
  static String? country;
  static String? cityId;
  static String countryId = '2';
  static String? birth_date;
  static String? nationality;
  static String? gender = '1';
  static String? currency;
  static String? OTP;

  static Map toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'confirm_password': confirmPassword,
        'country_id': countryId.toString(),
        // 'languageId': languageId,
        'device_token': deviceToken,
        'nationality': nationality,
        'gender': gender,
        'birth_date': birth_date,
      };

  Future<void> saveUserData() async {
    await CacheHelper.saveData(key: 'id', value: id ?? '');
    await CacheHelper.saveData(key: 'name', value: name ?? '');
    await CacheHelper.saveData(key: 'nationality', value: nationality ?? '');
    await CacheHelper.saveData(key: 'gender', value: gender ?? '');
    await CacheHelper.saveData(key: 'birth_date', value: birth_date ?? '');
    await CacheHelper.saveData(key: 'email', value: email ?? '');
    await CacheHelper.saveData(key: 'phone', value: phone ?? '');
    await CacheHelper.saveData(key: 'link', value: link ?? '');
    await CacheHelper.saveData(key: 'image', value: image ?? '');
    await CacheHelper.saveData(key: 'country', value: country ?? '');
    await CacheHelper.saveData(key: 'token', value: token ?? '');
    await CacheHelper.saveData(key: 'isUserDateSaved', value: true);
    await CacheHelper.saveData(key: 'gender', value: gender ?? '');
    await CacheHelper.saveData(key: 'nationality', value: nationality ?? '');
    await CacheHelper.saveData(key: 'birth_date', value: birth_date ?? '');
    await CacheHelper.saveData(key: 'country', value: country ?? '');
    await CacheHelper.saveData(key: 'currency', value: currency ?? '');
    print('saved');
  }

  static void getUserData() {
    id = CacheHelper.getData(key: 'id');
    name = CacheHelper.getData(key: 'name');
    email = CacheHelper.getData(key: 'email');
    phone = CacheHelper.getData(key: 'phone');
    link = CacheHelper.getData(key: 'link');
    image = CacheHelper.getData(key: 'image');
    country = CacheHelper.getData(key: 'country');
    token = CacheHelper.getData(key: 'token');
    gender = CacheHelper.getData(key: 'gender');
    nationality = CacheHelper.getData(key: 'nationality');
    birth_date = CacheHelper.getData(key: 'birth_date');
    country = CacheHelper.getData(key: 'country');
    currency = CacheHelper.getData(key: 'currency');
  }

  CurrentUser.fromJson(Map json) {
    id = json["id"].toString();
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    link = json["link"];
    image = json["image"];
    country = json["country"];
    token = json['token'];
    gender = json['gender'];
    nationality = json['nationality'];
    birth_date = json['birth_date'];
    country = json['country'];
    currency = json['currency'];
    saveUserData();
  }

  static clearUser() async {
    await CacheHelper.clearData(key: 'id');
    await CacheHelper.clearData(key: 'name');
    await CacheHelper.clearData(key: 'nationality');
    await CacheHelper.clearData(key: 'gender');
    await CacheHelper.clearData(key: 'birth_date');
    await CacheHelper.clearData(key: 'email');
    await CacheHelper.clearData(key: 'phone');
    await CacheHelper.clearData(key: 'link');
    await CacheHelper.clearData(key: 'image');
    await CacheHelper.clearData(key: 'country');
    await CacheHelper.clearData(key: 'token');
    await CacheHelper.clearData(key: 'isUserDateSaved');
    await CacheHelper.clearData(key: 'gender');
    await CacheHelper.clearData(key: 'nationality');
    await CacheHelper.clearData(key: 'birth_date');
    await CacheHelper.clearData(key: 'country');
    await CacheHelper.clearData(key: 'currency');
  }
}
