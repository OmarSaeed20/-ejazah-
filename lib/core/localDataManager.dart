import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LocalDataManager extends GetxService {
  // late SharedPreferences pref;
  // User? _loggerUser;

  // Future<LocalDataManager> init() async {
  //   pref = await SharedPreferences.getInstance();
  //   return this;
  // }

  // ClientType get getClientType {
  //   return Helper.stringToClientType(pref.getString('ClientType'))!;
  // }

  // Future logout() async {
  //   try {
  //     await VChatController.instance.logOut();
  //   } catch (e) {}
  //   await Get.find<DataManagerImpl>().box.erase();
  //   await pref.clear();
  // }

  // Future<bool> setClientType(ClientType type) {
  //   return pref.setString('ClientType', Helper.clientTypeToString(type));
  // }

  // List<String>? get getUserNameAndPassword {
  //   return pref.getStringList('userAndPassword');
  // }

  // Future<void> setUser(User user, String userName, String password) async {
  //   _loggerUser = user;
  //   await _saveUserNameAndPassword(userName, password);
  //   pref.setString('User', json.encode(user.toJson()));
  //   await setClientType(Helper.stringToClientType(user.type)!);
  // }

  // Future _saveUserNameAndPassword(String userName, String password) async {
  //   return pref.setStringList('userAndPassword', [userName, password]);
  // }

  // Future updateWhatsAppMsg(String whatsApp) async {
  //   _loggerUser?.whatsappMsg = whatsApp;
  // }

  // User? getUser() {
  //   return _loggerUser;
  // }

  // int? get userId {
  //   return _loggerUser?.userID;
  // }

  // String? get userName {
  //   return _loggerUser?.displayName;
  // }
}
