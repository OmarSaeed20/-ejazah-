// ignore_for_file: deprecated_member_use, sort_child_properties_last, file_names

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'package:sizer/sizer.dart';

// ignore: non_constant_identifier_names
Widget CustomButton(
    {String? text,
    double? radius,
    GestureTapCallback? onPressed,
    Color? color,
    Color? textColor,
    double? fontSize,
    padding,
    double? height,
    double? width , 
    Decoration? decoration
    }) {
  return Container(
    padding: padding ?? const EdgeInsets.all(0),
    margin: EdgeInsets.only(bottom: 1.h, top: 1.h),
    width: width ?? 100.w,
    height: height ?? 7.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 8.w),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          offset: const Offset(0, 3.0),
          blurRadius: 6.0,
        ),
      ],
    ),
    child: InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color ?? Color.fromRGBO(83, 138, 153, 100),
          borderRadius: BorderRadius.circular(radius ?? 8.w),
        ),
        child: Text(
          text!,
          style: TextStyle(
              fontSize: fontSize ?? AppFonts.t3,
              color: textColor ?? AppColor.whiteColor,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
