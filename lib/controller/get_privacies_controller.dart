import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_paths.dart';
import '../model/get_privacies_model.dart';

class GetPrivaciesController {
  static GetPrivaciesModel? getPrivaciesModel;

  static Future<bool> getPrivacies() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getPrivaciesPath;
      http.Response res = await http.get(Uri.parse(url));
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      getPrivaciesModel = GetPrivaciesModel.fromJson(resbody);
      print(getPrivaciesModel!.data!.privacies!.first.name!);
      if (!getPrivaciesModel!.status!) toastShow(text: getPrivaciesModel!.message!);
      return getPrivaciesModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
