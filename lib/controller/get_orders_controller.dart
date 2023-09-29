import 'dart:convert';
import 'dart:developer';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';
import '../model/get_order_model.dart';

class GetOrdersController {
  static OrdersModel? ordersModel;

  static Future<bool> getOrders() async {
    print(CurrentUser.token);
    try {
      var url = ApiPath.baseurl + ApiPath.getOrdersPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token??'',
        'lang': CurrentUser.languageId
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      ordersModel = OrdersModel.fromJson(resbody);
      if (!ordersModel!.status!) toastShow(text: ordersModel!.message!);
      return ordersModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
  static String? lastWord, lastDate;
  static Future<bool> searchOrders({String? word, String? date}) async {

    if (word != null) lastWord = word;
    try {
      final String url = ApiPath.baseurl + ApiPath.searchOrdersPath;


      http.Response res = await http.post(
          Uri.parse(url), headers: {
        'Authorization': CurrentUser.token??'',
        'lang': CurrentUser.languageId,
      },
        body: {
            'date':date??'',
            'word':word??'',
        }
      );
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      log(res.body);
      ordersModel = OrdersModel.fromJson(resbody);
      if (!ordersModel!.status!) toastShow(text: ordersModel!.message!);
      return ordersModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
