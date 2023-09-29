import 'dart:convert';
import 'dart:developer';

import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';
import '../../model/add_service_models/get_streets_model.dart';
import '../../model/get_street_position_model.dart';
import '../add_service_controller/add_ads_controller.dart';

class GetStreetsController {
  static GetStreetsModel? getStreetsModel;
  static GetStreetsPositionModel? getStreetsPositionModel;

  static Future<bool> getStreets() async {
    try {
      // print('?city_id=${AddAdsController.city_id}');
      var url = ApiPath.baseurl +
          ApiPath.getStreetsPath +
          '?city_id=${AddAdsController.city_id}';
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? '',
      });
      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);
      getStreetsModel = GetStreetsModel.fromJson(resbody);

      if (!getStreetsModel!.status!)
        Fluttertoast.showToast(
            msg: getStreetsModel!.message!, toastLength: Toast.LENGTH_SHORT);

      if (getStreetsModel!.status == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: getStreetsModel!.message!, toastLength: Toast.LENGTH_SHORT);
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

  static Future<bool> getStreetPosition() async {
    try {
      var url = ApiPath.baseurl +
          ApiPath.getStreetPath +
          '?street_id=${AddAdsController.street_id}';
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? '',
      });
      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);
      getStreetsPositionModel = GetStreetsPositionModel.fromJson(resbody);
      log(resbody.toString());
      if (getStreetsPositionModel!.status!) {
        AddAdsController.lat = getStreetsPositionModel!.data!.street!.lat!;
        AddAdsController.long = getStreetsPositionModel!.data!.street!.long!;
      }
      if (!getStreetsPositionModel!.status!)
        Fluttertoast.showToast(
            msg: getStreetsPositionModel!.message!,
            toastLength: Toast.LENGTH_SHORT);

      if (getStreetsPositionModel!.status == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: getStreetsPositionModel!.message!,
            toastLength: Toast.LENGTH_SHORT);
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
