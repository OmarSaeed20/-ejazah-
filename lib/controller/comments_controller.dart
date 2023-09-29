import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/database/local/cache_helper.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_paths.dart';
import '../model/comments_model.dart';
import '../model/comments.dart';

class GetCommentsController {
  static CommentsModel? commentsModel;
  static Comment? comment;
  static StreamController<Comment> streamController =
      StreamController<Comment>.broadcast();

  static Future<bool> getComments() async {
    try {
      var url = ApiPath.baseurl + ApiPath.getCommentsPath;
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? CacheHelper.getData(key: "token")
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        return false;
      }
      var resbody = json.decode(res.body);
      log(resbody.toString());
      commentsModel = CommentsModel.fromJson(resbody);
      if (!commentsModel!.status!) toastShow(text: commentsModel!.message!);
      return commentsModel!.status!;
    } catch (e) {
      log(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return false;
  }

  static Future<Comment> getCommentsad({String? id}) async {
    try {
      var url = ApiPath.baseurl + "${ApiPath.comment}/$id";
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Authorization': CurrentUser.token ?? CacheHelper.getData(key: "token")
      });
      if (res.body.isEmpty) {
        toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
        // return false;
      }
      var resbody = json.decode(res.body);
      comment = Comment.fromJson(resbody);
      // setComments(comments?.data ?? []).then((value) async {
      //   commentList = await getCommentsFromLocalDb();
      // });

      if (!comment!.status!) toastShow(text: comment!.message!);
      return comment!;
    } catch (e) {
      log(e.toString());
      toastShow(text: 'حدث خطأ يرجي المحاولة مرة اخرى');
    }
    return comment!;
  }

/*   static Future setComments(
    List<dynamic> comments,
  ) async {
    final commentList =
        comments.map((element) => json.encode(element)).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList("comments", commentList);
  }

  static Future<List<Data>> getCommentsFromLocalDb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? comments = prefs.getStringList("comments");
    return comments!
        .map<Data>((element) => Data.fromJson(jsonDecode(element)))
        .toList();
  } */
}
