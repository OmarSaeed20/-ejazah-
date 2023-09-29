import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/constants/api_paths.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:http/http.dart' as http;

import '../../model/search_models/search_result_model.dart';

class CategoryResultController {
  static CategoryModel? categorySearchModel;

  static Future<bool> getFilterResult(category_id, {word, offers, privace, min, max, street_id, rate, camp, chalets, travel_type}) async {
    try {
      var url = ApiPath.baseurl + ApiPath.categoryFilterPath;
      Map body = {
        'category_id': category_id.toString(),
        'word': word ?? '',
        'offers': offers ?? '',
        'privace': privace ?? '',
        'min': min ?? '',
        'max': max ?? '',
        'street_id': street_id ?? '',
        'rate': rate ?? '',
        'camp': camp ?? '',
        'chalets': chalets ?? '',
        'travel_type': travel_type ?? '',
      };
      http.Response res = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': CurrentUser.token ?? '',
          'lang': CurrentUser.languageId,
        },
        body: body,
      );

      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);

      categorySearchModel = CategoryModel.fromJson(resbody);
      if (!categorySearchModel!.status!)
        toastShow(text: categorySearchModel!.message!);
      return categorySearchModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
