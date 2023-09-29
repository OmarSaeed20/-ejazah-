import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';
import '../../model/payment_methods_model.dart';

class GetPaymentMethods {
  static GetPaymentMethodsModel? getPaymentMethods;

  static Future<bool> getPaymentMethodsFunction() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getPaymentPath;
      http.Response res = await http.get(Uri.parse(url));

      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);
      getPaymentMethods = GetPaymentMethodsModel.fromJson(resbody);
      log("----> ${resbody}");
      if (!getPaymentMethods!.status!)
        Fluttertoast.showToast(
            msg: getPaymentMethods!.message!, toastLength: Toast.LENGTH_SHORT);

      if (getPaymentMethods!.status == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: getPaymentMethods!.message!, toastLength: Toast.LENGTH_SHORT);
        return false;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }
}
