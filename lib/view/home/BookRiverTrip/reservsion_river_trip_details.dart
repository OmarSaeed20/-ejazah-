import 'package:custom_check_box/custom_check_box.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/home/success_reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ReservationRevirTripdetails_screen extends StatefulWidget {
  const ReservationRevirTripdetails_screen({super.key});

  @override
  State<ReservationRevirTripdetails_screen> createState() =>
      _ReservationRevirTripdetails_screenState();
}

class _ReservationRevirTripdetails_screenState
    extends State<ReservationRevirTripdetails_screen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool _value = false;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: size.height * 0.1,
              bottom: size.height * 0.15,
              left: size.height * 0.02,
              right: size.height * 0.02,
            ),
            child: Center(
                heightFactor: 1,
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/svg/white_backarrow.svg',
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'المراجعه و البحث',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppFonts.t3,
                        ),
                      )
                    ],
                  ),
                  Card(
                      elevation: 3,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.white70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'تفاصيل الحجز',
                                style: TextStyle(
                                  fontSize: AppFonts.t2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'رحله بحريه في نهر النيل علي يخت فاخر',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              'تاريخ الرحله : 5:40 مساء 20 مارس 2023',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              'سعر الرحله : 432 ريال سعودي',
                              style: TextStyle(
                                  fontSize: AppFonts.t4_2,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      elevation: 3,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'تكلفه الرحله',
                                style: TextStyle(
                                    fontSize: AppFonts.t4_2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'سعر الرحلة',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '434 ريال سعودي',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'القيمة المضافة',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'رسوم 434 ريال سعودي',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'السعر الكلي',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.transparent),
                                ),
                                Text(
                                  '434 ريال سعودي',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.transparent),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Divider(
                    thickness: 0.3,
                    height: 2,
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: 240,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(210, 211, 212, 0.392)),
                          child: Text(
                            'لديك كود خصم ؟',
                            style: TextStyle(
                              fontSize: AppFonts.t5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                            width: 100,
                            height: 47,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.transparent)),
                            child: TextButton(
                                onPressed: () {}, child: Text('تفعيل'))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Divider(
                    thickness: 0.3,
                    height: 2,
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Card(
                      elevation: 3,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'شروط الحجز',
                                style: TextStyle(
                                    fontSize: AppFonts.t4_2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 30),
                                  width: 50,
                                  height: 70,
                                  child: SvgPicture.asset(
                                      'assets/svg/Ellipse 3756.svg'),
                                ),
                                Container(
                                  width: 250,
                                  child: Text(
                                    'لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري',
                                    style: TextStyle(
                                        fontSize: AppFonts.t4,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 30),
                                  width: 50,
                                  height: 70,
                                  child: SvgPicture.asset(
                                      'assets/svg/Ellipse 3756.svg'),
                                ),
                                Container(
                                  width: 250,
                                  child: Text(
                                    'لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري',
                                    style: TextStyle(
                                        fontSize: AppFonts.t4,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Card(
                      elevation: 3,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'طريقة الدفع',
                                style: TextStyle(
                                    fontSize: AppFonts.t5,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomCheckBox(
                                            value: true,
                                            shouldShowBorder: false,
                                            borderRadius: 15,
                                            checkBoxSize: 14,
                                            onChanged: (val) {
                                              setState(() {
                                                _value = val;
                                              });
                                            }),
                                        Text(
                                          'مدي',
                                          style: TextStyle(
                                              fontSize: AppFonts.t4_2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomCheckBox(
                                            value: _value,
                                            borderRadius: 15,
                                            checkBoxSize: 14,
                                            onChanged: (val) {
                                              setState(() {
                                                _value = val;
                                              });
                                            }),
                                        Text(
                                          'فيزا',
                                          style: TextStyle(
                                              fontSize: AppFonts.t4_2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomCheckBox(
                                            value: _value,
                                            borderRadius: 15,
                                            checkBoxSize: 14,
                                            onChanged: (val) {
                                              setState(() {
                                                _value = val;
                                              });
                                            }),
                                        Text(
                                          'ماستر كارد',
                                          style: TextStyle(
                                              fontSize: AppFonts.t4_2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                // SizedBox(height: 30,),
                              ],
                            ),
                          ],
                        ),
                      )),
                ])),
          ),
          Positioned(
              height: 90,
              bottom: 0,
              width: size.width,
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
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 20, bottom: 20),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 3,
                        alignment: Alignment.center,
                        backgroundColor: Colors.transparent),
                    child: Text(
                      'ادفع الان (43543 ريال سعودي )',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      myNavigate(
                          screen: SuccessReservationScreen(
                            ads_id: '',
                          ),
                          context: context);
                    },
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
