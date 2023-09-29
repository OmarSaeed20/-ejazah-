import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customBottomNavBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/add_information_tavel_groups_controller.dart';
import 'package:ejazah/view/home/ads/add_tour_guide_screen.dart';
import 'package:ejazah/view/home/ads/add_marketing_and_resturant_screen.dart';
import 'package:ejazah/view/home/ads/choose_address_screen.dart';
import 'package:ejazah/view/home/ads/send_identifiy_screen.dart';
import 'package:ejazah/view/home/ads/traveling_groups_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/add_service_controller/add_ads_controller.dart';

class AddAdsScreen extends StatefulWidget {
  const AddAdsScreen({super.key});

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {
  bool value = false;
  String typeValue = '3';

  @override
  void initState() {
    AddInformationTravelGroupsController.clearData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        bottomNavigationBar: CustomBottomNavBar(
          navigationTabsIndex: 2,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: size.height * 0.025,
                bottom: size.height * 0.02,
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/Group 36770.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        'برجاء اختيار نوع الخدمة التي ستقدمها',
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
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            width: size.width,
                            height: 7.h,
                            color: Colors.white,
                            child: CustomRadioButton(
                              typeNum: '3',
                              title: 'بيوت العطلات',
                            )),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: size.width,
                            height: 7.h,
                            color: Colors.white,
                            child: CustomRadioButton(
                                title: 'سكن مشترك', typeNum: '4')),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: size.width,
                            height: 7.h,
                            color: Colors.white,
                            child: CustomRadioButton(
                              typeNum: '5',
                              title: 'مخيمات وشاليهات',
                            )),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: size.width,
                            height: 7.h,
                            color: Colors.white,
                            child: CustomRadioButton(
                                title: 'فعاليات', typeNum: '6')),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: size.width,
                            height: 7.h,
                            color: Colors.white,
                            child: CustomRadioButton(
                                title: 'مرشد سياحي', typeNum: '7')),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: size.width,
                            height: 7.h,
                            color: Colors.white,
                            child: CustomRadioButton(
                              typeNum: '8',
                              title: 'جروبات السفر',
                            )),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: size.width,
                            height: 7.h,
                            color: Colors.white,
                            child: CustomRadioButton(
                              typeNum: '9',
                              title: 'التسوق والمطاعم',
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      width: size.width,
                      height: 7.h,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttonColor),
                          onPressed: () {
                            AddAdsController.clearData();

                            print(typeValue);
                            AddAdsController.category_id = typeValue;

                            if (typeValue == '3' ||
                                typeValue == '4' ||
                                typeValue == '5') {
                              myNavigate(
                                  screen: SendIdentifyScreen(),
                                  context: context);
                            }
                            if (typeValue == '6') {
                              myNavigate(
                                  screen: ChooseAddressScreen(),
                                  context: context);
                              /* myNavigate(
                                  screen: AddInfoEventsScreen(),
                                  context: context); */
                            }
                            if (typeValue == '7') {
                              myNavigate(
                                  screen: AddTourGuideAdsScreen(),
                                  context: context);
                            }
                            if (typeValue == '8') {
                              myNavigate(
                                  screen: TeavelingGroupsScreen(),
                                  context: context);
                            }
                            if (typeValue == '9') {
                              myNavigate(
                                  screen: AddMarketingAndResturantScreen(),
                                  context: context);
                            }
                          },
                          child: Text(
                            'التـالي',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: AppFonts.t2,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ])),
        ));
  }

  bool isActivate = true;

  CustomRadioButton({String title = '', String typeNum = ''}) {
    return InkWell(
      onTap: () {
        // if (typeNum != '4' && typeNum != '3') isActivate = false;
        //  else isActivate = true;
        setState(() {
          AddAdsController.category_id = typeNum;
          typeValue = typeNum;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: AppFonts.t3,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          Radio(
            value: typeNum,
            groupValue: typeValue,
            onChanged: (val) {
              // if (typeNum != '4' && typeNum != '3' && typeNum != '8') return;

              AddAdsController.category_id = val.toString();
              setState(() {
                typeValue = val.toString();
              });
            },
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor:
                MaterialStateColor.resolveWith((states) => Colors.green),
          ),
        ],
      ),
    );
  }
}
