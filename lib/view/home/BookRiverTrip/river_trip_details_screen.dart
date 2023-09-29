/* import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/customBtn.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/chat/chat_screen.dart';
import 'package:ejazah/view/home/BookRiverTrip/reservsion_river_trip_details.dart';
import 'package:ejazah/view/search_details/widgets/searchResultWidget.dart';
import 'package:ejazah/view/search_details/widgets/sliderWidget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RiverTripdetails_screen extends StatefulWidget {
  const RiverTripdetails_screen({super.key});

  @override
  State<RiverTripdetails_screen> createState() =>
      _RiverTripdetails_screenState();
}

class _RiverTripdetails_screenState extends State<RiverTripdetails_screen> {
  final GlobalKey<dynamic> _sliderKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                SliderWidget(imageList: [
                  AppImages.ReyadIc,
                  AppImages.slider1,
                  AppImages.ReyadIc,
                ], sliderKey: _sliderKey),
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
                            topRight: Radius.circular(9.w))),
                    child: Column(
                      children: [
                        TabBar(
                            padding: EdgeInsets.only(top: 2.w),
                            automaticIndicatorColorAdjustment: false,
                            indicatorColor: AppColor.orangeColor,
                            labelColor: AppColor.orangeColor,
                            labelStyle: TextStyle(
                                fontSize: AppFonts.t4_2,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w600,
                                color: AppColor.primaryColor),
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: "الموصفات",
                              ),
                              Tab(
                                text: "التقيمات",
                              ),
                              Tab(
                                text: "الخريطه",
                              ),
                              Tab(
                                text: "الشروط",
                              )
                            ]),
                        SizedBox(
                          height: 80.h,
                          width: 100.w,
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                ListView(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 30.h),
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.h),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.w),
                                                text: 'رحله من جده الي الرياض',
                                                fontSize: AppFonts.t2,
                                                fontweight: FontWeight.bold),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            CustomText(
                                                fontSize: AppFonts.t4_2,
                                                text:
                                                    'تاريخ الرحله : 5:40 مساء 20 مارس 2023'),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            CustomText(
                                                fontSize: AppFonts.t4_2,
                                                text:
                                                    'سعر الرحله : 432 ريال سعودي'),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                          ]),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.w),
                                                  text: 'عندك استفسار ؟',
                                                  fontSize: AppFonts.t2,
                                                  fontweight: FontWeight.bold),
                                            ],
                                          ),
                                          CustomButton(
                                              onPressed: () => myNavigate(
                                                  screen: ChatScreen(
                                                      img: null,
                                                      adsOwner: null,
                                                      token: null),
                                                  context: context),
                                              width: 30.w,
                                              height: 5.h,
                                              radius: 2.w,
                                              text: 'اسال المضيف',
                                              color: AppColor.whiteColor,
                                              textColor: AppColor.primaryColor)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    // CustomText(
                                    //     padding:
                                    //         EdgeInsets.symmetric(vertical: 2.w),
                                    //     text: 'اقتراحات مشابهه',
                                    //     fontSize: AppFonts.t2,
                                    //     fontweight: FontWeight.bold),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    SearchRiverResultWidget(
                                        onTap: () => myNavigate(
                                            screen: RiverTripdetails_screen(),
                                            context: context),
                                        priceDay:
                                            'تاريخ الرحله : 5:40 مساء 20 مارس 2023',
                                        title:
                                            'رحله بحريه في نهر النيل علي يخت فاخر',
                                        image: AppImages.ReyadIc,
                                        totalPrice: '400 رس ')
                                  ],
                                ),
                                ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    CustomText(
                                        padding: EdgeInsets.only(bottom: 4.w),
                                        text: 'وش قالو ضيوف المكان',
                                        fontweight: FontWeight.bold),
                                    ListView.builder(
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        itemCount: 6,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (ctx, index) {
                                          return RatingWidget(
                                              userName: 'احمد مبارك',
                                              countRate: 3,
                                              date: '25 OCT.2022',
                                              description:
                                                  'مكان نظيف وماسعاره مناسبه يستاهل التجربه');
                                        })
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 3.w),
                                        text:
                                            'الموقع التقريبي : جدة, حي الرويسي',
                                        fontSize: AppFonts.t3,
                                        fontweight: FontWeight.bold),
                                    Image.asset(
                                      AppImages.mapPg,
                                      width: 100.w,
                                      height: 70.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                                ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    CustomText(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 3.w),
                                        text: 'شروط الحجز',
                                        fontSize: AppFonts.t3,
                                        fontweight: FontWeight.bold),
                                    ListView.builder(
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        itemCount: 8,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, index) {
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
                                                      text:
                                                          'لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري' *
                                                              1),
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
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                          color: Color.fromARGB(255, 251, 251, 251),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      width: 80,
                      height: 11.h,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 20, bottom: 20),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              elevation: 3,
                              alignment: Alignment.center,
                              backgroundColor: Color.fromRGBO(83, 138, 153, 1)),
                          child: Text(
                            'اختر  (43543 ريال سعودي )',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            myNavigate(
                                screen: ReservationRevirTripdetails_screen(),
                                context: context);
                          },
                        ),
                      ),
                    )),
                Positioned(
                    top: 5.h,
                    left: 5.w,
                    right: 5.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
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
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(1.5.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.w),
                                      color:
                                          AppColor.grayColor.withOpacity(.7)),
                                  child: Image.asset(
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
        Image.asset(
          icon,
          width: 5.w,
          height: 5.w,
        ),
        CustomText(
            padding: EdgeInsets.only(right: 1.5.w),
            text: text,
            fontSize: AppFonts.t4_2)
      ],
    ),
  );
}

Widget RatingWidget({countRate, userName, description, date}) {
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
        borderRadius: BorderRadius.circular(2.w)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: userName, fontSize: AppFonts.t2),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.w),
              child: Row(
                children: [
                  SizedBox(
                    height: 4.h,
                    child: ListView.builder(
                        itemCount: countRate,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            AppImages.starIc,
                            width: 4.w,
                            height: 4.w,
                          );
                        }),
                  ),
                  CustomText(text: ' (تقييم متوسط) ', fontSize: AppFonts.t4_2)
                ],
              ),
            ),
            CustomText(
                text: description,
                fontSize: AppFonts.t4_2,
                color: AppColor.grayColor)
          ],
        ),
        CustomText(
            text: date, fontSize: AppFonts.t4_2, color: AppColor.grayColor)
      ],
    ),
  );
}
 */