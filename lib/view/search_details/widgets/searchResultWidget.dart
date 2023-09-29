import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/app_images.dart';

Widget SearchRiverResultWidget({
  onTap,
  image,
  title,
  priceDay,
  totalPrice,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 3.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.w),
                  topRight: Radius.circular(2.w)),
              child: Image.asset(
                image,
                width: 100.w,
                height: 14.h,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      text: title,
                      fontweight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: priceDay,
                              overflow: TextOverflow.ellipsis,
                              fontSize: AppFonts.t4_2),
                          CustomText(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              text: "الاجمالي : " + totalPrice,
                              overflow: TextOverflow.ellipsis,
                              fontSize: AppFonts.t4_2),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
          Positioned(
            left: 2.h,
            top: 2.h,
            child: SvgPicture.asset(
              'assets/svg/vuesax-linear-heart.svg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget SearchResultWidget(
    {bool? isMine,
    onTap,
    image,
    title,
    title_travel_name,
    priceDay,
    totalPrice,
    code,
    address,
    isFavourite,
    bool isPay = false,
    onTapFav}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w),
    child: Card(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            color: AppColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(0, 2.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.w),
                            topRight: Radius.circular(2.w)),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          width: 100.w,
                          height: 14.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                      if (isPay)
                        Container(
                          padding: EdgeInsets.all(0.5.w),
                          margin: EdgeInsets.only(bottom: 0.5.h),
                          color: Colors.red.shade600,
                          child: CustomText(
                            text: 'محـجوز',
                            color: AppColor.whiteColor,
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          text: title == 'null' || title == null ? "" : title,
                          fontweight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        CustomText(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          text: title_travel_name == 'null' ||
                                  title_travel_name == null
                              ? ""
                              : title_travel_name,
                          fontweight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: priceDay,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppFonts.t4_2),
                                CustomText(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.h),
                                    text: "الاجمالي : " + totalPrice,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppFonts.t4_2),
                                // if (isPay)
                                //   Container(
                                //     padding: EdgeInsets.all(0.5.w),
                                //     margin: EdgeInsets.only(bottom: 0.5.h),
                                //     color: Colors.red.shade600,
                                //     child: CustomText(
                                //       text: 'محـجوز',
                                //       color: AppColor.whiteColor,
                                //     ),
                                //   ),
                              ],
                            ),
                            SizedBox(width: 5.w),
                            Padding(
                              padding: EdgeInsets.only(bottom: 3.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CustomText(
                                  //     text: 'كود الوحدة($code)',
                                  //     overflow: TextOverflow.ellipsis,
                                  //     fontSize: AppFonts.t4_2),
                                  CustomText(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      text: address == "null" || address == null
                                          ? ''
                                          : address,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: AppFonts.t4_2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isMine == null || !isMine)
                Positioned(
                  left: 2.h,
                  top: 2.h,
                  child: InkWell(
                    onTap: onTapFav,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: isFavourite
                              ? AppColor.whiteColor.withOpacity(.7)
                              : AppColor.grayColor.withOpacity(.7)),
                      child: isFavourite
                          ? Image.asset(
                              AppImages.unLikeFavIc,
                              color: Colors.red,
                              width: 4.5.w,
                            )
                          : Image.asset(
                              AppImages.unLikeFavIc,
                              color: AppColor.whiteColor,
                              width: 4.5.w,
                            ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget SearchOfferResultWidget({
  onTap,
  image,
  title,
  title_travel_name,
  priceDay,
  offerPrice,
  travel_type,
  totalPrice,
  code,
  address,
  isFavourite,
  onTapFav,
  isPay = false,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(2.w),
        onTap: onTap,
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.w),
                            topRight: Radius.circular(2.w),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: image ?? '',
                            width: 100.w,
                            height: 14.0.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        if (isPay)
                          Container(
                            padding: EdgeInsets.all(1.0.w),
                            color: Colors.red.shade600,
                            child: CustomText(
                              text: 'محـجوز',
                              color: AppColor.whiteColor,
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                padding: EdgeInsets.only(top: 2.h),
                                text: title == 'null' || title == null
                                    ? ""
                                    : title,
                                fontweight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              CustomText(
                                padding: EdgeInsets.only(top: 2.h),
                                text: title_travel_name == 'null' ||
                                        title_travel_name == null
                                    ? ""
                                    : title_travel_name,
                                fontweight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              CustomText(
                                  padding: EdgeInsets.only(top: 2.h),
                                  text: address ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: AppFonts.t4_2),
                              Spacer(),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                            child: CustomText(
                                text: travel_type ?? '',
                                fontSize: AppFonts.t4_2),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: offerPrice ?? '',
                                        color: Colors.black38,
                                        underline: true,
                                        fontSize: AppFonts.t4_2),

                                    CustomText(
                                        text: priceDay ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: AppFonts.t4_2),
                                    // SizedBox(
                                    //   width: 5.w,
                                    // ),
                                    // CustomText(
                                    //     text: 'كود الوحدة ($code)',
                                    //     overflow: TextOverflow.ellipsis,
                                    //     fontSize: AppFonts.t4_2),
                                  ],
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(bottom: 2.w),
                                //   child: Row(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       CustomText(
                                //           padding:
                                //               EdgeInsets.symmetric(vertical: 1.h),
                                //           text: "الاجمالي : " + totalPrice,
                                //           overflow: TextOverflow.ellipsis,
                                //           fontSize: AppFonts.t4_2),
                                //       // SizedBox(
                                //       //   width: 11.w,
                                //       // ),
                                //       // if (address != null)
                                //       //   CustomText(
                                //       //       padding:
                                //       //           EdgeInsets.symmetric(vertical: 1.h),
                                //       //       text: address,
                                //       //       overflow: TextOverflow.ellipsis,
                                //       //       fontSize: AppFonts.t4_2),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 2.h,
                  top: 2.h,
                  child: InkWell(
                    onTap: onTapFav,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: isFavourite
                              ? AppColor.whiteColor.withOpacity(.7)
                              : AppColor.grayColor.withOpacity(.7)),
                      child: isFavourite
                          ? Image.asset(
                              AppImages.unLikeFavIc,
                              color: Colors.red,
                              width: 4.5.w,
                            )
                          : Image.asset(
                              AppImages.unLikeFavIc,
                              color: AppColor.whiteColor,
                              width: 4.5.w,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  left: 2.h,
                  top: 2.h,
                  child: InkWell(
                    onTap: onTapFav,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: isFavourite
                              ? AppColor.whiteColor.withOpacity(.7)
                              : AppColor.grayColor.withOpacity(.7)),
                      child: isFavourite
                          ? Image.asset(
                              AppImages.unLikeFavIc,
                              color: Colors.red,
                              width: 4.5.w,
                            )
                          : Image.asset(
                              AppImages.unLikeFavIc,
                              color: AppColor.whiteColor,
                              width: 4.5.w,
                            ),
                    ),
                  ),
                ),
                Visibility(
                  visible: offerPrice != null,
                  child: Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 30.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black38,
                            ),
                            child: CustomText(
                                text: 'خصم % $offerPrice', color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget buildCardItem({
  void Function()? onTap,
  required String image,
  required String title,
  required String priceDay,
  required String totalPrice,
  String? code,
  String? address,
  String? offerPrice,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w),
    child: InkWell(
      borderRadius: BorderRadius.circular(2.w),
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            color: AppColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(0, 2.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.w),
                      topRight: Radius.circular(2.w)),
                  child: Image.asset(
                    image,
                    width: 100.w,
                    height: 14.h,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          text: title,
                          fontweight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: offerPrice != null,
                                child: Row(
                                  children: [
                                    CustomText(
                                        text: offerPrice,
                                        color: Colors.black38,
                                        underline: true,
                                        fontSize: AppFonts.t4_2),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                  text: priceDay,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: AppFonts.t4_2),
                              SizedBox(
                                width: 5.w,
                              ),
                              // CustomText(
                              //     text: 'كود الوحدة ($code)',
                              //     overflow: TextOverflow.ellipsis,
                              //     fontSize: AppFonts.t4_2),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.h),
                                    text: "الاجمالي : " + totalPrice,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppFonts.t4_2),
                                SizedBox(
                                  width: 11.w,
                                ),
                                CustomText(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.h),
                                    text: address,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppFonts.t4_2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              Visibility(
                visible: offerPrice != null,
                child: Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 30.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black38,
                          ),
                          child: CustomText(
                              text: 'خصم % $offerPrice', color: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 8.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black38,
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/vuesax-linear-heart.svg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
