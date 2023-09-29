import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/api_paths.dart';
import '../../model/add_service_models/get_accompanying_model.dart';
import '../../model/add_service_models/get_cities_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetCitiesController {
  static GetCitiesModel? getCitiesModel;
  static GetAccompanyingModel? getAccompanyingModel;
  static Future<bool> getCities() async {
    try {
      var url = ApiPath.baseurl + "${ApiPath.getCitiesPath}";
      http.Response res = await http.get(Uri.parse(url),
          headers: {'Authorization': CurrentUser.token ?? ''});

      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);
      getCitiesModel = GetCitiesModel.fromJson(resbody);
      if (!getCitiesModel!.status!) {
        Fluttertoast.showToast(
            msg: getCitiesModel!.message!, toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }

  static Future<bool> getAccompanying() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getAccompanyingPath;
      http.Response res = await http.get(Uri.parse(url), headers: {});

      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);
      getAccompanyingModel = GetAccompanyingModel.fromJson(resbody);
      if (!getAccompanyingModel!.status!) {
        Fluttertoast.showToast(
            msg: getAccompanyingModel!.message!,
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }
}
