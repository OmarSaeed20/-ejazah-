import 'dart:convert';
import 'dart:developer';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';
import '../model/get_notifications_model.dart';

class NotificationsController {
  static GetNotificationsModel? getNotificationsModel;

  static Future<bool> getNotifications() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getNotificationsPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token??''
      });
      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody.toString());
      getNotificationsModel = GetNotificationsModel.fromJson(resbody);
      if (!getNotificationsModel!.status!)
        toastShow(text: getNotificationsModel!.message!);
      return getNotificationsModel!.status!;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }

  static Future<bool> readNotifications(int id) async {
    try {
      var url = ApiPath.baseurl + ApiPath.seeNotificationPath;
      http.Response res = await http.post(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token??'',
      }, body: {
        'notofication_id': id.toString(),
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      log(resbody.toString());
      return resbody['status'];
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }
}
