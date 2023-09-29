import 'dart:convert';
import 'dart:developer';
import 'package:ejazah/components/components.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';
import '../model/search_models/search_result_model.dart';
import 'auth/user_controller.dart';

class MyAdsController {
  static List<Ads>? previous, current;

  static Future<bool> getMyAds() async {
    previous = [];
    current = [];
    try {
      var url = ApiPath.baseurl + ApiPath.myAdsPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? '',
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      resbody['data']['current'].map((e) {
        current!.add(Ads.fromJson(e));
      }).toList();
      resbody['data']['previous'].map((e) {
        previous!.add(Ads.fromJson(e));
      }).toList();
      if (!resbody['status']) toastShow(text: resbody['message']);
      return resbody['status'];
    } catch (e) {
      log(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> deleteAds({
    required String id,
  }) async {
    try {
      var url = ApiPath.baseurl + ApiPath.deleteAds;
      http.Response res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': CurrentUser.token ?? '',
        },
        body: {
          "ads_id": id,
        },
      );
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      toastShow(text: resbody['message']);

      return resbody['status'];
    } catch (e) {
      log(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
