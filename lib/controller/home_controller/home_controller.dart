import 'dart:convert';
import 'dart:developer';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/constants/api_paths.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/model/home/get_home_model.dart';
import 'package:ejazah/model/search_models/search_result_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../model/splash_model.dart';

class HomeController {
  static String languageId = '1';

  static GetHomeModel? getHomeModel;
  static SplashModel? splashModel;
  static CategoryModel? getAdsByCityModel;

  static Future<bool> getHomeData() async {
    print(CurrentUser.token);
    try {
      var url = ApiPath.baseurl + ApiPath.homePath;
      http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': CurrentUser.token ?? '',
          'lang': '1',
        },
      );

      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);

      log(resbody.toString());

      getHomeModel = GetHomeModel.fromJson(resbody);
      if (!getHomeModel!.status!)
        Fluttertoast.showToast(
            msg: getHomeModel!.message!, toastLength: Toast.LENGTH_SHORT);

      if (getHomeModel!.status == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: getHomeModel!.message!, toastLength: Toast.LENGTH_SHORT);
        return false;
      }
    } catch (error) {
      log("=====>" + error.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static List<String> categoryNames = [];
  static List<Ads> categoryItems = [];

  static Future<bool> getAdsByCityData() async {
    try {
      var url = ApiPath.baseurl +
          ApiPath.getAdsbyCityPath +
          '?city_id=' +
          (CurrentUser.cityId ??
              getHomeModel!.data!.cities!.first.id.toString());
      http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': CurrentUser.token ?? '',
          'lang': '1',
        },
      );

      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody = json.decode(res.body);
      categoryNames = [];
      categoryItems = [];
      getAdsByCityModel = CategoryModel.fromJson(resbody);
      if (!resbody['status']) {
        toastShow(text: resbody['message']);
      }

      return resbody['status'];
    } catch (error) {
      log("=====>  " + error.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }

  static Future<bool> getSplash() async {
    try {
      var url = ApiPath.baseurl + ApiPath.splachPath;
      http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': CurrentUser.token ?? '',
          'lang': CurrentUser.languageId,
        },
      );

      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);

      log(resbody.toString());

      splashModel = SplashModel.fromJson(resbody);
      if (!splashModel!.status!)
        Fluttertoast.showToast(
            msg: splashModel!.message!, toastLength: Toast.LENGTH_SHORT);

      if (splashModel!.status == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: splashModel!.message!, toastLength: Toast.LENGTH_SHORT);
        return false;
      }
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
