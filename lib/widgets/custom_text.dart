// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'app_fonts.dart';

Widget CustomText(
        {Key? key,
        String? text,
        Color? color,
        double? fontSize,
        TextAlign? textAlign,
        FontWeight? fontweight,
        String? fontFamily,
        bool? underline = false,
        TextOverflow? overflow,
        EdgeInsetsGeometry? padding,
        int? maxLines}) =>
    Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        text!,
        softWrap: true,
        textAlign: textAlign,
        style: TextStyle(
          overflow: TextOverflow.fade,
            color: color ?? Colors.black,
            decoration: underline == true
                ? TextDecoration.underline
                : TextDecoration.none,
            fontSize: fontSize ?? AppFonts.t3,
            fontWeight: fontweight ?? FontWeight.normal,
            fontFamily: fontFamily ?? "Tajawal"),
        overflow: overflow,
        maxLines: maxLines,
      ),
    );
