import 'package:dio/dio.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/api_paths.dart';
import '../../database/local/cache_helper.dart';

class UpdateProfileController {
  static String imgLink = '';
  static Future<bool> update(String name, String email, XFile? img) async {
    try {
      var url = ApiPath.baseurl + ApiPath.updateProfilePath;
      FormData body = FormData.fromMap({
        'name' : name,
        'email' : email,
        'country_id' : CurrentUser.countryId,
        'image': img != null ? await MultipartFile.fromFile(img.path) : null,
      });
      final res = await Dio().post(url,
          data: body,
          options: Options(headers: {
            'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>',
            'Authorization': CurrentUser.token ?? '',
            'lang': CurrentUser.languageId,
          }));
      var resbody = res.data;
      print(resbody);
      // imgLink = resbody['data'];
      CurrentUser.image = resbody['data']['image'];
      await CacheHelper.saveData(key: 'image', value: CurrentUser.image);

      toastShow(text: resbody['message']);
      return resbody['status'];
    } catch (e) {
      print(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }
}
