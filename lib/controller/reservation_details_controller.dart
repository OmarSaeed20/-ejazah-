
import 'dart:convert';
import 'dart:developer';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';

// 3 , 4 , 5 , 7
class ReservationController {
  static Future<bool> addOrder({
    required String count,
    required String house_id,
    required String from,
    required String to,
    required String payment_type,
    required String? coupon,
    String? passengers = "1",
    String? city_id,
    String? street_id,
    String? address,
    String? lat,
    String? lng,
  }) async {
    try {
      var url = ApiPath.baseurl + ApiPath.orderPath;
      http.Response res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': CurrentUser.token ?? '',
        },
        body: {
          'count': count,
          'house_id': house_id,
          'from': from,
          'to': to,
          'payment_type': payment_type,
          'coupon': coupon,
          "passengers": passengers,
          "status": "1",
          "city_id": city_id,
          "street_id": street_id,
          "address": address,
          "lat": lat.toString(),
          "long": lng.toString(),
        },
      );
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      toastShow(text: resbody['message']);
      return resbody['status'];
    } catch (e) {
      log(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> walletPayment({required String price}) async {
    try {
      var url = ApiPath.baseurl + "walletPayment";
      http.Response res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': CurrentUser.token ?? '',
        },
        body: {
          'price': price,
        },
      );
      if (res.body.isEmpty) {
        // toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      // toastShow(text: resbody['message']);
      return resbody['status'];
    } catch (error) {
      log(error.toString());
      // toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
