// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:ejazah/Widgets/Custom_TextField.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/controller/add_information_tavel_groups_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../model/event_type_model.dart';
import '../../../model/travel_type_model.dart';
import '../../../utils/enums.dart';
import 'add_condetions_screen.dart';

class AddInfoTravelGroupScreen extends StatefulWidget {
  AddInfoTravelGroupScreen({super.key});

  @override
  State<AddInfoTravelGroupScreen> createState() =>
      _AddInfoTravelGroupScreenState();
}

class _AddInfoTravelGroupScreenState extends State<AddInfoTravelGroupScreen> {
  bool ticketIncluded = false,
      go = false,
      back = false,
      main_meal = false,
      housing_included = false,
      Tour_guide_included = false,
      breakfast = false,
      lunch = false,
      dinner = false;

  final TextEditingController fromController = TextEditingController(),
      toController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  late DateTime to;
  late DateTime from;
  int difference = 0;
  TextEditingController iBANController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController passengersController = TextEditingController();
  TextEditingController differenceController = TextEditingController();
  EventTypeModel? eventTypeModel;
  TravelTypeModel? travelTypeModel;

  List<XFile> images = [];

  RequestState requestState = RequestState.waiting;

  List<XFile> addImages = [];

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
                CustomAppBar(pageTitle: ''),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'من فضلك قم بإضافة بيانات صحيحة',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppFonts.t3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            images = await picker.pickMultiImage();
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(25),
                            width: 25.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: AppColor.orangeColor),
                            ),
                            child: SvgPicture.asset(
                              AppSvgImages.takePice,
                              width: 5.h,
                              height: 5.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(top: 22),
                          child: CustomText(
                            text:
                                'يمكنك إضافة صور بحد أقصي 4 صورة في الإعلان الواحد',
                            maxLines: 2,
                            fontSize: AppFonts.t3,
                          ),
                        ))
                      ],
                    ),
                    if (images != null && images.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: size.width - 100,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final file = images[index];
                                  return Stack(
                                    alignment: AlignmentDirectional.topStart,
                                    children: [
                                      Image.file(
                                        File(file.path),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        width: 4.0.h,
                                        height: 4.0.h,
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade800,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            CupertinoIcons.delete_solid,
                                            color: AppColor.whiteColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              images.removeAt(index);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.w)),
                                itemCount: images.length,
                                shrinkWrap: true,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                addImages = await picker.pickMultiImage();
                                images.addAll(addImages);
                                addImages.clear();
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.add_circle_outlined,
                                color: AppColor.orangeColor,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                          text: 'برجاء إدخال عدد الايام',
                          fontSize: AppFonts.t3,
                          fontweight: FontWeight.w600),
                    ),
                    SizedBox(height: 1.0.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      alignment: Alignment.center,
                      width: context.getWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 1.0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: customTextFormField(
                        context: context,
                        controller: differenceController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Is Required".tr),
                        ]),
                        hintText: 'عدد الايام',
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        height: 6.h,
                        child: TextFormField(
                          controller: fromController,
                          readOnly: true,
                          validator: (value) =>
                              value!.isEmpty ? 'Is Required' : null,
                          decoration: InputDecoration(
                            prefixText: ' ',
                            hintText: 'من',
                            prefixIcon: Icon(Icons.calendar_today_rounded),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100),
                            );
                            if (date == null) {
                              fromController.clear();
                              return;
                            }
                            from = date;
                            // String birthday = DateFormat.yMd().format(date);
                            String dateTime = date.year.toString() +
                                '-' +
                                date.month.toString() +
                                '-' +
                                date.day.toString();
                            print(dateTime);
                            difference = from.difference(from).inDays;
                            setState(() {});

                            fromController.text = dateTime;
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 6.h,
                      child: TextFormField(
                        controller: toController,
                        readOnly: true,
                        validator: (value) =>
                            value!.isEmpty ? 'Is Required' : null,
                        decoration: InputDecoration(
                          prefixText: ' ',
                          hintText: 'إلى',
                          prefixIcon: Icon(Icons.calendar_today_rounded),
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );
                          if (date == null) {
                            toController.clear();
                            return;
                          }
                          to = date;
                          difference = to.difference(from).inDays;
                          setState(() {});
                          // String birthday = DateFormat.yMd().format(date);
                          String dateTime = date.year.toString() +
                              '-' +
                              date.month.toString() +
                              '-' +
                              date.day.toString();
                          print(dateTime);
                          toController.text = dateTime;
                        },
                      ),
                    ),
                   */
                  ],
                ),
                /* SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 6.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(2.h)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(1.h),
                  child: CustomText(
                      text: 'عدد الايام    :    ${difference.toString()}',
                      fontSize: AppFonts.t3,
                      fontweight: FontWeight.w500),
                ),
                 */
                SizedBox(
                  height: 4.h,
                ),
                Container(
                    width: size.width,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomCheckBox(
                                value: main_meal,
                                shouldShowBorder: false,
                                borderRadius: 2,
                                checkBoxSize: 14,
                                onChanged: (val) {
                                  setState(() {
                                    main_meal = val;
                                    if (!main_meal) {
                                      dinner = false;
                                      lunch = false;
                                      breakfast = false;
                                    }
                                    print(main_meal);
                                  });
                                }),
                            Text(
                              'وجبة رئيسية',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            if (main_meal)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomCheckBox(
                                      value: breakfast,
                                      shouldShowBorder: false,
                                      borderRadius: 2,
                                      checkBoxSize: 14,
                                      onChanged: (val) {
                                        setState(() {
                                          breakfast = val;
                                        });
                                      }),
                                  Text(
                                    'فطار',
                                    style: TextStyle(
                                        fontSize: AppFonts.t4_2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CustomCheckBox(
                                      value: dinner,
                                      shouldShowBorder: false,
                                      borderRadius: 2,
                                      checkBoxSize: 14,
                                      onChanged: (val) {
                                        setState(() {
                                          dinner = val;
                                        });
                                      }),
                                  Text(
                                    'غداء',
                                    style: TextStyle(
                                        fontSize: AppFonts.t4_2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CustomCheckBox(
                                      value: lunch,
                                      shouldShowBorder: false,
                                      borderRadius: 2,
                                      checkBoxSize: 14,
                                      onChanged: (val) {
                                        setState(() {
                                          lunch = val;
                                        });
                                      }),
                                  Text(
                                    'عشاء',
                                    style: TextStyle(
                                        fontSize: AppFonts.t4_2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            Spacer(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomCheckBox(
                                value: housing_included,
                                shouldShowBorder: false,
                                borderRadius: 2,
                                checkBoxSize: 14,
                                onChanged: (val) {
                                  setState(() {
                                    housing_included = val;
                                  });
                                }),
                            Text(
                              'شامل سكن',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomCheckBox(
                                value: Tour_guide_included,
                                shouldShowBorder: false,
                                borderRadius: 2,
                                checkBoxSize: 14,
                                onChanged: (val) {
                                  setState(() {
                                    Tour_guide_included = val;
                                  });
                                }),
                            Text(
                              'شامل مرشد سياحي',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomCheckBox(
                                value: ticketIncluded,
                                shouldShowBorder: false,
                                borderRadius: 2,
                                checkBoxSize: 14,
                                onChanged: (val) {
                                  setState(() {
                                    ticketIncluded = val;
                                    if (!ticketIncluded) {
                                      go = false;
                                      back = false;
                                    }
                                  });
                                }),
                            Text(
                              'شامل تذاكر طيران',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            if (ticketIncluded)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomCheckBox(
                                      value: go,
                                      shouldShowBorder: false,
                                      borderRadius: 2,
                                      checkBoxSize: 14,
                                      onChanged: (val) {
                                        setState(() {
                                          go = val;
                                        });
                                      }),
                                  Text(
                                    'ذهاب',
                                    style: TextStyle(
                                        fontSize: AppFonts.t4_2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CustomCheckBox(
                                      value: back,
                                      shouldShowBorder: false,
                                      borderRadius: 2,
                                      checkBoxSize: 14,
                                      onChanged: (val) {
                                        setState(() {
                                          back = val;
                                        });
                                      }),
                                  Text(
                                    'عودة',
                                    style: TextStyle(
                                        fontSize: AppFonts.t4_2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            Spacer(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                      text: 'رقم الايبان',
                      fontSize: AppFonts.t3,
                      fontweight: FontWeight.w600),
                ),
                SizedBox(
                  height: 2.h,
                ),
                customContainerTextFormField(
                  TFF: customTextFormField(
                    context: context,
                    controller: iBANController,
                    hintText: 'إضافة رقم الايبان',
                    keyboardType: TextInputType.text,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Is Required".tr),
                    ]),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                      text: 'برجاء كتابة وصف الاعلان',
                      fontSize: AppFonts.t3,
                      fontweight: FontWeight.w600),
                ),
                SizedBox(
                  height: 1.h,
                ),
                customContainerTextFormField(
                  TFF: customTextFormField(
                    context: context,
                    maxLines: 3,
                    controller: descController,
                    hintText: 'يرجي كتابة وصف واضح',
                    keyboardType: TextInputType.text,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Is Required".tr),
                    ]),
                    onChanged: (value) {},
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'برجاء تحديد السعر',
                            fontweight: FontWeight.w600,
                            fontSize: AppFonts.t3,
                          ),
                          CustomTextFormField(
                              controller: priceController,
                              contentPadding:
                                  EdgeInsets.only(right: 15, top: 5),
                              onChangedFun: () {},
                              hintText: '1000 ',
                              width: 50.w,
                              radius: 2.w,
                              keyBoardType: TextInputType.phone)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'برجاء تحديد عدد الاشخاص',
                            fontweight: FontWeight.w600,
                            fontSize: AppFonts.t3,
                          ),
                          CustomTextFormField(
                            controller: passengersController,
                            contentPadding: EdgeInsets.only(right: 50, top: 5),
                            onChangedFun: () {},
                            hintText: '2',
                            width: 50.w,
                            radius: 2.w,
                            keyBoardType: TextInputType.phone,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: size.width,
                  height: 7.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor),
                      onPressed: () {
                        if (differenceController.text.length < 1) {
                          toastShow(
                              text: 'برجاء ادخال تاريخ الحجز بطريقة صحيحة');
                          return;
                        }
                        if (images == null || images.isEmpty) {
                          toastShow(text: 'يرجى إضافة صورة واحدة على الأقل');
                          return;
                        }

                        try {
                          if (int.parse(priceController.text) < 0 ||
                              int.parse(priceController.text) > 999999) {
                            toastShow(text: 'تأكد من سعر الفعالية');
                            return;
                          }
                        } catch (e) {
                          toastShow(text: 'تأكد من سعر الفعالية');
                          return;
                        }
                        try {
                          if (int.parse(passengersController.text) < 1 ||
                              int.parse(passengersController.text) > 999999) {
                            toastShow(text: 'تأكد من عدد الركاب');
                            return;
                          }
                        } catch (e) {
                          toastShow(text: 'تأكد من عدد الركاب');
                          return;
                        }
                        if (iBANController.text.length < 7) {
                          toastShow(text: 'تأكد من رقم الايبان');
                          return;
                        }
                        if (descController.text.length < 10) {
                          toastShow(
                              text: 'وصف واضح يتكون من 10 أحرف على الأقل');
                          return;
                        }
                        if (main_meal && !breakfast && !dinner && !lunch) {
                          toastShow(text: 'برجاء إختيار وجبة واحدة على الأقل');
                          return;
                        }

                        AddInformationTravelGroupsController.images = images;
                        AddInformationTravelGroupsController.from = "0";
                        AddInformationTravelGroupsController.to = "0";
                        AddInformationTravelGroupsController.iban =
                            iBANController.text;
                        AddInformationTravelGroupsController.desc =
                            descController.text;
                        AddInformationTravelGroupsController.price =
                            priceController.text;
                        AddInformationTravelGroupsController.passengers =
                            passengersController.text;
                        AddInformationTravelGroupsController.back =
                            back ? 1 : 0;
                        AddInformationTravelGroupsController.go = go ? 1 : 0;
                        AddInformationTravelGroupsController.main_meal =
                            main_meal ? 1 : 0;
                        AddInformationTravelGroupsController.housing_included =
                            housing_included ? 1 : 0;
                        AddInformationTravelGroupsController
                            .Tour_guide_included = Tour_guide_included ? 1 : 0;
                        AddInformationTravelGroupsController.breakfast =
                            breakfast ? 1 : 0;
                        AddInformationTravelGroupsController.lunch =
                            lunch ? 1 : 0;
                        AddInformationTravelGroupsController.dinner =
                            dinner ? 1 : 0;
                        AddInformationTravelGroupsController.count_days =
                            differenceController.text.toString();

                        myNavigate(
                          screen: AddCondetionsScreen(isAddTravel: true),
                          context: context,
                        );

                        // myNavigate(
                        //     screen: ChooseHomeTypeScreen(), context: context);
                        // myNavigate(screen: AcceptPetsScreen(), context: context);
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

  Widget customContainerTextFormField({
    required Widget TFF,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
}
