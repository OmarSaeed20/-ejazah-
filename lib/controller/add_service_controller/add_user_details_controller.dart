import 'package:dio/dio.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/components.dart';
import '../../constants/api_paths.dart';
import '../../model/add_service_models/add_user_details_model.dart';

class AddUserDetailsController {
  static String? id_number;
  static String? Residence_permit;
  static String? iBAN;

  static bool isValid() {
    if (iBAN == null || id_number == null || Residence_permit == null) {
      toastShow(text: 'يرجي إكمال البيانات اولا', state: ToastStates.black);
      return false;
    }
    if (id_number!.length < 5) {
      toastShow(text: validText('رقم بطاقة الهوية'), state: ToastStates.black);
      return false;
    }
    try {
      (iBAN!);
    } catch (e) {
      toastShow(text: validText('رقم الأيبان'), state: ToastStates.black);
    }
    if (iBAN!.length < 7) {
      toastShow(text: validText('رقم الأيبان'), state: ToastStates.black);
      return false;
    }
    try {
      int.parse(id_number!);
    } catch (e) {
      toastShow(text: validText('رقم بطاقة الهوية'), state: ToastStates.black);
    }
    if (Residence_permit!.length < 3) {
      toastShow(
          text: validText('تصريح السكن والتأخير'), state: ToastStates.black);
      return false;
    }
    return true;
  }

  static Future<bool> addUserDetails() async {
    try {
      String url = ApiPath.baseurl + ApiPath.addUserDetailsPath;
      FormData body = FormData.fromMap({
        "id_number": id_number,
        "Residence_permit": Residence_permit!,
        "IBAN": iBAN!,
        // "front_photo": await MultipartFile.fromFile(front_photo!.path),
        // "back_photo": await MultipartFile.fromFile(back_photo!.path),
      });
      final res = await Dio().post(url,
          data: body,
          options: Options(headers: {
            'Content-Type':
                'multipart/form-data; boundary=<calculated when request is sent>',
            'Authorization': CurrentUser.token,
          }));
      clearData();
      if (res.data.isEmpty) {
        Fluttertoast.showToast(
            msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
            toastLength: Toast.LENGTH_SHORT);
        return false;
      }

      var resbody;
      resbody = res.data;
      AddUserDetailsModel addUserDetailsModel =
          AddUserDetailsModel.fromJson(resbody);
      if (!addUserDetailsModel.status!)
        toastShow(text: addUserDetailsModel.message!);

      return addUserDetailsModel.status!;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'حدث خطأ يرجي المحاولة مرة اخرى',
          toastLength: Toast.LENGTH_SHORT);
    }
    return false;
  }

  static void clearData() {
    id_number = null;
    iBAN = null;
    Residence_permit = null;
  }
}
