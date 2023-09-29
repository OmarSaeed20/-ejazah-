import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/controller/comments_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/comments_model.dart';
import '../../utils/enums.dart';
import '../search_details/details_screen.dart';

class MyRattingScreen extends StatefulWidget {
  const MyRattingScreen({super.key});

  @override
  State<MyRattingScreen> createState() => _MyRattingScreenState();
}

class _MyRattingScreenState extends State<MyRattingScreen> {
  RequestState requestState = RequestState.waiting;

  CommentsModel? commentsModel = GetCommentsController.commentsModel;

  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    final res = await GetCommentsController.getComments();
    if (res) {
      commentsModel = GetCommentsController.commentsModel;
      setState(() => requestState = RequestState.success);
    } else {
      setState(() => requestState = RequestState.error);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: size.height * 0.020,
                  bottom: size.height * 0.20,
                  left: size.height * 0.015,
                  right: size.height * 0.015,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/group45871.png",
                      ),
                      fit: BoxFit.cover),
                ),
                constraints: BoxConstraints.expand(height: size.height * .3),
                child: CustomAppBar(
                  pageTitle: 'تقيماتي',
                  titleColor: Colors.white,
                ),
              ),
              Transform.translate(
                offset: Offset(0, 20.h),
                child: Builder(builder: (context) {
                  if (requestState == RequestState.loading)
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  return ListView.builder(
                      padding:
                          EdgeInsets.only(bottom: 2.h, left: 2.w, right: 2.w),
                      itemCount: commentsModel!.data!.commenets!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        final item = commentsModel!.data!.commenets![index];
                        return RatingWidget(
                          username: item.name,
                          countRate: double.parse(item.rate!),
                          date: item.createdAt,
                          description: item.commenet,
                        );
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
