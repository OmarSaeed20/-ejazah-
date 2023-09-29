import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_paths.dart';

class ChangePasswordController {

  static Future<bool> changePassword(String phone, String password) async {
    try {
      var url = ApiPath.baseurl + ApiPath.changePasswordPath;
      http.Response res = await http.post(Uri.parse(url), body: {
        'phone' : phone,
        'password' : password,
        'confirm_password' : password,
      });
      var resbody = json.decode(res.body);
      toastShow(text: resbody['message']);
      return resbody['status'];
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
