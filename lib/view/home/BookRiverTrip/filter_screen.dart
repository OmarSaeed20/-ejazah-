/* // ignore_for_file: deprecated_member_use

import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/customBtn.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../widgets/customAppBar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool ischecked = false;
  SfRangeValues _values = SfRangeValues(100.0, 9900.0);
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
           padding: EdgeInsets.only(
                top: size.height * 0.1,
                bottom: size.height * 0.05,
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
          child: Stack(children: [
            Container(
                margin: EdgeInsets.only(top: 5.h, left: 3.w, right: 3.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomAppBar(
                      pageTitle: 'التصفية',
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                          padding: EdgeInsets.symmetric(vertical: 2.w),
                          text: 'تحديد الوجهه مدينه معينه',
                          fontweight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                          right: 20,
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                            color: Color.fromARGB(255, 245, 245, 245),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          // controller: searchController,
                          enableInteractiveSelection: true,
                          cursorHeight: 25,
                          cursorWidth: 2,
                          onChanged: (value) {},
      
                          decoration: InputDecoration(
                            hintText: 'من',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            width: 12.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              AppImages.swapIc,
                              width: 7.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                          right: 20,
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                            color: Color.fromARGB(255, 245, 245, 245),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          // controller: searchController,
                          enableInteractiveSelection: true,
                          cursorHeight: 25,
                          cursorWidth: 2,
                          onChanged: (value) {},
      
                          decoration: InputDecoration(
                            hintText: 'إلى',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1.5,
                      height: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                          text: 'تصفية النتائج بالسعر',
                          fontweight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SfRangeSlider(
                        min: 100.0,
                        max: 10000.0,
                        values: _values,
                        showLabels: true,
                        interval: 9900,
                        activeColor: AppColor.orangeColor,
                        labelFormatterCallback:
                            (dynamic actualValue, String formattedText) {
                          return actualValue == 10000
                              ? '4000 ريال / ليله'
                              : '50 ريال/ ليله';
                        },
                        onChanged: (SfRangeValues newValues) {
                          setState(() {
                            _values = newValues;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                          text: 'حدد تاريخ معين', fontweight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      child: Theme(
                        data: ThemeData(
                          colorScheme:  ColorScheme.light(
                              primary: Color(0xff666769)),
                        ),
                        child: DatePickerDialog(
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 10.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              width: 45.w,
                              height: 6.h,
                              radius: 1.w,
                              color: AppColor.primaryOpacityColor,
                              text: 'تطبيق',
                              onPressed: () => Navigator.pop(context)),
                          CustomButton(
                              radius: 1.w,
                              height: 6.h,
                              width: 45.w,
                              color: AppColor.whiteColor,
                              textColor: AppColor.blackColor,
                              text: 'مسح',
                              onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                    )
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
 */