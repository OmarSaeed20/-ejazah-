import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/model/event_type_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../constants/api_paths.dart';
import '../model/gideType_model.dart';
import '../model/languages_model.dart';
import '../model/marketing_type_model.dart';
import '../model/travel_country_model.dart';
import '../model/travel_type_model.dart';
import 'add_service_controller/add_ads_controller.dart';

class AddInformationTravelGroupsController {
  static EventTypeModel? eventTypeModel;
  static TravelTypeModel? travelTypeModel;

  static GideTypeModel? gideTypeModel;
  static LanguagesModel? languagesModel;

  static TravelCountryModel? travelCountryModel;
  static MarketingTypeModel? marketingTypeModel;

  static void clearData() {
    travel_country_id = null;
    travel_name = null;
    group_travel = null;
    indivdual_travel = null;
    event_name = null;
    car_name = null;
    from = null;
    to = null;
    language_id = null;
    license_number = null;
    national_image = null;
    license_image = null;
    images = null;
    travel_type_id = null;
    price = null;
    desc = null;
    iban = null;
    terms = [];
    name = null;
    lat = null;
    long = null;
    address = null;
    guide_image = null;
    moodle = null;
    AddAdsController.lat = '';
    AddAdsController.long = '';
    AddAdsController.city_id = '';
    AddAdsController.street_id = '';
    hour_work = '';
    to_hours = '';
    from_hours = '';
  }

  // req data
  static List<XFile>? images;
  static String? travel_type_id;
  static String? travel_name;
  static String? event_name;
  static String? car_name;
  static String? moodle;
  static String city_id = AddAdsController.city_id;
  static String street_id = AddAdsController.street_id;
  static String? price;
  static String? desc;
  static String? iban;
  static List<String> terms = [];
  // unReq data
  static String? travel_country_id;
  static bool? group_travel;
  static bool? indivdual_travel;
  static String? from;
  static String? to;
  static String? language_id;
  static String? license_number;
  static String? name, lat, long, address;
  static XFile? national_image;
  static XFile? license_image;
  static XFile? guide_image;
  static String? hour_work;
  static String? ticket_count;
  static String? passengers;
  static int? back;
  static int? go;
  static int? main_meal;
  static int? housing_included;
  static int? Tour_guide_included;
  static int? breakfast;
  static int? lunch;
  static int? dinner;
  static String? count_days;
  static String? to_hours;
  static String? from_hours;

  static Future<bool> addTravel() async {
    print("travel_type_id  ---> ${travel_type_id}");
    print(travel_type_id);
    print("city");
    print(city_id.toString());
    try {
      var url = ApiPath.baseurl + ApiPath.addServicePath;
      List<MultipartFile> postImages = [];

      if (images != null) {
        for (var element in images!) {
          postImages.add(await MultipartFile.fromFile(element.path));
        }
      }

      FormData body = FormData.fromMap({
        'name': name,
        'lat': lat,
        'long': long,
        'address': address,
        'travel_country_id': travel_country_id,
        'event_name': event_name,
        'travel_name': travel_name,
        'car_name': car_name,
        "ticket_count": ticket_count,
        'city_id': city_id,
        'street_id': street_id,
        'group_travel':
            group_travel != null ? (group_travel! ? '1' : '0') : null,
        'indivdual_travel':
            indivdual_travel != null ? (indivdual_travel! ? '1' : '0') : null,
        'from': from,
        'to': to,
        'language_id': language_id,
        'license_number': license_number,
        'national_image': national_image != null
            ? await MultipartFile.fromFile(national_image!.path)
            : null,
        'license_image': license_image != null
            ? await MultipartFile.fromFile(license_image!.path)
            : null,
        'guide_image': guide_image != null
            ? await MultipartFile.fromFile(guide_image!.path)
            : null,
        'travel_type_id': travel_type_id,
        'price': price,
        'desc': desc,
        'iban': iban,
        'images[]': postImages,
        'terms[]': terms,
        'category_id': AddAdsController.category_id,
        'moodle': moodle,
        'passengers': passengers,
        'back': back,
        'go': go,
        'main_meal': main_meal,
        'housing_included': housing_included,
        'Tour_guide_included': Tour_guide_included,
        'breakfast': breakfast,
        'lunch': lunch,
        'dinner': dinner,
        'count_days': count_days,
        'hour_work': hour_work,
        'to_hours': to_hours,
        'from_hours': from_hours,
      });
      final res = await Dio().post(url,
          data: body,
          options: Options(headers: {
            'Content-Type':
                'multipart/form-data; boundary=<calculated when request is sent>',
            'Authorization': CurrentUser.token ?? '',
            'lang': CurrentUser.languageId,
          }));
      if (res.data.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = res.data;
      print(resbody);
      eventTypeModel = EventTypeModel.fromJson(resbody);
      toastShow(text: eventTypeModel!.message!);
      return eventTypeModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> getEventType() async {
    try {
      var url = ApiPath.baseurl + ApiPath.event_typePath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'lang': CurrentUser.languageId,
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      eventTypeModel = EventTypeModel.fromJson(resbody);
      if (!eventTypeModel!.status!) toastShow(text: eventTypeModel!.message!);
      return eventTypeModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> getTravelType() async {
    try {
      var url = ApiPath.baseurl + ApiPath.travel_typePath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'lang': CurrentUser.languageId,
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      travelTypeModel = TravelTypeModel.fromJson(resbody);
      if (!travelTypeModel!.status!) toastShow(text: travelTypeModel!.message!);
      return travelTypeModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> getTravelCountry() async {
    try {
      var url = ApiPath.baseurl + ApiPath.travel_countryPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'lang': CurrentUser.languageId,
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      travelCountryModel = TravelCountryModel.fromJson(resbody);
      if (!travelCountryModel!.status!)
        toastShow(text: travelCountryModel!.message!);
      return travelCountryModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> getGideType() async {
    try {
      var url = ApiPath.baseurl + ApiPath.gide_typePath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'lang': CurrentUser.languageId,
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      gideTypeModel = GideTypeModel.fromJson(resbody);
      if (!gideTypeModel!.status!) toastShow(text: gideTypeModel!.message!);
      return gideTypeModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> getLanguages() async {
    try {
      var url = ApiPath.baseurl + ApiPath.languagesPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'lang': CurrentUser.languageId,
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      languagesModel = LanguagesModel.fromJson(resbody);
      if (!languagesModel!.status!) toastShow(text: languagesModel!.message!);
      return languagesModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> getMarketingType() async {
    try {
      var url = ApiPath.baseurl + ApiPath.markiting_typePath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'lang': CurrentUser.languageId,
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      marketingTypeModel = MarketingTypeModel.fromJson(resbody);
      if (!marketingTypeModel!.status!)
        toastShow(text: marketingTypeModel!.message!);
      return marketingTypeModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
