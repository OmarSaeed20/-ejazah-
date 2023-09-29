import 'package:custom_check_box/custom_check_box.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/home/ads/add_morafeq_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/add_service_controller/accept_pets_controller.dart';

class AcceptPetsScreen extends StatefulWidget {
  const AcceptPetsScreen({super.key});

  @override
  State<AcceptPetsScreen> createState() => _AcceptPetsScreenState();
}

class _AcceptPetsScreenState extends State<AcceptPetsScreen> {
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
                /*  if (AddAdsController.category_id == '5')
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
                  ), */
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'الأشتراطات الخاصة',
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
                    customSecondContainer(0, 'يسمح بأصطحاب الحيوانات الأليفه'),
                    customSecondContainer(1, 'يسمح بالزيارات'),
                    customSecondContainer(2, 'يسمح بالتدخين'),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                    width: size.width,
                    height: 7.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.grey,
                            backgroundColor: AppColor.buttonColor),
                        onPressed: () {
                          myNavigate(
                              screen: AddMorafeqScreen(), context: context);
                        },
                        child: CustomText(
                            text: 'التـالي',
                            fontSize: AppFonts.t2,
                            color: Colors.white,
                            fontweight: FontWeight.bold)))
              ])),
        ));
  }

  Widget customSecondContainer(int index, String text) {
    final _value = AcceptPetsController.listCheck[index];
    return Row(
      children: [
        CustomCheckBox(
            value: _value,
            shouldShowBorder: true,
            borderColor: Colors.green,
            checkedFillColor: Colors.green,
            borderRadius: 5,
            borderWidth: 1,
            checkBoxSize: 17,
            onChanged: (val) {
              AcceptPetsController.change2ListCheck(index);
              setState(() {});
            }),
        CustomText(text: text)
      ],
    );
  }
}
