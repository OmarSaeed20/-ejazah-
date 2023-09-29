import 'dart:convert';
import 'package:ejazah/constants/api_paths.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class HomePageModel {
  var id;
  String? cameraName;
  String? image;

  Map toJson() => {
        'id': id,
        'cameraName': cameraName,
        'image': image,
      };

  HomePageModel.fromJson(Map json) {
    id = json['id'];
    cameraName = json['cameraName'];
    image = json['image'];
  }

  static Future<List<HomePageModel>> getHomePageList() async {
    List<HomePageModel> homePageList = [];
    var url = "${ApiPath.baseurl}homeScreen";
    var response = await http.post(Uri.parse(url));
    var resbody;
    if (response.statusCode == 200) {
      resbody = jsonDecode(response.body);
      Iterable l = resbody['sliders'];
      homePageList = List<HomePageModel>.from(
          l.map((model) => HomePageModel.fromJson(model)));
      return homePageList;
    } else {
      Fluttertoast.showToast(
          msg: "Failed to load Paper Binding", toastLength: Toast.LENGTH_SHORT);
      return homePageList;
    }
  }
}
