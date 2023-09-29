import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/home/success_reservation.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddedCondetionsScreen extends StatefulWidget {
  const AddedCondetionsScreen({super.key});

  @override
  State<AddedCondetionsScreen> createState() => _AddedCondetionsScreenState();
}

class _AddedCondetionsScreenState extends State<AddedCondetionsScreen> {
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
                    'من فضلك قم بإضافة الشروط والاحكام',
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.center,
                      width: size.width,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.name,
                        cursorHeight: 30,
                        cursorWidth: 2,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            hintText: 'اكتب هنا الشروط',
                            hintStyle: TextStyle(
                                color: Colors.black54, fontSize: AppFonts.t3),
                            border: InputBorder.none),
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    height: 13.h,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(0, 2.0),
                            blurRadius: 2.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: ExpandableText(
                      'لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري',
                      expandText: '',
                      style: TextStyle(fontSize: AppFonts.t3),
                    ),
                  )
                ]),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.orangeColor)),
                  child: TextButton(
                      onPressed: () {},
                      child: CustomText(
                          text: 'إضافة شرط اخر',
                          color: AppColor.orangeColor,
                          fontSize: AppFonts.t2)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: size.width,
                  height: 7.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor),
                      onPressed: () {
                        myNavigate(
                            screen: SuccessReservationScreen(
                              ads_id: '',
                            ),
                            context: context);
                      },
                      child: Text(
                        'إضافة الاعلان',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppFonts.t2,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ])),
        ));
  }
}
