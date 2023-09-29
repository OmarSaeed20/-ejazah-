import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_paths.dart';
import '../model/get_questions_model.dart';

class GetQuestionsController {
  static GetQuestionsModel? getQuestionsModel;

  static Future<bool> getQuestions() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getQuestionsPath;
      http.Response res = await http.get(Uri.parse(url));
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody);
      getQuestionsModel = GetQuestionsModel.fromJson(resbody);
      if (!getQuestionsModel!.status!) toastShow(text: getQuestionsModel!.message!);
      return getQuestionsModel!.status!;
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
