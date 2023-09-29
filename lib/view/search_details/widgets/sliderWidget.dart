// ignore_for_file: non_constant_identifier_names, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';

Widget SliderWidget({List<String>? imageList, var sliderKey}) {
  return SizedBox(
    height: 30.h,
    width: 100.w,
    child: CarouselSlider.builder(
        key: sliderKey,
        enableAutoSlider: false,
        unlimitedMode: true,
        slideBuilder: (index) {
          return Stack(
            children: [
              Container(
                child: CachedNetworkImage(
                  imageUrl: imageList[index],
                  width: 100.w,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColor.primaryColor.withOpacity(.0),
                    Colors.blue.withOpacity(.2)
                  ]),
                ),
              )
            ],
          );
        },
        slideIndicator: CircularSlideIndicator(
            padding: EdgeInsets.only(bottom: 3.h),
            indicatorRadius: 1.w,
            itemSpacing: 3.w,
            indicatorBackgroundColor: AppColor.whiteColor),
        slideTransform: const ZoomOutSlideTransform(),
        itemCount: imageList!.length),
  );
}
