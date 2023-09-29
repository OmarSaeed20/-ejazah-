/* // ignore_for_file: deprecated_member_use

import 'package:ejazah/Widgets/Custom_TextField.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/home/BookRiverTrip/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/customAppBar.dart';

class SearchResultRiverTripScreen extends StatefulWidget {
  const SearchResultRiverTripScreen({super.key});

  @override
  State<SearchResultRiverTripScreen> createState() =>
      _SearchResultRiverTripScreenState();
}

class _SearchResultRiverTripScreenState
    extends State<SearchResultRiverTripScreen> {
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.only(top: 5.h, left: 3.w, right: 3.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomAppBar(
                  pageTitle: 'الرحلات البحرية',
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextFormField(
                      width: 80.w,
                      hintText: 'بحث',
                      prefixIcon: SvgPicture.asset(
                        'assets/svg/search-normal.svg',
                        fit: BoxFit.fitWidth,
                        color: Color.fromRGBO(234, 146, 78, 1),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        myNavigate(screen: FilterScreen(), context: context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: SvgPicture.asset(
                          AppSvgImages.filterIc,
                          color: AppColor.orangeColor,
                          width: 6.w,
                          height: 6.w,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // myNavigate(
                        //     screen: RiverTripdetails_screen(), context: context);
                      },
                      child: Stack(
                        children: [
                          Image(
                              image: AssetImage(
                                  'assets/images/under_maintenance.jpg'),
                              height: 80.h,
                              fit: BoxFit.fill),
                          ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount: 8,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return CustomListWidget(
                                  dataTime: '5:40 مساء 20 مارس 2023',
                                  title: 'رحله بحريه في نهر النيل علي يخت فاخر',
                                  image: AppImages.ReyadIc,
                                  price: '400 ريال سعودي');
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              height: 2.h,
                            ),
                          ),
                          // Positioned(
                          //     bottom: 2.h,
                          //     left: 30.w,
                          //     right: 30.w,
                          //     child: InkWell(
                          //       onTap: () {
                          //         showModalBottomSheet(
                          //             context: context,
                          //             shape: const RoundedRectangleBorder(
                          //               // <-- SEE HERE
                          //               borderRadius: BorderRadius.vertical(
                          //                 top: Radius.circular(25.0),
                          //               ),
                          //             ),
                          //             builder: (context) {
                          //               return Container(
                          //                 padding: EdgeInsets.symmetric(
                          //                     horizontal: 3.w, vertical: 4.w),
                          //                 height: 42.h,
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: <Widget>[
                          //                     CustomText(
                          //                         padding: EdgeInsets.symmetric(
                          //                             vertical: 2.w),
                          //                         text: 'الترتيب علي حسب',
                          //                         fontweight: FontWeight.bold),
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       children: [
                          //                         CustomText(
                          //                             text: 'الافتراضي',
                          //                             fontSize: AppFonts.t4_2),
                          //                         Checkbox(
                          //                             value: ischecked,
                          //                             activeColor:
                          //                                 AppColor.orangeColor,
                          //                             onChanged: (value) {
                          //                               setState(() {
                          //                                 ischecked != ischecked;
                          //                               });
                          //                             })
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       children: [
                          //                         CustomText(
                          //                             text: 'الأقل سعرا',
                          //                             fontSize: AppFonts.t4_2),
                          //                         Checkbox(
                          //                             value: ischecked,
                          //                             activeColor:
                          //                                 AppColor.orangeColor,
                          //                             onChanged: (value) {
                          //                               setState(() {
                          //                                 ischecked != ischecked;
                          //                               });
                          //                             })
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                       children: [
                          //                         CustomText(
                          //                             text: 'الاعلي سعرا',
                          //                             fontSize: AppFonts.t4_2),
                          //                         Checkbox(
                          //                             value: ischecked,
                          //                             activeColor:
                          //                                 AppColor.orangeColor,
                          //                             onChanged: (value) {
                          //                               setState(() {
                          //                                 ischecked != ischecked;
                          //                               });
                          //                             })
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       children: [
                          //                         CustomText(
                          //                             text: 'الاحدث',
                          //                             fontSize: AppFonts.t4_2),
                          //                         Checkbox(
                          //                             value: ischecked,
                          //                             activeColor:
                          //                                 AppColor.orangeColor,
                          //                             onChanged: (value) {
                          //                               setState(() {
                          //                                 ischecked != ischecked;
                          //                               });
                          //                             })
                          //                       ],
                          //                     ),
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       children: [
                          //                         CustomButton(
                          //                             width: 45.w,
                          //                             height: 6.h,
                          //                             radius: 1.w,
                          //                             color: AppColor
                          //                                 .primaryOpacityColor,
                          //                             text: 'تطبيق',
                          //                             onPressed: () =>
                          //                                 Navigator.pop(context)),
                          //                         CustomButton(
                          //                             radius: 1.w,
                          //                             height: 6.h,
                          //                             width: 45.w,
                          //                             color: AppColor.whiteColor,
                          //                             textColor:
                          //                                 AppColor.blackColor,
                          //                             text: 'مسح',
                          //                             onPressed: () =>
                          //                                 Navigator.pop(context)),
                          //                       ],
                          //                     )
                          //                   ],
                          //                 ),
                          //               );
                          //             });
                          //       },
                          //       child: Container(
                          //         alignment: Alignment.center,
                          //         padding: EdgeInsets.all(2.w),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(1.w),
                          //           color: AppColor.orangeColor,
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             SvgPicture.asset(
                          //               'assets/svg/arrow-3-linear.svg',
                          //               color: Colors.white,
                          //               width: 4.w,
                          //               height: 4.w,
                          //             ),
                          //             CustomText(
                          //                 padding: EdgeInsets.symmetric(
                          //                     horizontal: 2.w),
                          //                 text: "ترتيب",
                          //                 overflow: TextOverflow.ellipsis,
                          //                 color: AppColor.whiteColor,
                          //                 fontSize: AppFonts.t2),
                          //           ],
                          //         ),
                          //       ),
                          //     ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

Widget CustomListWidget({image, title, dataTime, price}) {
  return Container(
    margin: EdgeInsets.only(bottom: 2.w),
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
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.w), topRight: Radius.circular(2.w)),
        child: Image.asset(
          image,
          width: 100.w,
          height: 13.h,
          fit: BoxFit.fill,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                text: title,
                fontweight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
            CustomText(
                text: "تاريخ الرحله : " + dataTime,
                overflow: TextOverflow.ellipsis,
                fontSize: AppFonts.t4_2),
            CustomText(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                text: "سعر الرحله : " + price,
                overflow: TextOverflow.ellipsis,
                fontSize: AppFonts.t4_2),
          ],
        ),
      ),
    ]),
  );
}
 */