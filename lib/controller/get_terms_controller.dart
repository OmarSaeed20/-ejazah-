import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_paths.dart';
import '../model/get_terms_model.dart';

class GetTermsController {
  static GetTermsModel? getTermsModel;

  static Future<bool> getTerms() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getTermsPath;
      http.Response res = await http.get(Uri.parse(url));
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      getTermsModel = GetTermsModel.fromJson(resbody);
      if (!getTermsModel!.status!) toastShow(text: getTermsModel!.message!);
      return getTermsModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
