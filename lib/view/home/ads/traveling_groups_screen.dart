import 'dart:developer';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/home/ads/add_information_tavel_groups_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/add_information_tavel_groups_controller.dart';
import '../../../model/travel_country_model.dart';
import '../../../model/travel_type_model.dart';
import '../../../utils/enums.dart';

class TeavelingGroupsScreen extends StatefulWidget {
  const TeavelingGroupsScreen({super.key});

  @override
  State<TeavelingGroupsScreen> createState() => _TeavelingGroupsScreenState();
}

class _TeavelingGroupsScreenState extends State<TeavelingGroupsScreen> {
  RequestState requestState = RequestState.waiting;

  XFile? backIDImage, forwardIDImage;
  String? value;
  String? travel_type;
  bool _value = false;
  bool _value2 = false;
  TextEditingController titleController = TextEditingController();

  late DateTime to;
  late DateTime from;
  int difference = 0;
  TextEditingController iBANController = TextEditingController();
  TextEditingController license_number = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TravelCountryModel? travelCountryModel;
  TravelTypeModel? travelTypeModel;
  String? country;
  String? lang;
  List<XFile>? images;
  getData() async {
    requestState = RequestState.loading;
    final res = await AddInformationTravelGroupsController.getTravelCountry();
    final res2 = await AddInformationTravelGroupsController.getTravelType();
    if (!res || !res2) {
      setState(() {
        requestState = RequestState.error;
      });
      return;
    }
    travelCountryModel =
        AddInformationTravelGroupsController.travelCountryModel;
    travelTypeModel = AddInformationTravelGroupsController.travelTypeModel;
    setState(() {
      requestState = RequestState.success;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: Builder(builder: (context) {
            if (requestState == RequestState.loading)
              return Center(child: CircularProgressIndicator());
            if (requestState == RequestState.error)
              return Text('تأكد من اتصالك بالانترنت');

            return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  bottom: size.height * 0.02,
                  left: size.height * 0.02,
                  right: size.height * 0.02,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                          'مرحبا بك , لتتمكن من إضافة خدمات واعلانات برجاء امدادنا ببعض البيانات لاتمام طلبك',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppFonts.t3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            width: size.width,
                            height: 7.0.h,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                hintText: "عنوان الإعلان",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          /* Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            width: size.width,
                            height: 7.0.h,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                isExpanded: true,
                                value: travel_type,
                                hint: Text('عنوان الاعلان'),
                                items: travelTypeModel!.data!.travelType!
                                    .map((element) {
                                  return DropdownMenuItem(
                                    value: element.id.toString(),
                                    child: Transform.translate(
                                      offset: Offset(0, -2.0.h),
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          element.name ?? '',
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        value: element.id.toString(),
                                        groupValue: travel_type,
                                        onChanged: null,
                                        selectedTileColor: Colors.blue,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  log("------> $travel_type");
                            
                                  setState(
                                      () => travel_type = value.toString());
                                },
                              ),
                            ),
                          ),
                           */
                          SizedBox(
                            height: 4.h,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: CustomText(
                                text: 'برجاء اختيار دولة وجهت السفر',
                                fontSize: AppFonts.t3,
                                fontweight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              margin: EdgeInsets.all(4),
                              width: size.width,
                              height: 7.h,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: country,
                                  hint: Text(
                                    'اختر الدولة',
                                    style: TextStyle(
                                        fontSize: AppFonts.t3,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  isExpanded: true,
                                  items: travelCountryModel!.data!.travelCountry
                                      ?.map(
                                    (e) {
                                      return DropdownMenuItem<String>(
                                        value: e.id.toString(),
                                        child: Row(
                                          children: [
                                            Image(
                                              image:
                                                  NetworkImage(e.image ?? ''),
                                              width: 40,
                                              height: 40,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(e.name ?? ''),
                                          ],
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    country = value;
                                    log(country!);
                                    setState(() {});
                                  },
                                ),
                              )),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomCheckBox(
                                  value: _value,
                                  onChanged: (val) {
                                    _value = val;
                                    if (_value) _value2 = false;
                                    setState(() {});
                                  }),
                              CustomText(
                                text: 'مجموعة سفر خاصة',
                                color: Colors.black87,
                                fontSize: AppFonts.t3,
                              ),
                            ],
                          )),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomCheckBox(
                                  value: _value2,
                                  onChanged: (val) {
                                    _value2 = val;
                                    if (_value2) _value = false;
                                    setState(() {});
                                  }),
                              CustomText(
                                  text: 'مجموعة سفر مشتركة',
                                  color: Colors.black87,
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
                        height: 7.h,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.buttonColor),
                            onPressed: () {
                              AddInformationTravelGroupsController.travel_name =
                                  titleController.text;
                              AddInformationTravelGroupsController
                                  .travel_country_id = country;

                              AddInformationTravelGroupsController
                                  .indivdual_travel = _value;
                              AddInformationTravelGroupsController
                                  .group_travel = _value2;

                              myNavigate(
                                  screen: AddInfoTravelGroupScreen(),
                                  context: context);
                              // if (requestState == RequestState.loading) return;
                              // if (AddUserDetailsController.isValid()) {
                              //   requestState = RequestState.loading;
                              //   setState(() {});
                              //   AddUserDetailsController.addUserDetails()
                              //       .then((value) {
                              //     if (value) {
                              //       requestState = RequestState.success;
                              //       myNavigate(
                              //           screen: AddressInfoScreen(),
                              //           context: context);
                              //     } else {
                              //       requestState = RequestState.error;
                              //     }
                              //     setState(() {});
                              //   });
                              // }
                            },
                            child: Builder(builder: (context) {
                              // if (requestState == RequestState.loading)
                              //   return CircularProgressIndicator(
                              //     color: Colors.white,
                              //   );
                              return Text(
                                'التالي',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppFonts.t2,
                                    fontWeight: FontWeight.bold),
                              );
                            })),
                      )
                    ]));
          }),
        ));
  }
}
