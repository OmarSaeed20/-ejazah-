// ignore_for_file: prefer_const_constructors, file_names

import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

// ignore: non_constant_identifier_names
Widget CustomTextFormField(
        {Widget? labelContent,
        String? hintText,
        double? textSize,
        EdgeInsetsGeometry? contentPadding,
        TextEditingController? controller,
        Widget? prefixIcon,
        Color? fillColor,
        Widget? suffixIcon,
        double? width,
        TextInputAction? textInputAction,
        int? maxLines,
        bool? isPassword,
        TextInputType? keyBoardType,
        double? radius,
        List<TextInputFormatter>? inputFormatter,
        FocusNode? focusNode,
        bool? readOnly,
        Function? onChangedFun,
        Function? validation}) =>
    Container(
      width: width ?? 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 3.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        vertical: 2.w,
      ),
      child: TextFormField(
        // textAlign: TextAlign.start,
        scrollPhysics: const BouncingScrollPhysics(),
        obscureText: isPassword ?? false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        readOnly: readOnly ?? false,
        inputFormatters: inputFormatter ?? [],
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChangedFun != null
            ? (_) {
                onChangedFun();
              }
            : (_) {},

        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 1.w),
            borderSide: const BorderSide(
              width: 0,
              
              style: BorderStyle.none,
            ),
          ),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                vertical: 2.w,
              ),
          alignLabelWithHint: true,
          label: labelContent ?? labelContent,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: textSize ?? AppFonts.t3,
          ),
          focusColor: AppColor.primaryColor,
          prefixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: prefixIcon,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: suffixIcon,
          ),
          prefixIconColor: Colors.black26,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 30, minHeight: 20),
          fillColor: Color.fromARGB(255, 250, 250, 250),
        ),
        style: TextStyle(color: Colors.black87, fontSize: AppFonts.t3),
        maxLines: maxLines ?? 1,
        textAlign: TextAlign.start,
        keyboardType: keyBoardType ?? TextInputType.text,
        cursorColor: Colors.black26,
        validator: validation != null
            ? (value) {
                return validation(value);
              }
            : (value) {
                return null;
              },
      ),
    );
