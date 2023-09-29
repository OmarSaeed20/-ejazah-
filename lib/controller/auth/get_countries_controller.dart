import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';
import '../../model/register_models/get_countries_model.dart';

class GetCountries {
  static GetCountriesModel? getCountriesModel;
  static List<int> years = [];

  static Future<bool> getCountries() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getCountriesPath;
      http.Response res = await http.get(Uri.parse(url));

      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطـأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);
      getCountriesModel = GetCountriesModel.fromJson(resbody);
      if (!getCountriesModel!.status!)
        Fluttertoast.showToast(
            msg: getCountriesModel!.message!, toastLength: Toast.LENGTH_SHORT);

      if (getCountriesModel!.status == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: getCountriesModel!.message!, toastLength: Toast.LENGTH_SHORT);
        return false;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطـأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }

  static Future<bool> getDate() async {
    try {
      var url = ApiPath.baseurl + ApiPath.date;
      http.Response res = await http.get(Uri.parse(url));

      if (res.body.isEmpty) {
        Fluttertoast.showToast(
          msg: 'حدث خطـأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT,
        );
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);

      for (int i = 0; i < (resbody["data"] as List).length; i++) {
        years.add((resbody["data"] as List)[i]["year"]);
      }

      log(years.toString());

      if (!resbody["status"])
        Fluttertoast.showToast(
            msg: resbody["message"], toastLength: Toast.LENGTH_SHORT);

      if (resbody["status"] == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: resbody["message"], toastLength: Toast.LENGTH_SHORT);
        return false;
      }
    } catch (error) {
      log("------>" + error.toString());
      Fluttertoast.showToast(
        msg: 'حدث خطـأ يرجي المحاولة مرة اخرى',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    return false;
  }
}
