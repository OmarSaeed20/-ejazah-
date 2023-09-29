import 'dart:convert';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../components/components.dart';
import '../../constants/api_paths.dart';
import '../../model/get_favourite_model.dart';

class FavouriteController {
  static GetFavouriteModel? getFavouriteModel;

  static Future<bool> getFav() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getFavouriesPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token??'',
      });
      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody;
      resbody = json.decode(res.body);
      getFavouriteModel = GetFavouriteModel.fromJson(resbody);
      // print(getFavouriteModel.);
      if (!getFavouriteModel!.status!)
        Fluttertoast.showToast(
            msg: getFavouriteModel!.message!, toastLength: Toast.LENGTH_SHORT);

      if (getFavouriteModel!.status == true) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: getFavouriteModel!.message!, toastLength: Toast.LENGTH_SHORT);
        return false;
      }
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<bool> postFav(String id) async {
    try {
      var url = ApiPath.baseurl + ApiPath.addFavouriesPath;
      http.Response res = await http.post(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token??'',
      }, body: {
        'ads_id': id
      });
      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody = json.decode(res.body);
      print(resbody['message']);
      if (!resbody['status']) toastShow(text: resbody['message']);
      return resbody['status'];
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
