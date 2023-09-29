import 'dart:convert';
import 'dart:developer';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';
import '../model/get_wallet_model.dart';

class GetWalletController {
  static GetWalletModel? getWalletModel;
  static GetWalletModel? AddToWalletModel;

  static Future<bool> getWallet() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getWalletPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token??''
      });
      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody = json.decode(res.body);
      getWalletModel = GetWalletModel.fromJson(resbody);
      log("============> ${getWalletModel!.data!.toJson()}");
      if (!getWalletModel!.status!) toastShow(text: getWalletModel!.message!);
      return getWalletModel!.status!;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }
  static Future<bool> addToWallet(value) async {
    try {
      var url = ApiPath.baseurl + ApiPath.addWalletPath;
      http.Response res = await http.post(Uri.parse(url),
          headers: {
        'Authorization': CurrentUser.token??''
      },
        body: {
          "value":value
        }
      );
      if (res.body.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }
      var resbody = json.decode(res.body);
      AddToWalletModel = GetWalletModel.fromJson(resbody);
      toastShow(text: AddToWalletModel!.message!);
      return AddToWalletModel!.status!;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }
}
