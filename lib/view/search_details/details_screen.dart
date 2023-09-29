import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/customBtn.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/controller/comments_controller.dart';
import 'package:ejazah/controller/favourite_controller/favourite_controller.dart';
import 'package:ejazah/model/comments.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/chat/chat_screen.dart';
import 'package:ejazah/view/home/driver_Screens/choose_address_driver_screen.dart';
import 'package:ejazah/view/home/reservation_details.dart';
import 'package:ejazah/view/search_details/write_comment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/myNavigate.dart';
import '../../components/map_screen.dart';
import '../../model/search_models/search_result_model.dart';
import 'widgets/sliderWidget.dart';

class DetailsScreen extends StatefulWidget {
  final Ads ads;
  final bool isCheckOrder;
  final bool isSeller;

  DetailsScreen({
    super.key,
    required this.ads,
    this.isCheckOrder = false,
    this.isSeller = false,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late bool isFav;
  late int _counter = 1;

  final TextEditingController fromController = TextEditingController(),
      toController = TextEditingController();

  bool isExistMap = true;
  RequestState requestState = RequestState.waiting;
  Comment? comments;

  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    comments =
        await GetCommentsController.getCommentsad(id: '${widget.ads.id}');
    if (comments != null) {
      setState(() => requestState = RequestState.success);
    } else {
      setState(() => requestState = RequestState.error);
    }
  }

  late TabController controller;
  @override
  void initState() {
    isFav = widget.ads.favourite!;
    if (widget.ads.long == null || widget.ads.long!.isEmpty) isExistMap = false;
    getData();
    controller = new TabController(vsync: this, length: isExistMap ? 4 : 3);
    super.initState();
  }

  final GlobalKey<dynamic> _sliderKey = GlobalKey();

  late DateTime to;
  late DateTime from;
  late DateTime initFrom;

  int difference = 0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int index = 0;
  bool isOwner = false;
  @override
  Widget build(BuildContext context) {
    log("id -------> ${widget.ads.id.toString()}");
    log("current_user_id -------> ${CurrentUser.id.toString()}");
    (() {
      setState(() {
        isOwner = CurrentUser.id == widget.ads.ads_user_id ? true : false;
      });
    }());
    controller.addListener(() {
      if (controller.indexIsChanging) {
        setState(() {
          index = controller.index;
        });
      }
    });
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, isFav);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: DefaultTabController(
          length: isExistMap ? 4 : 3,
          child: SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                SliderWidget(
                  imageList: widget.ads.images!.map((e) => e.image!).toList(),
                  sliderKey: _sliderKey,
                ),
                Positioned(
                  top: 28.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 3.w, horizontal: 3.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9.w),
                      topRight: Radius.circular(9.w),
                    )),
                    child: Column(
                      children: [
                        TabBar(
                            controller: controller,
                            padding: EdgeInsets.only(top: 2.w),
                            automaticIndicatorColorAdjustment: false,
                            indicatorColor: AppColor.orangeColor,
                            labelColor: AppColor.orangeColor,
                            labelStyle: TextStyle(
                              fontSize: AppFonts.t4_2,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryColor,
                            ),
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: "الموصفات",
                              ),
                              Tab(
                                text: "التقيمات",
                              ),
                              if (isExistMap)
                                Tab(
                                  text: "الخريطة",
                                ),
                              Tab(
                                text: "الشروط",
                              )
                            ]),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          height: 70.h,
                          width: 100.w,
                          child: TabBarView(
                              controller: controller,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Builder(
                                  builder: (context) {
                                    log("-----------> $index");
                                    double max = 0;

                                    if (widget.ads.commenets != null) {
                                      widget.ads.commenets!.forEach((element) {
                                        if (double.parse(element.rate!) > max) {
                                          max = double.parse(element.rate!);
                                        }
                                      });
                                    }

                                    String id = widget.ads.categoryId!;
                                    if (id == '6') {
                                      return ListView(
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconTextWidget(
                                                          icon: Icon(
                                                            CupertinoIcons
                                                                .person_alt,
                                                            color: AppColor
                                                                .orangeColor,
                                                          ),
                                                          text:
                                                              "${widget.ads.ads_user_name}",
                                                        ),
                                                        if (widget.ads
                                                                .documentation ==
                                                            "1")
                                                          SizedBox(
                                                              width: 1.0.w),
                                                        if (widget.ads
                                                                .documentation ==
                                                            "1")
                                                          Icon(
                                                            CupertinoIcons
                                                                .check_mark_circled_solid,
                                                            size: 2.0.h,
                                                            color: Colors
                                                                .green.shade600,
                                                          )
                                                      ],
                                                    ),
                                                    SizedBox(width: 1.0.w),
                                                    IconTextWidget(
                                                        icon: AppImages.starIc,
                                                        text:
                                                            '${max} (${widget.ads.commenets!.length}تقييم)'),
                                                    SizedBox(width: 1.w),
                                                    IconTextWidget(
                                                        icon: AppImages
                                                            .locationIc,
                                                        text:
                                                            '${widget.ads.city} ${widget.ads.street_name!.isEmpty ? "" : ", ${widget.ads.street_name}"}'),
                                                  ],
                                                ),
                                                //

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    IconTextWidget(
                                                        icon: AppImages.starIc,
                                                        text: 'عدد التذاكر  '
                                                            '(${widget.ads.ticket_count!.isEmpty ? '0' : '${widget.ads.ticket_count}'})'),
                                                    SizedBox(
                                                      width: 9.w,
                                                    ),
                                                    IconTextWidget(
                                                        icon: AppImages.starIc,
                                                        text: 'سعر التذكرة  ('
                                                            '${widget.ads.price}) ${widget.ads.currency}'),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            color: AppColor.greenSecondColor
                                                .withOpacity(.1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    text: 'وصف الإعلان',
                                                    fontSize: AppFonts.t2,
                                                    fontweight:
                                                        FontWeight.bold),
                                                SizedBox(height: 2.h),
                                                CustomText(
                                                  text: '${widget.ads.desc}',
                                                  fontSize: AppFonts.t3,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            color: AppColor.greenSecondColor
                                                .withOpacity(.1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    text: 'أوقات عمل الفاعلية',
                                                    fontSize: AppFonts.t2,
                                                    fontweight:
                                                        FontWeight.bold),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      child: CustomText(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.w),
                                                        text:
                                                            'من ${widget.ads.from}',
                                                        fontSize: AppFonts.t3,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20.w,
                                                    ),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      child: CustomText(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.w),
                                                        text:
                                                            ' إلى ${widget.ads.to}',
                                                        fontSize: AppFonts.t3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                CustomText(
                                                  padding:
                                                      EdgeInsets.only(top: 2.w),
                                                  text: 'ساعات العمل: '
                                                      'من ${widget.ads.to_hours}:00 الي ${widget.ads.from_hours}:00',
                                                  fontSize: AppFonts.t3,
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (isOwner == true)
                                            SizedBox(height: 4.h),
                                          if (isOwner == false)
                                            if (widget.isSeller == false)
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 2.h,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        2.w),
                                                            text:
                                                                'عندك استفسار ؟',
                                                            fontSize:
                                                                AppFonts.t2,
                                                            fontweight:
                                                                FontWeight
                                                                    .bold),
                                                      ],
                                                    ),
                                                    CustomButton(
                                                        onPressed: () {
                                                          myNavigate(
                                                              screen: ChatScreen(
                                                                  token: widget
                                                                      .ads
                                                                      .token,
                                                                  adsOwner: widget
                                                                      .ads
                                                                      .adsOwner,
                                                                  img: widget
                                                                      .ads
                                                                      .sellerImage),
                                                              context: context);
                                                        },
                                                        width: 32.w,
                                                        height: 6.h,
                                                        radius: 2.w,
                                                        text: 'اسال المضيف',
                                                        color:
                                                            AppColor.whiteColor,
                                                        textColor: AppColor
                                                            .primaryColor)
                                                  ],
                                                ),
                                              ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Column(
                                            children: [
                                              if (widget.isSeller == false)
                                                if (int.parse(widget
                                                            .ads
                                                            .ticket_count!
                                                            .isEmpty
                                                        ? "0"
                                                        : '${widget.ads.ticket_count}') !=
                                                    0)
                                                  widget.ads.categoryId == "6"
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 1.w),
                                                              text:
                                                                  'إختر عدد التذاكر',
                                                              fontSize:
                                                                  AppFonts.t3,
                                                            ),
                                                            const Spacer(),
                                                            FloatingActionButton(
                                                              backgroundColor:
                                                                  AppColor
                                                                      .buttonColor,
                                                              onPressed: () {
                                                                setState(() {
                                                                  log('${widget.ads.ticket_count}');
                                                                  if (widget.ads
                                                                          .ticket_count ==
                                                                      "0") {
                                                                    return;
                                                                  }
                                                                  if (_counter ==
                                                                      int.parse(widget
                                                                          .ads
                                                                          .ticket_count!)) {
                                                                    return;
                                                                  } else {
                                                                    _counter++;
                                                                  }
                                                                });
                                                              },
                                                              mini: true,
                                                              heroTag:
                                                                  'Increment',
                                                              tooltip:
                                                                  'Increment',
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: AppColor
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 1.h),
                                                              child: Text(
                                                                '$_counter',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headlineMedium,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            FloatingActionButton(
                                                              backgroundColor:
                                                                  AppColor
                                                                      .buttonColor,
                                                              mini: true,
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (_counter ==
                                                                      1) return;
                                                                  _counter--;
                                                                });
                                                              },
                                                              tooltip:
                                                                  'deIncrement',
                                                              heroTag:
                                                                  'deIncrement',
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            12.0),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .minimize,
                                                                  color: AppColor
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox(
                                                          height: 4.h,
                                                        ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              (widget.ads.ticket_count!.isEmpty)
                                                  ? Center(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(1.h),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.5.h),
                                                            border: Border.all(
                                                                width: 1.5,
                                                                color: Colors
                                                                    .red
                                                                    .shade600)),
                                                        child: CustomText(
                                                          text: 'محـجوز',
                                                          fontSize: AppFonts.t2,
                                                          fontweight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .red.shade600,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              /* (widget.isOrder)
                                                  ? Center(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(1.h),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        1.h),
                                                            border: Border.all(
                                                                color: AppColor
                                                                    .grayColor)),
                                                        child: CustomText(
                                                            text:
                                                                'تم حجز هذا الإعلان بالفعل',
                                                            fontSize:
                                                                AppFonts.t1),
                                                      ),
                                                    )
                                                  : Container(), */
                                            ],
                                          ),
                                        ],
                                      );
                                    } else if (id == '8') {
                                      return ListView(
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            color: AppColor.greenSecondColor
                                                .withOpacity(.1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    IconTextWidget(
                                                      icon: Icon(
                                                        CupertinoIcons
                                                            .person_alt,
                                                        color: AppColor
                                                            .orangeColor,
                                                      ),
                                                      text:
                                                          "${widget.ads.ads_user_name}",
                                                    ),
                                                    if (widget.ads
                                                            .documentation ==
                                                        "1")
                                                      SizedBox(width: 1.0.w),
                                                    if (widget.ads
                                                            .documentation ==
                                                        "1")
                                                      Icon(
                                                        CupertinoIcons
                                                            .check_mark_circled_solid,
                                                        size: 2.0.h,
                                                        color: Colors
                                                            .green.shade600,
                                                      )
                                                  ],
                                                ),
                                                CustomText(
                                                    text: 'تفاصيل الرحلة',
                                                    fontSize: AppFonts.t2,
                                                    fontweight:
                                                        FontWeight.bold),
                                                CustomText(
                                                    padding: EdgeInsets.only(
                                                        top: 2.w),
                                                    text:
                                                        'رحلة إلى ${widget.ads.country} ',
                                                    fontSize: AppFonts.t3),
                                                CustomText(
                                                    padding: EdgeInsets.only(
                                                        top: 2.w),
                                                    text:
                                                        'نوع الرحلة ${widget.ads.travel_name} ',
                                                    fontSize: AppFonts.t3),
                                                if (widget
                                                        .ads.from!.isNotEmpty &&
                                                    widget.ads.to!.isNotEmpty)
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 2.w),
                                                          text:
                                                              'من ${widget.ads.from} ',
                                                          fontSize:
                                                              AppFonts.t3),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      CustomText(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 2.w),
                                                          text:
                                                              'إلي ${widget.ads.to} ',
                                                          fontSize:
                                                              AppFonts.t3),
                                                    ],
                                                  ),

                                                Row(
                                                  children: [
                                                    CustomText(
                                                      padding: EdgeInsets.only(
                                                          top: 2.w),
                                                      text:
                                                          "${widget.ads.go == '0' && widget.ads.back == '0' ? 'لا ' : ''}يشمل تذاكر طيران  ",
                                                      fontSize: AppFonts.t3,
                                                    ),
                                                    if (widget.ads.go != '0' ||
                                                        widget.ads.back != '0')
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 2.w),
                                                              text: ':',
                                                              fontSize:
                                                                  AppFonts.t3),
                                                          if (widget.ads.go !=
                                                              '0')
                                                            CustomText(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 2
                                                                            .w),
                                                                text: 'ذهاب. ',
                                                                fontSize:
                                                                    AppFonts
                                                                        .t3),
                                                          if (widget.ads.back !=
                                                              '0')
                                                            CustomText(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 2
                                                                            .w),
                                                                text: 'عودة. ',
                                                                fontSize:
                                                                    AppFonts
                                                                        .t3),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    CustomText(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.w),
                                                        text:
                                                            "${widget.ads.main_meal == '0' ? 'لا ' : ''}يشمل وجبة رئيسية  ",
                                                        fontSize: AppFonts.t3),
                                                    if (widget.ads.main_meal !=
                                                        '0')
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 2.w),
                                                              text: ':',
                                                              fontSize:
                                                                  AppFonts.t3),
                                                          if (widget.ads
                                                                  .breakfast !=
                                                              '0')
                                                            CustomText(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 2
                                                                            .w),
                                                                text: 'فطار. ',
                                                                fontSize:
                                                                    AppFonts
                                                                        .t3),
                                                          if (widget
                                                                  .ads.dinner !=
                                                              '0')
                                                            CustomText(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 2
                                                                            .w),
                                                                text: 'غداء. ',
                                                                fontSize:
                                                                    AppFonts
                                                                        .t3),
                                                          if (widget
                                                                  .ads.lunch !=
                                                              '0')
                                                            CustomText(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 2
                                                                            .w),
                                                                text: 'عشاء. ',
                                                                fontSize:
                                                                    AppFonts
                                                                        .t3),
                                                        ],
                                                      ),
                                                  ],
                                                ),

                                                // if (widget.ads.accompanying !=
                                                //     null)
                                                //   for (int i = 0;
                                                //       i <
                                                //           widget
                                                //               .ads
                                                //               .accompanying!
                                                //               .length;
                                                //       i++)
                                                //     Builder(
                                                //         builder: (context) {
                                                //       final item = widget.ads
                                                //           .accompanying![i];
                                                //       return CustomText(
                                                //           padding:
                                                //               EdgeInsets.only(
                                                //                   top: 2.w),
                                                //           text:
                                                //               '${item.name}',
                                                //           fontSize:
                                                //               AppFonts.t3);
                                                //     })
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            color: AppColor.greenSecondColor
                                                .withOpacity(.1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    text: 'وصف الإعلان',
                                                    fontSize: AppFonts.t2,
                                                    fontweight:
                                                        FontWeight.bold),
                                                SizedBox(height: 2.h),
                                                CustomText(
                                                  text: '${widget.ads.desc}',
                                                  fontSize: AppFonts.t3,
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (!(widget.ads.isMine ?? true))
                                            if (isOwner == true)
                                              SizedBox(height: 4.h),
                                          if (isOwner == false)
                                            if (widget.isSeller == false)
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        2.w),
                                                            text:
                                                                'عندك استفسار ؟',
                                                            fontSize:
                                                                AppFonts.t2,
                                                            fontweight:
                                                                FontWeight
                                                                    .bold),
                                                      ],
                                                    ),
                                                    CustomButton(
                                                        onPressed: () {
                                                          myNavigate(
                                                              screen: ChatScreen(
                                                                  token: widget
                                                                      .ads
                                                                      .token,
                                                                  adsOwner: widget
                                                                      .ads
                                                                      .adsOwner,
                                                                  img: widget
                                                                      .ads
                                                                      .sellerImage),
                                                              context: context);
                                                        },
                                                        width: 32.w,
                                                        height: 6.h,
                                                        radius: 2.w,
                                                        text: 'اسال المضيف',
                                                        color:
                                                            AppColor.whiteColor,
                                                        textColor: AppColor
                                                            .primaryColor)
                                                  ],
                                                ),
                                              ),
                                          SizedBox(height: 2.5.h),
                                          if (widget.isSeller == false)
                                            widget.ads.categoryId == '8'
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      CustomText(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1.w),
                                                        text:
                                                            'إختر عدد الاشخاص',
                                                        fontSize: AppFonts.t3,
                                                      ),
                                                      const Spacer(),
                                                      FloatingActionButton(
                                                        backgroundColor:
                                                            AppColor
                                                                .buttonColor,
                                                        onPressed: () {
                                                          setState(() {
                                                            print(widget.ads
                                                                .passengers);
                                                            if (widget.ads
                                                                        .passengers ==
                                                                    null ||
                                                                widget
                                                                    .ads
                                                                    .passengers!
                                                                    .isEmpty)
                                                              widget.ads
                                                                      .passengers =
                                                                  '0';
                                                            if (_counter ==
                                                                int.parse(widget
                                                                    .ads
                                                                    .passengers!))
                                                              return;
                                                            _counter++;
                                                          });
                                                        },
                                                        mini: true,
                                                        heroTag: 'Increment',
                                                        tooltip: 'Increment',
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: AppColor
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.w,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1.h),
                                                        child: Text(
                                                          '$_counter',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineMedium,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.w,
                                                      ),
                                                      FloatingActionButton(
                                                        backgroundColor:
                                                            AppColor
                                                                .buttonColor,
                                                        mini: true,
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_counter == 1)
                                                              return;
                                                            _counter--;
                                                          });
                                                        },
                                                        tooltip: 'deIncrement',
                                                        heroTag: 'deIncrement',
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 12.0),
                                                          child: const Icon(
                                                            Icons.minimize,
                                                            color: AppColor
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 4.h,
                                                  ),
                                        ],
                                      );
                                    } else if (id == '9') {
                                      return ListView(
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      IconTextWidget(
                                                        icon: Icon(
                                                          CupertinoIcons
                                                              .person_alt,
                                                          color: AppColor
                                                              .orangeColor,
                                                        ),
                                                        text:
                                                            "${widget.ads.ads_user_name}",
                                                      ),
                                                      if (widget.ads
                                                              .documentation ==
                                                          "1")
                                                        SizedBox(width: 1.0.w),
                                                      if (widget.ads
                                                              .documentation ==
                                                          "1")
                                                        Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled_solid,
                                                          size: 2.0.h,
                                                          color: Colors
                                                              .green.shade600,
                                                        )
                                                    ],
                                                  ),
                                                  CustomText(
                                                      color:
                                                          AppColor.secondColor,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.w),
                                                      text:
                                                          '${widget.ads.name}',
                                                      fontSize: AppFonts.t2,
                                                      fontweight:
                                                          FontWeight.bold),
                                                  CustomText(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.w),
                                                    text: '${widget.ads.desc}',
                                                    fontSize: AppFonts.t3,
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          // CustomText(
                                          //     padding: EdgeInsets.symmetric(
                                          //         vertical: 2.w),
                                          //     text: 'اقتراحات مشابهه',
                                          //     fontSize: AppFonts.t2,
                                          //     fontweight: FontWeight.bold),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          // SearchResultWidget(
                                          //     onTap: () => myNavigate(
                                          //         screen: CitiesTripdetails_screen(),
                                          //         context: context),
                                          //     priceDay: "200 رس / ليلة",
                                          //     address: 'جدة -حي الوريني',
                                          //     code: '2565',
                                          //     title: 'شقه فاخرة بجدة',
                                          //     image: AppImages.ReyadIc,
                                          //     totalPrice: '400 رس شهريا')
                                        ],
                                      );
                                    } else {
                                      return ListView(
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        children: [
                                          if (widget.ads.insurance == '1')
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.w,
                                                  horizontal: 3.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.w),
                                                  color: AppColor
                                                      .greenSecondColor
                                                      .withOpacity(.1)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: CustomText(
                                                        color:
                                                            AppColor.greenColor,
                                                        maxLines: 3,
                                                        text:
                                                            'يوجد مبلغ تأمين علي السكن ويتم دفعه مره واحدة عند بدايه  الحجز وتستلمه  في حاله الرحيل اذا لم يكن هناك اضرار (${widget.ads.insuranceValue} ${widget.ads.currency})'),
                                                  )
                                                ],
                                              ),
                                            ),
                                          if (widget.ads.insurance == '0' &&
                                              widget.ads.categoryId != '7')
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.w,
                                                  horizontal: 3.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.w),
                                                  color: AppColor
                                                      .greenSecondColor
                                                      .withOpacity(.1)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: CustomText(
                                                        color:
                                                            AppColor.greenColor,
                                                        maxLines: 1,
                                                        text: 'لا يوجد تأمين'),
                                                  )
                                                ],
                                              ),
                                            ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (widget.ads.categoryId ==
                                                        "7")
                                                      Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.w),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: widget
                                                                  .ads
                                                                  .guide_image!,
                                                              width: 10.w,
                                                              height: 10.w,
                                                            ),
                                                          ),
                                                          CustomText(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        1.5.w),
                                                            text:
                                                                "${widget.ads.ads_user_name}",
                                                            fontSize:
                                                                AppFonts.t4_2,
                                                          ),
                                                          if (widget.ads
                                                                  .documentation ==
                                                              "1")
                                                            SizedBox(
                                                                width: 1.0.w),
                                                          if (widget.ads
                                                                  .documentation ==
                                                              "1")
                                                            Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled_solid,
                                                              size: 2.0.h,
                                                              color: Colors
                                                                  .green
                                                                  .shade600,
                                                            )
                                                        ],
                                                      ),
                                                    if (widget.ads.categoryId !=
                                                        "7")
                                                      Row(
                                                        children: [
                                                          IconTextWidget(
                                                            icon: Icon(
                                                              CupertinoIcons
                                                                  .person_alt,
                                                              color: AppColor
                                                                  .orangeColor,
                                                            ),
                                                            text:
                                                                "${widget.ads.ads_user_name}",
                                                          ),
                                                          if (widget.ads
                                                                  .documentation ==
                                                              "1")
                                                            SizedBox(
                                                                width: 1.0.w),
                                                          if (widget.ads
                                                                  .documentation ==
                                                              "1")
                                                            Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled_solid,
                                                              size: 2.0.h,
                                                              color: Colors
                                                                  .green
                                                                  .shade600,
                                                            )
                                                        ],
                                                      ),
                                                    if (widget.ads.categoryId !=
                                                        '7')
                                                      IconTextWidget(
                                                          icon:
                                                              AppImages.starIc,
                                                          text:
                                                              '${max} (${widget.ads.commenets!.length}تقييم)'),
                                                    if (widget.ads.categoryId ==
                                                        '7')
                                                      IconTextWidget(
                                                          icon:
                                                              AppImages.spacIc,
                                                          text:
                                                              'نوع السيارة  ${widget.ads.name}'),
                                                    if (widget.ads.categoryId !=
                                                        '7')
                                                      IconTextWidget(
                                                          icon: AppImages
                                                              .locationIc,
                                                          text:
                                                              'مساحة الوحدة ${widget.ads.area} متر'),
                                                    if (widget.ads.categoryId !=
                                                        '7')
                                                      IconTextWidget(
                                                          icon: AppImages
                                                              .animalIc,
                                                          text:
                                                              '${widget.ads.animals == '0' ? 'لا' : ''} يسمح بإصطحاب الحيوانات'),
                                                    if (widget.ads.categoryId ==
                                                        '7')
                                                      IconTextWidget(
                                                          icon:
                                                              AppImages.spacIc,
                                                          text:
                                                              'لغة السائق  ${widget.ads.language}'),
                                                  ],
                                                ),
                                                (widget.ads.categoryId == '7')
                                                    ? SizedBox(width: 8.w)
                                                    : SizedBox(width: 2.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (widget.ads.categoryId !=
                                                        '7')
                                                      IconTextWidget(
                                                          icon: AppImages
                                                              .locationIc,
                                                          text:
                                                              '${widget.ads.city} ${widget.ads.street_name!.isEmpty ? "" : ", ${widget.ads.street_name}"}'),
                                                    if (widget.ads.categoryId !=
                                                        '7')
                                                      IconTextWidget(
                                                        icon:
                                                            AppImages.peopleIc,
                                                        text: widget.ads.individual ==
                                                                    "1" &&
                                                                widget.ads
                                                                        .families ==
                                                                    "1"
                                                            ? "السكن متاح للعوائل و الأفراد"
                                                            : widget.ads.individual ==
                                                                    "1"
                                                                ? "السكن متاح للأفراد"
                                                                : widget.ads.families ==
                                                                        "1"
                                                                    ? "السكن متاح للعوائل"
                                                                    : "",
                                                      ),
                                                    if (widget.ads.categoryId ==
                                                        '7')
                                                      IconTextWidget(
                                                        icon:
                                                            AppImages.peopleIc,
                                                        text:
                                                            "الحد الاقصي للركاب  ${widget.ads.passengers}",
                                                      ),
                                                    if (widget.ads.categoryId ==
                                                        '7')
                                                      IconTextWidget(
                                                          icon:
                                                              AppImages.spacIc,
                                                          text:
                                                              'موديل السيارة  ${widget.ads.moodle}'),
                                                    if (widget.ads.categoryId !=
                                                        '7')
                                                      IconTextWidget(
                                                          icon: Icon(
                                                            Icons.smoking_rooms,
                                                            color: AppColor
                                                                .orangeColor,
                                                          ),
                                                          text:
                                                              '${widget.ads.smoking == '0' ? 'لا' : ''} يسمح بالتدخين'),
                                                    if (widget.ads.categoryId ==
                                                        '7')
                                                      IconTextWidget(
                                                          icon:
                                                              AppImages.spacIc,
                                                          text:
                                                              'ترخيص السيارة  ${widget.ads.license_number}'),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            color: AppColor.greenSecondColor
                                                .withOpacity(.1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    text: 'وصف الإعلان',
                                                    fontSize: AppFonts.t2,
                                                    fontweight:
                                                        FontWeight.bold),
                                                SizedBox(height: 2.h),
                                                CustomText(
                                                  text: '${widget.ads.desc}',
                                                  fontSize: AppFonts.t3,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          if (widget.ads.categoryId != "7")
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              color: AppColor.greenSecondColor
                                                  .withOpacity(.1),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                      text: 'المرافق',
                                                      fontSize: AppFonts.t2,
                                                      fontweight:
                                                          FontWeight.bold),
                                                  Visibility(
                                                    visible:
                                                        widget.ads.visits !=
                                                            '0',
                                                    child: CustomText(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.w),
                                                        text:
                                                            'مجلس رئيسي يسع ${widget.ads.visits} افراد',
                                                        fontSize: AppFonts.t3),
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        widget.ads.bedRoom !=
                                                            '0',
                                                    child: CustomText(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.w),
                                                        text:
                                                            'غرف نوم ${widget.ads.bedRoom}',
                                                        fontSize: AppFonts.t3),
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        widget.ads.bathrooms !=
                                                            '0',
                                                    child: CustomText(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.w),
                                                        text:
                                                            'دورة مياه ${widget.ads.bathrooms}',
                                                        fontSize: AppFonts.t3),
                                                  ),
                                                  if (widget.ads.accompanying !=
                                                      null)
                                                    for (int i = 0;
                                                        i <
                                                            widget
                                                                .ads
                                                                .accompanying!
                                                                .length;
                                                        i++)
                                                      Builder(
                                                        builder: (context) {
                                                          final item = widget
                                                              .ads
                                                              .accompanying![i];

                                                          return (item.status ==
                                                                  1)
                                                              ? CustomText(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top: 2
                                                                              .w),
                                                                  text:
                                                                      '${item.name}',
                                                                  fontSize:
                                                                      AppFonts
                                                                          .t3)
                                                              : SizedBox
                                                                  .shrink();
                                                        },
                                                      ),
                                                ],
                                              ),
                                            ),
                                          if (isOwner == true)
                                            SizedBox(height: 4.h),
                                          if (isOwner == false)
                                            if (widget.isSeller == false)
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        2.w),
                                                            text:
                                                                'عندك استفسار ؟',
                                                            fontSize:
                                                                AppFonts.t2,
                                                            fontweight:
                                                                FontWeight
                                                                    .bold),
                                                      ],
                                                    ),
                                                    CustomButton(
                                                        onPressed: () {
                                                          myNavigate(
                                                              screen: ChatScreen(
                                                                  token: widget
                                                                      .ads
                                                                      .token,
                                                                  adsOwner: widget
                                                                      .ads
                                                                      .adsOwner,
                                                                  img: widget
                                                                      .ads
                                                                      .sellerImage),
                                                              context: context);
                                                        },
                                                        width: 32.w,
                                                        height: 6.h,
                                                        radius: 2.w,
                                                        text: 'اسال المضيف',
                                                        color:
                                                            AppColor.whiteColor,
                                                        textColor: AppColor
                                                            .primaryColor)
                                                  ],
                                                ),
                                              ),
                                          if (widget.ads.categoryId == "7" &&
                                              isExistMap == true &&
                                              widget.isSeller == true)
                                            if (widget.ads.order_address != "")
                                              Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.5.h),
                                                    border: Border.all(
                                                      width: 1.5,
                                                      color:
                                                          Colors.red.shade600,
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        controller.index = 2;
                                                      });
                                                    },
                                                    child: CustomText(
                                                      text:
                                                          'يرجي التوجه الي الخريطة لتتبع موقع العميـل',
                                                      fontSize: AppFonts.t2,
                                                      fontweight:
                                                          FontWeight.w600,
                                                      color:
                                                          Colors.red.shade600,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                          /* if (widget.isMe == false)
                                            if (widget.ads.is_pay == "0")
                                              widget.ads.categoryId == '7'
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1.w),
                                                          text:
                                                              'إختر عدد الساعات',
                                                          fontSize: AppFonts.t3,
                                                        ),
                                                        const Spacer(),
                                                        FloatingActionButton(
                                                          backgroundColor:
                                                              AppColor
                                                                  .buttonColor,
                                                          onPressed: () {
                                                            setState(() {
                                                              _counter++;
                                                            });
                                                          },
                                                          mini: true,
                                                          heroTag: 'Increment',
                                                          tooltip: 'Increment',
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: AppColor
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1.h),
                                                          child: Text(
                                                            '$_counter',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineMedium,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        FloatingActionButton(
                                                          backgroundColor:
                                                              AppColor
                                                                  .buttonColor,
                                                          mini: true,
                                                          onPressed: () {
                                                            setState(() {
                                                              if (_counter == 1)
                                                                return;
                                                              _counter--;
                                                            });
                                                          },
                                                          tooltip:
                                                              'deIncrement',
                                                          heroTag:
                                                              'deIncrement',
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        12.0),
                                                            child: const Icon(
                                                              Icons.minimize,
                                                              color: AppColor
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox(
                                                      height: 4.h,
                                                    ), */
                                          if (widget.isSeller == false)
                                            if (widget.ads.categoryId != "7")
                                              if (widget.ads.is_pay == "0")
                                                if (!widget.isCheckOrder)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15.0),
                                                    child: Container(
                                                      height: 6.h,
                                                      child: TextFormField(
                                                        controller:
                                                            fromController,
                                                        readOnly: true,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'Is Required'
                                                                : null,
                                                        decoration:
                                                            InputDecoration(
                                                          prefixText: ' ',
                                                          hintText: 'من',
                                                          prefixIcon: Icon(Icons
                                                              .calendar_today_rounded),
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        onTap: () async {
                                                          final date =
                                                              await showDatePicker(
                                                            builder: (context,
                                                                child) {
                                                              return Theme(
                                                                data: Theme.of(
                                                                        context)
                                                                    .copyWith(
                                                                  colorScheme:
                                                                      ColorScheme
                                                                          .light(
                                                                    primary:
                                                                        AppColor
                                                                            .buttonColor,
                                                                    onPrimary:
                                                                        Colors
                                                                            .white, // <-- SEE HERE
                                                                    onSurface:
                                                                        AppColor
                                                                            .buttonColor, // <-- SEE HERE
                                                                  ),
                                                                ),
                                                                child: child!,
                                                              );
                                                            },
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1950),
                                                            lastDate:
                                                                DateTime(2100),
                                                          );
                                                          if (date == null) {
                                                            fromController
                                                                .clear();
                                                            return;
                                                          }
                                                          from = date;
                                                          // String birthday = DateFormat.yMd().format(date);
                                                          String dateTime = date
                                                                  .year
                                                                  .toString() +
                                                              '-' +
                                                              date.month
                                                                  .toString() +
                                                              '-' +
                                                              date.day
                                                                  .toString();

                                                          log("=========> " +
                                                              dateTime);
                                                          if (toController.text
                                                              .isNotEmpty) {
                                                            difference = to
                                                                .difference(
                                                                    from)
                                                                .inDays;
                                                          }
                                                          fromController.text =
                                                              dateTime;
                                                          initFrom = DateTime(
                                                              from.year,
                                                              from.month,
                                                              from.day + 1);

                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                          if (widget.isSeller == false)
                                            if (widget.ads.categoryId != "7")
                                              if (widget.ads.is_pay == "0")
                                                if (!widget.isCheckOrder)
                                                  Container(
                                                    height: 6.h,
                                                    child: TextFormField(
                                                      controller: toController,
                                                      readOnly: true,
                                                      validator: (value) =>
                                                          value!.isEmpty
                                                              ? 'Is Required'
                                                              : null,
                                                      decoration:
                                                          InputDecoration(
                                                        prefixText: ' ',
                                                        hintText: 'إلى',
                                                        prefixIcon: Icon(Icons
                                                            .calendar_today_rounded),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      onTap: () async {
                                                        final date =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate: initFrom,
                                                          firstDate:
                                                              DateTime(1950),
                                                          lastDate:
                                                              DateTime(2100),
                                                        );
                                                        if (date == null) {
                                                          toController.clear();
                                                          return;
                                                        }
                                                        to = date;
                                                        difference = to
                                                            .difference(from)
                                                            .inDays;
                                                        setState(() {});
                                                        // String birthday = DateFormat.yMd().format(date);
                                                        String dateTime = date
                                                                .year
                                                                .toString() +
                                                            '-' +
                                                            date.month
                                                                .toString() +
                                                            '-' +
                                                            date.day.toString();
                                                        print(dateTime);
                                                        toController.text =
                                                            dateTime;
                                                      },
                                                    ),
                                                  ),
                                          if (!widget.isCheckOrder)
                                            SizedBox(height: 15),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                ListView(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  children: [
                                    CustomText(
                                      padding: EdgeInsets.only(bottom: 2.w),
                                      text: 'وش قالوا ضيوف المكان',
                                      fontweight: FontWeight.bold,
                                    ),
                                    TextButton(
                                      onPressed: () => myNavigate(
                                        screen: WriteCommentScreen(
                                          ads_id: '${widget.ads.id}',
                                        ),
                                        context: context,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: "اكتب مراجعـتك",
                                            color: AppColor.buttonColor,
                                            fontweight: FontWeight.w600,
                                            fontSize: AppFonts.t2,
                                          ),
                                          Icon(CupertinoIcons.chevron_left),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 1.5.h),
                                    CustomText(
                                      text: "التعليقـات",
                                      fontSize: AppFonts.t1,
                                      fontweight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 0.5.h),
                                    StreamBuilder<Comment>(
                                      stream: GetCommentsController
                                          .streamController.stream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Comment> snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                            padding:
                                                EdgeInsets.only(bottom: 10.h),
                                            itemCount:
                                                snapshot.data!.data!.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final item =
                                                  snapshot.data!.data![index];
                                              return RatingWidget(
                                                isDetailScreen: true,
                                                username: item.user_name,
                                                countRate:
                                                    double.parse(item.rate!),
                                                date: item.createdAt,
                                                description: item.commenet,
                                              );
                                            },
                                          );
                                        } else if (comments != null) {
                                          return ListView.builder(
                                            padding:
                                                EdgeInsets.only(bottom: 10.h),
                                            itemCount: comments!.data!.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final item =
                                                  comments!.data![index];
                                              return RatingWidget(
                                                isDetailScreen: true,
                                                username: item.user_name,
                                                countRate:
                                                    double.parse(item.rate!),
                                                date: item.createdAt,
                                                description: item.commenet,
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: AppColor.buttonColor,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                if (isExistMap)
                                  ListView(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    children: [
                                      if (widget.ads.categoryId == "7" &&
                                          widget.isSeller == true)
                                        if (widget.ads.order_address != "")
                                          CustomText(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3.w),
                                              text:
                                                  'الموقع التقريبي : ${widget.ads.order_address}',
                                              fontSize: AppFonts.t3,
                                              fontweight: FontWeight.bold),
                                      if (widget.ads.city!.isNotNullAndNotEmpty)
                                        CustomText(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3.w),
                                            text:
                                                'الموقع التقريبي : ${widget.ads.city} ${widget.ads.street_name!.isEmpty ? "" : ", ${widget.ads.street_name}"}',
                                            fontSize: AppFonts.t3,
                                            fontweight: FontWeight.bold),
                                      MapScreen(
                                        zoom: 14,
                                        latlong: LatLng(
                                            double.parse(widget.ads.lat ?? '0'),
                                            double.parse(
                                                widget.ads.long ?? '0')),
                                        /* AdsOwner: widget.isMe == false
                                            ? widget.ads.adsOwner
                                            : null, */
                                      ),
                                    ],
                                  ),
                                ListView(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  children: [
                                    CustomText(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 3.w,
                                        ),
                                        text: 'شروط الحجز',
                                        fontSize: AppFonts.t3,
                                        fontweight: FontWeight.bold),
                                    ListView.builder(
                                        padding: EdgeInsets.only(
                                            bottom: 30.h, left: 2.h),
                                        itemCount: widget.ads.terms!.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, index) {
                                          final term = widget.ads.terms![index];
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 3.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 1.w,
                                                  backgroundColor:
                                                      AppColor.primaryColor,
                                                ),
                                                Expanded(
                                                  child: CustomText(
                                                      padding: EdgeInsets.only(
                                                          right: 2.w),
                                                      textAlign:
                                                          TextAlign.justify,
                                                      text: '${term.term}'),
                                                ),
                                              ],
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
                if (widget.isSeller == false)
                  if (widget.ads.is_pay == "0")
                    if (index == 0)
                      if (!widget.isCheckOrder)
                        widget.ads.categoryId != '9'
                            ? Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: AppColor.whiteColor,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 3.w),
                                  child: (widget.ads.categoryId == '6' &&
                                          widget.ads.ticket_count!.isEmpty)
                                      ? SizedBox.shrink()
                                      : Row(
                                          children: [
                                            CustomButton(
                                                radius: 2.w,
                                                width:
                                                    widget.ads.categoryId != '9'
                                                        ? 40.w
                                                        : 90.w,
                                                text: 'اختر',
                                                onPressed: () {
                                                  if (isOwner == true) {
                                                    toastShow(
                                                        text:
                                                            "لا يمـكنك حجز الاعلان",
                                                        state: ToastStates
                                                            .warning);
                                                    return;
                                                  }
                                                  if (widget.ads.categoryId != '6' &&
                                                      widget.ads.categoryId !=
                                                          '9' &&
                                                      widget.ads.categoryId !=
                                                          '8' &&
                                                      widget.ads.categoryId !=
                                                          '7') {
                                                    if (toController
                                                            .text.isEmpty ||
                                                        fromController
                                                            .text.isEmpty) {
                                                      toastShow(
                                                          text:
                                                              'برجاء ادخال تاريخ الحجز',
                                                          state: ToastStates
                                                              .warning);
                                                      return;
                                                    }
                                                    difference = to
                                                        .difference(from)
                                                        .inDays;
                                                    setState(() {});
                                                    print(difference);
                                                    if (difference < 1) {
                                                      toastShow(
                                                          text:
                                                              'برجاء ادخال تاريخ الحجز بطريقة صحيحة',
                                                          state: ToastStates
                                                              .error);
                                                      print(difference);
                                                      return;
                                                    }
                                                  }
                                                  if (widget.ads.categoryId ==
                                                      '7')
                                                    myNavigate(
                                                        screen:
                                                            ChooseAddressDriverScreen(
                                                                ads:
                                                                    widget.ads),
                                                        context: context);
                                                  if (widget.ads.categoryId !=
                                                      '7')
                                                    myNavigate(
                                                      screen:
                                                          ReservationdetailsScreen(
                                                        ads: widget.ads,
                                                        from: widget.ads
                                                                    .categoryId ==
                                                                '8'
                                                            ? widget.ads.from
                                                                .toString()
                                                            : fromController
                                                                .text,
                                                        to: widget.ads
                                                                    .categoryId ==
                                                                '8'
                                                            ? widget.ads.to
                                                                .toString()
                                                            : toController.text,
                                                        count: widget.ads
                                                                        .categoryId ==
                                                                    '6' ||
                                                                widget.ads
                                                                        .categoryId ==
                                                                    '8'
                                                            ? _counter
                                                            : difference,
                                                        total: widget.ads
                                                                    .categoryId ==
                                                                '6'
                                                            ? double.parse(
                                                                    '${widget.ads.price ?? "(0.0)"}') *
                                                                (_counter)
                                                            : widget.ads.categoryId ==
                                                                    '8'
                                                                ? double.parse(
                                                                        '${widget.ads.price ?? "0.0"}') *
                                                                    (_counter)
                                                                : double.parse(
                                                                        '${widget.ads.price ?? "0.0"}') *
                                                                    (difference),
                                                        payment_type: '',
                                                      ),
                                                      context: context,
                                                    );
                                                }),
                                            if (widget.ads.categoryId != '9' &&
                                                widget.ads.categoryId != '7')
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Builder(
                                                        builder: (context) {
                                                          if (widget
                                                                  .ads.categoryId ==
                                                              '6')
                                                            return CustomText(
                                                                text: 'عدد التذاكر' +
                                                                    '    ${_counter}',
                                                                fontweight:
                                                                    FontWeight
                                                                        .bold,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom: 2
                                                                            .w),
                                                                fontSize:
                                                                    AppFonts
                                                                        .t4_2);
                                                          if (widget
                                                                  .ads.categoryId ==
                                                              '8')
                                                            return CustomText(
                                                                text: 'عدد الأيام' +
                                                                    '    ${widget.ads.count_days}',
                                                                fontweight:
                                                                    FontWeight
                                                                        .bold,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom: 2
                                                                            .w),
                                                                fontSize:
                                                                    AppFonts
                                                                        .t4_2);

                                                          return CustomText(
                                                              text: 'عدد الليالي' +
                                                                  '    ${difference}',
                                                              fontweight:
                                                                  FontWeight
                                                                      .bold,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          2.w),
                                                              fontSize: AppFonts
                                                                  .t4_2);
                                                        },
                                                      ),
                                                      CustomText(
                                                          fontweight:
                                                              FontWeight.bold,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2.w),
                                                          text:
                                                              '${widget.ads.price} ${widget.ads.currency}',
                                                          fontSize:
                                                              AppFonts.t4_2),
                                                      Builder(
                                                          builder: (context) {
                                                        if (widget.ads
                                                                .categoryId ==
                                                            '6')
                                                          return CustomText(
                                                            text:
                                                                'الإجمالي ${_counter * (double.parse('${widget.ads.price ?? "0.0"}'))} ${widget.ads.currency}',
                                                            fontweight:
                                                                FontWeight.bold,
                                                            padding:
                                                                EdgeInsets.only(
                                                              bottom: 2.w,
                                                            ),
                                                            fontSize:
                                                                AppFonts.t4_2,
                                                          );
                                                        if (widget.ads
                                                                .categoryId ==
                                                            '8')
                                                          return CustomText(
                                                            text:
                                                                'الإجمالي ${_counter * (double.parse('${widget.ads.price ?? "0.0"}'))} ${widget.ads.currency}',
                                                            fontweight:
                                                                FontWeight.bold,
                                                            padding:
                                                                EdgeInsets.only(
                                                              bottom: 2.w,
                                                            ),
                                                            fontSize:
                                                                AppFonts.t4_2,
                                                          );

                                                        return CustomText(
                                                          text:
                                                              'الإجمالي ${difference * (double.parse('${widget.ads.price ?? "0.0"}'))} ${widget.ads.currency}',
                                                          fontweight:
                                                              FontWeight.bold,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2.w),
                                                          fontSize:
                                                              AppFonts.t4_2,
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            if (widget.ads.categoryId == '7')
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      /* Builder(
                                                      builder: (context) {
                                                        return CustomText(
                                                          text: 'عدد الساعات' +
                                                              '    ${_counter}',
                                                          fontweight:
                                                              FontWeight.bold,
                                                          padding:
                                                              EdgeInsets.only(
                                                            bottom: 2.w,
                                                          ),
                                                          fontSize:
                                                              AppFonts.t4_2,
                                                        );
                                                      },
                                                    ), */
                                                      CustomText(
                                                          fontweight:
                                                              FontWeight.bold,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2.w),
                                                          text:
                                                              'سعر الساعة:  ${widget.ads.price} ${widget.ads.currency}',
                                                          fontSize:
                                                              AppFonts.t4_2),
                                                      /*  Builder(builder: (context) {
                                                      return CustomText(
                                                        text:
                                                            'الإجمالي ${_counter * (double.parse('${widget.ads.price ?? "0.0"}'))} ${widget.ads.currency}',
                                                        fontweight:
                                                            FontWeight.bold,
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: 2.w,
                                                        ),
                                                        fontSize: AppFonts.t4_2,
                                                      );
                                                    }), */
                                                    ],
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                ),
                              )
                            : Container(),
                Positioned(
                    top: 5.h,
                    left: 5.w,
                    right: 5.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context, isFav),
                          child: Container(
                            padding: EdgeInsets.all(1.5.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w),
                                color: AppColor.grayColor.withOpacity(.7)),
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColor.whiteColor,
                              size: 4.5.w,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () async {
                                  setState(() => isFav = !isFav);
                                  final res = await FavouriteController.postFav(
                                      '${widget.ads.id}');
                                  if (!res) setState(() => isFav = !isFav);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.5.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.w),
                                      color: isFav
                                          ? AppColor.whiteColor.withOpacity(.7)
                                          : AppColor.grayColor.withOpacity(.7)),
                                  child: isFav
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
                                )),
                            SizedBox(
                              height: 2.h,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(1.5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.w),
                                    color: AppColor.grayColor.withOpacity(.7)),
                                child: Image.asset(
                                  AppImages.shareIc,
                                  color: AppColor.whiteColor,
                                  width: 4.5.w,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget IconTextWidget({icon, text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon is Icon) icon,
        if (icon is String)
          Image.asset(
            icon,
            width: 5.w,
            height: 5.w,
          ),
        CustomText(
          padding: EdgeInsets.only(right: 1.5.w),
          text: text,
          fontSize: AppFonts.t4_2,
        )
      ],
    ),
  );
}

