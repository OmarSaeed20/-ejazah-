// ignore_for_file: file_names

import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget myListEmpety(String msg) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppImages.appLogo,
          width: 140,
          height: 100,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          msg,
          style: const TextStyle(
              // color: AppColor.orangeColor,
              fontFamily: 'cairoBold',
              fontSize: AppFonts.t3),
        )
      ],
    ),
  );
}
