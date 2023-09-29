/* import 'package:custom_check_box/custom_check_box.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/home/ads/accept_pets_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChooseHomeTypeScreen extends StatefulWidget {
  const ChooseHomeTypeScreen({super.key});

  @override
  State<ChooseHomeTypeScreen> createState() => _ChooseHomeTypeScreenState();
}

class _ChooseHomeTypeScreenState extends State<ChooseHomeTypeScreen> {
  bool private_house = true, Shared_accommodation = false;
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
                    'اختر نوع السكن',
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
                        padding: EdgeInsets.all(8),
                        height: 7.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(0, 1.0),
                              blurRadius: 4.0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'سكن خاص',
                              style: TextStyle(
                                  fontSize: AppFonts.t3,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                            CustomCheckBox(
                                value: private_house,
                                shouldShowBorder: true,
                                borderColor: Colors.green,
                                checkedFillColor: Colors.green,
                                borderRadius: 5,
                                borderWidth: 1,
                                checkBoxSize: 17,
                                onChanged: (val) {
                                  Shared_accommodation = !val;
                                  private_house = val;
                                  setState(() {});
                                }),
                          ],
                        )),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        height: 7.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(0, 1.0),
                              blurRadius: 4.0,
                            )
                          ],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'سكن مشترك',
                                style: TextStyle(
                                    fontSize: AppFonts.t3,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                              CustomCheckBox(
                                  value: Shared_accommodation,
                                  shouldShowBorder: true,
                                  borderColor: Colors.green,
                                  checkedFillColor: Colors.green,
                                  borderRadius: 5,
                                  borderWidth: 1,
                                  checkBoxSize: 17,
                                  onChanged: (val) {
                                    private_house = !val;
                                    Shared_accommodation = val;
                                    setState(() {});
                                  }),
                            ]))
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                    width: size.width,
                    height: 7.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.buttonColor),
                        onPressed: () {
                          myNavigate(
                              screen: AcceptPetsScreen(), context: context);
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
 */