Widget RatingWidget(
    {bool isDetailScreen = false, countRate, username, description, date}) {
  return Container(
    margin: EdgeInsets.only(bottom: 3.w),
    padding: EdgeInsets.all(3.w),
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          offset: const Offset(0, 2.0),
          blurRadius: 6.0,
        ),
      ],
      borderRadius: BorderRadius.circular(2.w),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: username, fontSize: AppFonts.t2),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: isDetailScreen ? 1.0.w : 2.0.w),
              child: isDetailScreen
                  ? SizedBox()
                  : Row(
                      children: [
                        RatingBar.builder(
                          initialRating: countRate,
                          itemPadding: EdgeInsets.all(2),
                          allowHalfRating: true,
                          ignoreGestures: true,
                          minRating: 1,
                          itemSize: 4.w,
                          unratedColor: Colors.black,
                          itemBuilder: (context, _) => SvgPicture.asset(
                            'assets/svg/star.svg',
                            width: 4.w,
                            height: 4.w,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                        SizedBox(width: 8),
                        Builder(
                          builder: (context) {
                            if (countRate! < 2.0)
                              return CustomText(
                                  text: ' (تقييم منخفض)',
                                  fontSize: AppFonts.t4_2);
                            if (countRate < 4.0)
                              return CustomText(
                                  text: ' (تقييم متوسط)',
                                  fontSize: AppFonts.t4_2);
                            return CustomText(
                                text: '(تقييم عالي)', fontSize: AppFonts.t4_2);
                          },
                        ),
                      ],
                    ),
            ),
            CustomText(
              text: description,
              fontSize: AppFonts.t4_2,
              color: AppColor.grayColor,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              text: date,
              fontSize: AppFonts.t4_2,
              color: AppColor.grayColor,
            ),
            if (isDetailScreen == true)
              Row(
                children: [
                  IconTextWidget(
                    icon: AppImages.starIc,
                    text: '${countRate}',
                  ),
                  Builder(
                    builder: (context) {
                      if (countRate! < 2.0)
                        return CustomText(
                            text: ' (تقييم منخفض)', fontSize: AppFonts.t4_2);
                      if (countRate < 4.0)
                        return CustomText(
                            text: ' (تقييم متوسط)', fontSize: AppFonts.t4_2);
                      return CustomText(
                          text: '(تقييم عالي)', fontSize: AppFonts.t4_2);
                    },
                  ),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}
