import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:http/http.dart' as http;

import '../constants/api_paths.dart';

class CheckCodeController {
  static double? discount;
  static Future<bool> checkCode(coupon) async {
    try {
      var url = ApiPath.baseurl + ApiPath.addCouponPath;
      http.Response res = await http.post(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? '',
        'lang': CurrentUser.languageId
      }, body: {
        'coupon': coupon,
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      // ordersModel = OrdersModel.fromJson(resbody);
      discount = double.tryParse(resbody['data']['discount']);
      toastShow(text: resbody['message']);
      return resbody['status'];
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
