import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/model/wheel_spin_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import '../../constants/api_paths.dart';

class WheelSpinController {
  static WheelSpinModel? wheelSpinModel;
  static BehaviorSubject<int> selected = BehaviorSubject<int>();

  static Future<bool> getWheel() async {
    try {
      var url = ApiPath.baseurl + ApiPath.wheel_of_fortunesPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? '',
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);
      wheelSpinModel = WheelSpinModel.fromJson(resbody);
      log(wheelSpinModel!.toJson().toString());
      if (!wheelSpinModel!.status!)
        Fluttertoast.showToast(
            msg: wheelSpinModel!.message!, toastLength: Toast.LENGTH_SHORT);

      if (wheelSpinModel!.status == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: wheelSpinModel!.message!, toastLength: Toast.LENGTH_SHORT);
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

  static Future<bool> postWheel(String id) async {
    try {
      var url = ApiPath.baseurl + ApiPath.addWheelPath;
      http.Response res = await http.post(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? '',
      }, body: {
        'wheel_id': id,
      });
      /*  if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      } */
      var resbody;
      resbody = json.decode(res.body);
      // wheelSpinModel = WheelSpinModel.fromJson(resbody);
      log("==============> " + wheelSpinModel!.toJson().toString());
      if (!wheelSpinModel!.status!)
      /*  Fluttertoast.showToast(
            msg: wheelSpinModel!.message!, toastLength: Toast.LENGTH_SHORT); */

      if (wheelSpinModel!.status == true) {
        return true;
      } else {
        /*  Fluttertoast.showToast(
            msg: wheelSpinModel!.message!, toastLength: Toast.LENGTH_SHORT);
        return false; */
      }
    } catch (e) {
      /* Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT); */
    }
    return false;
  }
}
