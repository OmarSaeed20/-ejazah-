// ignore_for_file: must_be_immutable, file_names

import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget {
  final String pageTitle;
  Color? titleColor;

  CustomAppBar({Key? key, required this.pageTitle, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(2.w),
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(1.5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, 1.0),
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: AppColor.grayColor,
              size: 5.w,
            ),
          ),
        ),
        CustomText(
          textAlign: TextAlign.center,
          text: pageTitle,
          fontSize: AppFonts.t2,
          fontweight: FontWeight.bold,
          color: titleColor ?? AppColor.blackColor,
          fontFamily: 'Tajawal',
        ),
        SizedBox(
          width: 3.5.w,
        ),
      ],
    );
  }
}
