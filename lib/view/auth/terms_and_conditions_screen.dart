import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/get_privacies_controller.dart';
import '../../model/get_privacies_model.dart';
import '../../utils/enums.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  RequestState requestState = RequestState.waiting;
  GetPrivaciesModel? getPrivaciesModel;
  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    final res = await GetPrivaciesController.getPrivacies();
    if (res) {
      getPrivaciesModel = GetPrivaciesController.getPrivaciesModel;
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
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: size.height * 0.05,
                            bottom: size.height * 0.05,
                            left: size.height * 0.01,
                            right: size.height * 0.01,
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/group45871.png",
                                ),
                                fit: BoxFit.cover),
                          ),
                          constraints:
                              BoxConstraints.expand(height: size.height * .35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomAppBar(pageTitle: ''),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'سياسة الخصوصية'.tr,
                                        style: TextStyle(
                                            fontSize: AppFonts.t1,
                                            color: AppColor.orangeColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                          'برجاء قرأتها جيدا لتتعرف علي جميع سياسات \n التطبيق',
                                          style: TextStyle(
                                              fontSize: AppFonts.t3,
                                              color: Colors.white))
                                    ],
                                  ),
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/svg/group36771.svg',
                                      height: 16.h,
                                      width: 16.w,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.04,
                            right: size.width * 0.03,
                            bottom: size.height * 0.01,
                          ),
                          margin: EdgeInsets.only(top: 29.h),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: size.height * .7,
                                width: size.width,
                                child: getCardContainer(),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCardContainer() {
    Size size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      if (requestState == RequestState.loading)
        return Center(child: CircularProgressIndicator());
      if (requestState == RequestState.error)
        return Text('تأكد من اتصالك بالانترنت');
      return Container(
        padding: EdgeInsets.only(
          top: size.height * 0.04,
          bottom: size.height * 0.02,
          right: size.width * 0.03,
          left: size.width * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0, 2.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                getPrivaciesModel!.data!.privacies!.first.name!,
                style: TextStyle(fontSize: AppFonts.t3),
              ),
            ),
          ],
        ),
      );
    });
  }
}
