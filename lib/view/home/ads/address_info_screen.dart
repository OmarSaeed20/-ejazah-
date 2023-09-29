import 'dart:developer';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:ejazah/view/home/ads/choose_your_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

class AddressInfoScreen extends StatefulWidget {
  const AddressInfoScreen({super.key});

  @override
  State<AddressInfoScreen> createState() => _AddressInfoScreenState();
}

class _AddressInfoScreenState extends State<AddressInfoScreen> {
  bool _value = false;
  bool _value2 = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: size.height * 0.025,
                bottom: size.height * 0.02,
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 130),
                      child: CustomAppBar(pageTitle: ''),
                    ),
                    SizedBox(
                      width: 22.w,
                    ),
                    SvgPicture.asset(
                      'assets/svg/Group 36770.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'من فضلك قم بإضافة بيانات العنوان',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppFonts.t3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.center,
                      width: size.width,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 252, 252),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 1.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: titleController,
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.text,
                        cursorHeight: 25,
                        cursorWidth: 2,
                        onChanged: (value) {
                          AddAdsController.title = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'عنوان الاعلان',
                            hintStyle: TextStyle(
                                color: Colors.black54, fontSize: AppFonts.t3),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.center,
                      width: size.width,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 252, 252),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 1.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: areaController,
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.number,
                        cursorHeight: 25,
                        cursorWidth: 2,
                        onChanged: (value) {
                          AddAdsController.area = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'مساحة السكن التقريبية (متر)',
                            hintStyle: TextStyle(
                                color: Colors.black54, fontSize: AppFonts.t3),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   child: CustomText(
                    //       text: 'برجاء كتابة وصف الاعلان',
                    //       fontSize: AppFonts.t3,
                    //       fontweight: FontWeight.w600),
                    // ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    customContainerTextFormField(
                      TFF: customTextFormField(
                        context: context,
                        maxLines: 3,
                        enableInteractiveSelection: true,
                        controller: descController,
                        hintText: 'يرجي كتابة وصف واضح',
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Is Required".tr),
                        ]),
                        onChanged: (value) {
                          AddAdsController.desc = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    if (AddAdsController.category_id == '5')
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              'التصنيف',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppFonts.t3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRadioButton(title: 'مخيمات', typeNum: '0'),
                              SizedBox(height: 2.h),
                              CustomRadioButton(title: 'شاليهات', typeNum: '1'),
                              SizedBox(height: 3.h),
                            ],
                          ),
                        ],
                      ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomCheckBox(
                                value: _value,
                                onChanged: (val) {
                                  _value = val;
                                  AddAdsController.families = val ? 1 : 0;
                                  log("---------> ${AddAdsController.families}");
                                  setState(() {});
                                }),
                            CustomText(
                                text: 'السكن متاح للعوائل',
                                color: Colors.black54,
                                fontSize: AppFonts.t3),
                          ],
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomCheckBox(
                                value: _value2,
                                onChanged: (val) {
                                  _value2 = val;
                                  AddAdsController.individual = val ? 1 : 0;
                                  log("---------> ${AddAdsController.individual}");

                                  setState(() {});
                                }),
                            CustomText(
                                text: 'السكن متاح للأفراد',
                                color: Colors.black54,
                                fontSize: AppFonts.t3),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: size.width,
                  height: 6.5.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor),
                      onPressed: () {
                        if (AddAdsController.isAddressInfoScreenValid())
                          myNavigate(
                              screen: ChooseYourAddressScreen(),
                              context: context);
                      },
                      child: Text(
                        'التالي',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppFonts.t2,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ])),
        ));
  }

  void initializeData() {
    titleController.text = AddAdsController.title;
    descController.text = AddAdsController.desc;
    areaController.text = AddAdsController.area;
    _value = AddAdsController.families == 1 ? true : false;
  }

  Widget customContainerTextFormField({
    required Widget TFF,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.center,
      width: context.getWidth,
      decoration: BoxDecoration(
        color: AppColor.backGroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 1.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: TFF,
    );
  }

  String typeValue = '0';
  bool value = false;

  CustomRadioButton({String title = '', String typeNum = ''}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.center,
      width: context.getWidth,
      decoration: BoxDecoration(
        color: AppColor.backGroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 1.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (typeNum == '0') {
            AddAdsController.camp = 1;
            AddAdsController.chalets = 0;
          } else if (typeNum == '1') {
            AddAdsController.camp = 0;
            AddAdsController.chalets = 1;
          }
          setState(() {
            typeValue = typeNum;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppFonts.t3,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Radio(
                value: typeNum,
                groupValue: typeValue,
                onChanged: (val) {
                  if (typeNum == '0') {
                    AddAdsController.camp = 1;
                    AddAdsController.chalets = 0;
                  } else if (typeNum == '1') {
                    AddAdsController.camp = 0;
                    AddAdsController.chalets = 1;
                  }
                  setState(() {
                    typeValue = typeNum;
                  });
                  setState(() {});
                },
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.green),
                focusColor:
                    MaterialStateColor.resolveWith((states) => Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
