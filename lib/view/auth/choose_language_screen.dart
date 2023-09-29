import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth/user_controller.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  bool value = false;
  String languageValue = '1';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: size.height * 0.025,
            bottom: size.height * 0.05,
            left: size.height * 0.02,
            right: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/Group 36770.svg',
                width: 20.w,
                height: 20.h,
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomText(
                text: 'اختر لغتك الخاصة',
                color: Colors.black,
                fontSize: AppFonts.t2,
                fontweight: FontWeight.bold,
              ),
              SizedBox(
                height: 2.h,
              ),
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: 7.5.h,
                      color: Colors.white,
                      child: CustomRadioButton(
                          title: 'اللغة العربية', languageNum: '1')),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: 7.5.h,
                      color: Colors.white,
                      child: CustomRadioButton(
                          title: 'English', languageNum: '2')),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: 7.5.h,
                      color: Colors.white,
                      child:
                          CustomRadioButton(title: 'Turcky', languageNum: '3')),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                width: size.width,
                height: 6.5.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonColor),
                  onPressed: () {
                    myNavigate(screen: LoginScreen(), context: context);
                  },
                  child: CustomText(
                    text: 'التـالي',
                    fontSize: AppFonts.t2,
                    color: Colors.white,
                    fontweight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomRadioButton({String title = '', String languageNum = ''}) {
    return InkWell(
      onTap: () {
        setState(() {
          // UserController.languageId = languageNum;
          languageValue = languageNum;
          CurrentUser.languageId = languageNum;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: AppFonts.t2,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          Radio(
            value: languageNum,
            groupValue: languageValue,
            onChanged: (val) {
              setState(() {
                // UserController.languageId = languageNum;
                languageValue = val.toString();
                CurrentUser.languageId = languageValue;
              });
            },
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor:
                MaterialStateColor.resolveWith((states) => Colors.green),
          ),
        ],
      ),
    );
  }
}
