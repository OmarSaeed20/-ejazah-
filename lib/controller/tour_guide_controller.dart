import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_paths.dart';
import '../model/search_models/search_result_model.dart';
import 'auth/user_controller.dart';

class TourGuideController {
  static CategoryModel? categorySearchModel;

  static Future<bool> tourGuide() async {
    try {
      var url = ApiPath.baseurl + ApiPath.tourGuidePath;
      http.Response res = await http.get(Uri.parse(url),
      headers: {
        'Authorization': CurrentUser.token ?? '',
        'lang': CurrentUser.languageId,

      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      categorySearchModel = CategoryModel.fromJson(resbody);
      if (!categorySearchModel!.status!) toastShow(text: categorySearchModel!.message!);
      return categorySearchModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
