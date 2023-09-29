import 'package:dio/dio.dart';
import 'package:ejazah/components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/api_paths.dart';
import '../auth/user_controller.dart';

class AddAdsController {
  static String category_id = '4';
  // static String country_id = CurrentUser.countryId;
  static String city_id = '';
  static String street_id = '';
  static String title = '';
  static String desc = '';
  static String area = '';
  static String price = '';
  static String insurance_value = '';
  static String lat = '';
  static String long = '';
  static int insurance = 0;
  static int private_house = 0;
  static int Shared_accommodation = 0;
  static int council = 0;
  static String kitchen_table = '0';
  static String bed_room = '';
  static String Bathrooms = '';
  static List<XFile> images = [];
  static List<String> terms = [];
  static int families = 0;
  static int individual = 0;
  static int camp = 1;
  static int chalets = 0;
  static int visits = 0;
  static int animals = 0;
  static int smoking = 0;
  static List<int> accompanying = [];

  static Future<bool> addAds() async {
    print(bed_room);
    try {
      List<MultipartFile> postImages = [];
      for (var element in images) {
        postImages.add(await MultipartFile.fromFile(element.path));
      }
      String url = ApiPath.baseurl + ApiPath.addServicePath;

      FormData body = FormData.fromMap({
        'category_id': category_id,
        'city_id': city_id,
        'street_id': street_id,
        'title': title,
        'desc': desc,
        'area': area,
        'price': price,
        //'address': address,//
        'lat': lat,
        'long': long,
        'insurance': insurance,
        'private_house': private_house,
        'Shared_accommodation': Shared_accommodation,
        'animals': animals,
        'council': council,
        'kitchen_table': kitchen_table,
        'visits': visits,
        'bed_room': bed_room,
        'Bathrooms': Bathrooms,
        'images[]': postImages,
        'terms[]': terms,
        'families': families,
        'insurance_value': insurance_value,
        'individual': individual,
        'smoking': smoking,
        'camp': camp,
        'chalets': chalets,
        'accompanying[]': accompanying,
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
      print(resbody['message']);
      Fluttertoast.showToast(
          msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
      return resbody['status'];
    } catch (e) {
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static void clearData() {
    category_id = '4';
    city_id = '';
    street_id = '';
    title = '';
    desc = '';
    area = '';
    price = '';
    insurance_value = '';
    lat = '';
    long = '';
    insurance = 0;
    private_house = 0;
    Shared_accommodation = 0;
    council = 0;
    kitchen_table = '0';
    bed_room = '';
    Bathrooms = '';
    images = [];
    terms = [];
    families = 0;
    individual = 0;
    camp = 1;
    chalets = 0;
    visits = 0;
    animals = 0;
    smoking = 0;
    accompanying = [];
  }

  static bool isAddressInfoScreenValid() {
    if (title == '' || desc == '' || area == '') {
      toastShow(text: 'برجاء اكمال البيانات', state: ToastStates.black);
      return false;
    }
    String testText = title.removeAllWhitespace;
    if (testText.length < 5) {
      toastShow(
          text: validTextLen('عنوان الأعلان', 5), state: ToastStates.black);
      return false;
    }
    testText = desc.removeAllWhitespace;
    if (testText.length < 5) {
      toastShow(
          text: validTextLen('وصف عن الأعلان', 5), state: ToastStates.black);
      return false;
    }
    testText = area;
    try {
      if (int.parse(testText) > 1000) {
        toastShow(text: 'خطأ في مساحة السكن!', state: ToastStates.black);
        return false;
      }
    } catch (e) {
      toastShow(
          text: validText('مساحة السكن التقريبية بالمتر'),
          state: ToastStates.black);
      return false;
    }
    return true;
  }

  static bool isChooseYourAddressScreenValid() {
    if (city_id == '' || street_id == '' || lat == '' || long == '') {
      toastShow(text: 'برجاء اكمال البايانات', state: ToastStates.black);
      return false;
    }

    return true;
  }

  static bool isTa2menScreenValid() {
    if (price == '') {
      toastShow(
          text: 'ادخل سعر الليلة بالريال السعودي', state: ToastStates.black);
      return false;
    }
    try {
      if (int.parse(price) < 0) {
        toastShow(
            text: 'لا يمكن أن يكون السعر بالسالب!', state: ToastStates.black);
        return false;
      }
    } catch (e) {
      toastShow(text: validText('السعر'));
      return false;
    }
    if (insurance_value == '' && insurance == 1) {
      toastShow(text: 'أدخل قيمة التأمين', state: ToastStates.black);
      return false;
    }
    if (insurance == 1)
      try {
        if (int.parse(insurance_value) < 0 && insurance == 1) {
          toastShow(
              text: 'لا يمكن أن يكون قيمة التأمين!', state: ToastStates.black);
          return false;
        }
      } catch (e) {
        toastShow(text: validText('قيمة التأمين'));
        return false;
      }
    return true;
  }

  static final ImagePicker picker = ImagePicker();

  static Future getAdsImages() async {
    images = await picker.pickMultiImage();
  }

  static bool isMorafeqValid() {
    if (bed_room == '' || Bathrooms == '' || kitchen_table == '') {
      toastShow(text: 'برجاء اكمال البيانات', state: ToastStates.black);
      return false;
    }
    try {
      int bed = int.parse(bed_room);
      int bath = int.parse(Bathrooms);
      int kit = int.parse(kitchen_table);
      if (bed < 0) {
        toastShow(
            text: validTextLen(bed.toString(), 0), state: ToastStates.black);
        return false;
      } else if (bath < 0) {
        toastShow(
            text: validTextLen(bath.toString(), 0), state: ToastStates.black);
        return false;
      } else if (kit < 0) {
        toastShow(
            text: validTextLen(kit.toString(), 0), state: ToastStates.black);
        return false;
      }
    } catch (e) {
      toastShow(text: 'العدد يتطلب ارقام فقط', state: ToastStates.black);
      return false;
    }
    return true;
  }
}
