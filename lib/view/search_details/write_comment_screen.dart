import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/constants/api_paths.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/controller/comments_controller.dart';
import 'package:ejazah/database/local/cache_helper.dart';
import 'package:ejazah/widgets/app_colors.dart';
import 'package:ejazah/widgets/app_fonts.dart';
import 'package:ejazah/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class WriteCommentScreen extends StatefulWidget {
  const WriteCommentScreen({super.key, required this.ads_id});
  final String ads_id;
  @override
  State<WriteCommentScreen> createState() => _WriteCommentScreenState();
}

class _WriteCommentScreenState extends State<WriteCommentScreen> {
  double rating = 0;
  bool processing = false;
  TextEditingController commentController = TextEditingController();

  Future<bool> sendComment() async {
    setState(() {
      processing = true;
    });

    log(
      "${widget.ads_id}" +
          "\n" +
          CurrentUser.token.toString() +
          "\n" +
          CacheHelper.getData(key: "token"),
    );
    var url = ApiPath.baseurl + ApiPath.comment;
    var data = {
      "ads_id": "${widget.ads_id}",
      "commenet": commentController.text,
      "rate": "$rating",
    };
    try {
      var resbody = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization':
                CurrentUser.token ?? CacheHelper.getData(key: "token")
          },
        ),
      );
      setState(() {
        processing = false;
      });

      log(resbody.toString());
      if (resbody.data.isNotEmpty) {
        if (resbody.data['status'] == true) {
          // toastShow(text: resbody.data['message'], state: ToastStates.black);
        } else {
          toastShow(text: resbody.data['message'], state: ToastStates.black);
          return false;
        }

        return true;
      }
    } catch (e) {
      log(e.toString());
      setState(() {
        processing = false;
      });
    }
    return false;
  }

  /* Future<bool> sendRating() async {
    setState(() {
      processing = true;
    });

    log(
      "${widget.ads_id}" +
          "\n" +
          CurrentUser.token.toString() +
          "\n" +
          CacheHelper.getData(key: "token"),
    );
    var url = ApiPath.baseurl + ApiPath.rate;
    var data = {
      "ads_id": "${widget.ads_id}",
      "rate": "$rating",
    };
    try {
      var resbody = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization':
                CurrentUser.token ?? CacheHelper.getData(key: "token")
          },
        ),
      );
      setState(() {
        processing = false;
      });

      log("----> " + resbody.toString());
      if (resbody.data.isNotEmpty) {
        if (resbody.data['status'] == true) {
          // toastShow(text: resbody.data['message'], state: ToastStates.black);
        } else {
          toastShow(text: resbody.data['message'], state: ToastStates.black);
          return false;
        }

        return true;
      }
    } catch (e) {
      log(e.toString());
      setState(() {
        processing = false;
      });
    }
    return false;
  }
 */
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.05,
            bottom: size.height * 0.05,
            left: size.height * 0.02,
            right: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(pageTitle: ""),
              SizedBox(height: 6.h),
              CustomText(
                text: "كيف تُقيمـه ؟",
                fontSize: AppFonts.t1,
                fontweight: FontWeight.w600,
              ),
              RatingBar.builder(
                initialRating: rating,
                itemCount: 5,
                unratedColor: AppColor.grayColor.withOpacity(0.10),
                direction: Axis.horizontal,
                itemSize: 4.h,
                itemPadding: EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, index) => const Icon(
                  CupertinoIcons.star,
                  color: Color(0xFFFFCA28),
                ),
                onRatingUpdate: (val) {
                  rating = val;
                  log("rating ---> $rating");
                  setState(() {});
                },
              ),
              SizedBox(height: 6.h),
              CustomText(
                text: "اكتب تعليقـك",
                fontSize: AppFonts.t1,
                fontweight: FontWeight.w600,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                // height: 6.5.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(0, 1.0),
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: customTextFormField(
                  context: context,
                  controller: commentController,
                  maxLines: 4,
                  validator: (val) {
                    return (val!.isEmpty) ? "هذا الحقـل مطلوب" : null;
                  },
                  hintText: 'اكتب تعليقـك هنا',
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 2.5.h),
        width: size.width,
        height: 6.5.h,
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColor.buttonColor),
          onPressed: () async {
            if (commentController.text.isNotEmpty) {
              await sendComment();
              Navigator.pop(context);

              GetCommentsController.comment =
                  await GetCommentsController.getCommentsad(id: widget.ads_id);
              GetCommentsController.streamController.sink
                  .add(GetCommentsController.comment!);
              setState(() {});
            }
          },
          child: Builder(builder: (context) {
            if (processing)
              return SizedBox(
                height: 25,
                width: 25,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            return CustomText(
              text: "إرسال",
              fontSize: AppFonts.t3,
              color: Colors.white,
              fontweight: FontWeight.bold,
            );
          }),
        ),
      ),
    );
  }
/*   Future<void> setComments(List<List<CommentModel>> tList) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('comment', jsonEncode(tList));
} */
}
/*
Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            alignment: Alignment.center,
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            height: 6.5.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade400,
                                                  offset: const Offset(0, 1.0),
                                                  blurRadius: 3.0,
                                                ),
                                              ],
                                            ),
                                            child: customTextFormField(
                                              context: context,
                                              controller: commentController,
                                              validator: (val) {
                                                return (val!.isEmpty)
                                                    ? "هذا الحقـل مطلوب"
                                                    : null;
                                              },
                                              hintText: 'اكتب تعليقـك هنا',
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 2.5.w),
                                        Container(
                                          width: 100,
                                          height: 6.5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColor.buttonColor,
                                            ),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              return TextButton(
                                                onPressed: () {},
                                                child: Text('إرســال'),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    

 */

