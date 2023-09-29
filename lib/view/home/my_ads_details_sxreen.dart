/* import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/view/search_details/widgets/sliderWidget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyAdsdetails_screen extends StatefulWidget {
  const MyAdsdetails_screen({super.key});

  @override
  State<MyAdsdetails_screen> createState() => _MyAdsdetails_screenState();
}

class _MyAdsdetails_screenState extends State<MyAdsdetails_screen> {
  final GlobalKey<dynamic> _sliderKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                SliderWidget(imageList: [
                  'https://e0.pxfuel.com/wallpapers/12/377/desktop-wallpaper-beautiful-houses-beautiful-mansion.jpg',
                  'https://e0.pxfuel.com/wallpapers/12/377/desktop-wallpaper-beautiful-houses-beautiful-mansion.jpg'
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
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomText(
                            text: 'المواصفات',
                            color: AppColor.orangeColor,
                            fontSize: AppFonts.t1),
                        SizedBox(
                          height: 80.h,
                          width: 100.w,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 30.h),
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.w, horizontal: 3.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.w),
                                    color: AppColor.greenSecondColor
                                        .withOpacity(.1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                          color: AppColor.greenColor,
                                          maxLines: 3,
                                          text:
                                              'يوجد مبلغ تأمين علي السكن ويتم دفعه مره واحدة عند بدايه  الحجز وتستلمه  في حاله الرحيل اذا لم يكن هناك اضرار'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconTextWidget(
                                            icon: AppImages.starIc,
                                            text: '9.6(12تقييم)'),
                                        IconTextWidget(
                                            icon: AppImages.locationIc,
                                            text: 'مساحة الوحده 100 متر'),
                                        IconTextWidget(
                                            icon: AppImages.animalIc,
                                            text: '9.6(12تقييم)'),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconTextWidget(
                                            icon: AppImages.locationIc,
                                            text: 'جده حي الرويس'),
                                        IconTextWidget(
                                            icon: AppImages.peopleIc,
                                            text: 'مخصص للعوائل وعزاب'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                color:
                                    AppColor.greenSecondColor.withOpacity(.1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: 'المرافق',
                                        fontSize: AppFonts.t2,
                                        fontweight: FontWeight.bold),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 3,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (ctx, index) {
                                          return CustomText(
                                              padding:
                                                  EdgeInsets.only(top: 2.w),
                                              text:
                                                  'مجلس رئيسي يسع 4 افراد $index',
                                              fontSize: AppFonts.t3);
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Card(
                                  elevation: 2,
                                  margin: EdgeInsets.all(8),
                                  child: Container(
                                    width: size.width,
                                    padding: EdgeInsets.all(18),
                                    color: Colors.white70,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'تفاصيل الحجز',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'تاريخ الدخول',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '2/3/2023',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'تاريخ المغادرة',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '2/3/2023',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'سعر الليله الواحده',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '434 ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'القيمة المضافة',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'رسوم 434 ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'السعر الكلي',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      68, 151, 173, 1)),
                                            ),
                                            Text(
                                              '434 ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      68, 151, 173, 1)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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