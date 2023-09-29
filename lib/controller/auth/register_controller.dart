import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/constants/api_paths.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/database/local/cache_helper.dart';
import 'package:http/http.dart' as http;

class RegisterController {
  // static Future<bool> userSignUp() async {
  //   try{
  //     var url = ApiPath.baseurl + ApiPath.register;
  //     Map data = CurrentUser.toJson();
  //     data['device_token'] = 'dkjfhdshflshdflkshflshdf';
  //     var res = await http.post(Uri.parse(url), body: data);
  //     if (res.body.isEmpty) {
  //       Fluttertoast.showToast(msg: 'حدث خطأ يرجي المحاولة مرة اخرى', toastLength: Toast.LENGTH_SHORT);
  //       return false;
  //     }
  //     var resbody;
  //     resbody = json.decode(res.body);
  //     if (resbody['status'] == true) {
  //       print(resbody['message']);
  //       return true;
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
  //       return false;
  //     }
  //   } catch (e){
  //     print(e.toString());
  //     Fluttertoast.showToast(
  //         msg: 'تأكد من ادخال بياناتك', toastLength: Toast.LENGTH_SHORT);
  //
  //   }
  //   return false;
  // }
  static Future<bool> userSignUp() async {
    var url = ApiPath.baseurl + ApiPath.register;

    Map data = await CurrentUser.toJson();
    print("data ====> ${CurrentUser.toJson()}");
    try {
      var res = await http.post(Uri.parse(url), body: data);
      var resbody;

      if (res.body.isNotEmpty) {
        resbody = json.decode(res.body);
      }
      if (resbody['status']) {
        CurrentUser.fromJson(resbody['data']['user']);
        CurrentUser.OTP = resbody['data']['code'].toString();
        toastShow(text: resbody['message']);
      } else {
        toastShow(text: resbody['message']);
      }
      return resbody['status'];
    } catch (e) {
      print("===========> " + e.toString());
      return false;
    }
  }

  static Future<bool> sendOTP() async {
    var url = ApiPath.baseurl + ApiPath.verifyOtpPath;
    // var data = {
    //   'name':  CurrentUser.name,
    //   'email': CurrentUser.email,
    //   'phone': CurrentUser.phone,
    //   'country_id': CurrentUser.countryId,
    //   'password': CurrentUser.password,
    //   'confirm_password': CurrentUser.confirmPasscword,
    //   'device_token': 'dkjfhdshflshdflkshflshdf',
    // };
    try {
      var res = await http.post(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? CacheHelper.getData(key: "token"),
      }, body: {
        'otp': CurrentUser.OTP,
        'device_token': CurrentUser.token ?? CacheHelper.getData(key: "token"),
      });
      var resbody;

      if (res.body.isNotEmpty) {
        resbody = json.decode(res.body);
      }
      toastShow(text: resbody['message']);
      return resbody['status'];
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> resendOTP() async {
    var url = ApiPath.baseurl + ApiPath.resendOtp;

    try {
      var res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization':
              CurrentUser.token ?? CacheHelper.getData(key: "token"),
        },
      );
      var resbody;

      if (res.body.isNotEmpty) {
        resbody = json.decode(res.body);
        toastShow(text: resbody['message']);
      }
      return resbody['status'];
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
