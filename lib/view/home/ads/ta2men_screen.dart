import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:ejazah/view/home/ads/add_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Ta2meenScreen extends StatefulWidget {
  const Ta2meenScreen({super.key});

  @override
  State<Ta2meenScreen> createState() => _Ta2meenScreenState();
}

class _Ta2meenScreenState extends State<Ta2meenScreen> {
  bool isCheck = AddAdsController.insurance == 1 ? true : false;
  TextEditingController priceController =
      TextEditingController(text: AddAdsController.price);
  TextEditingController insurance_value =
      TextEditingController(text: AddAdsController.price);
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
                        controller: priceController,
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.phone,
                        cursorHeight: 25,
                        cursorWidth: 2,
                        onChanged: (value) {
                          AddAdsController.price = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'سعر الليلة',
                            hintStyle: TextStyle(
                                color: Colors.black54, fontSize: AppFonts.t3),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isCheck,
                          onChanged: (value) {
                            AddAdsController.insurance = value! ? 1 : 0;
                            setState(() {
                              isCheck = value;
                            });
                          },
                        ),
                        Text('يوجد تأمين')
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    if (isCheck)
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
                          controller: insurance_value,
                          enableInteractiveSelection: true,
                          keyboardType: TextInputType.phone,
                          cursorHeight: 25,
                          cursorWidth: 2,
                          onChanged: (value) {
                            AddAdsController.insurance_value = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'قيمة التأمين',
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: AppFonts.t3),
                              border: InputBorder.none),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                    width: size.width,
                    height: 7.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.buttonColor),
                        onPressed: () {
                          if (AddAdsController.isTa2menScreenValid()) {
                            myNavigate(
                                screen: AddImagesScreen(), context: context);
                          }
                        },
                        child: CustomText(
                            text: 'التـالي',
                            fontSize: AppFonts.t2,
                            color: Colors.white,
                            fontweight: FontWeight.bold)))
              ])),
        ));
  }
}
