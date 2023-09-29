import 'dart:convert';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';

class RateOwnerController {
  static Future<bool> addComment({
    required String ads_id,
    required String commenet,
    required String rate,
  }) async {
    try {
      var url = ApiPath.baseurl + ApiPath.addCommenetPath;
      http.Response res = await http.post(Uri.parse(url),headers: {
        'Authorization': CurrentUser.token??'',
      },
          body: {
            'ads_id':ads_id,
            'commenet':commenet,
            'rate':rate,
          }
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
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
