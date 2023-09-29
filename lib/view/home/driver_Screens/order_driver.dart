// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/customBtn.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/components/map_screen.dart';
import 'package:ejazah/constants/constants.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:ejazah/controller/add_service_controller/get_cities_controller.dart';
import 'package:ejazah/controller/auth/get_streets_controller.dart';
import 'package:ejazah/model/add_service_models/get_cities_model.dart';
import 'package:ejazah/model/add_service_models/get_streets_model.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import 'driverResultsScreen.dart';

class OrderDeriverScreen extends StatefulWidget {
  const OrderDeriverScreen({super.key});

  @override
  State<OrderDeriverScreen> createState() => _OrderDeriverScreenState();
}

class _OrderDeriverScreenState extends State<OrderDeriverScreen> {
  double zoom = 15;
  String? dateTime, time;
  late TextEditingController hours_numberCtrl;

  String? city_id, street_id;

  GetCitiesModel? getCitiesModel;
  GetStreetsModel? getStreetsModel;
  RequestState requestState = RequestState.waiting;
  RequestState streetRequestState = RequestState.waiting;
  RequestState streetPositionRequestState = RequestState.waiting;

  Future getData() async {
    requestState = RequestState.loading;
    final res = await GetCitiesController.getCities();
    final res2 = await GetStreetsController.getStreets();
    if (res && res2) {
      getCitiesModel = GetCitiesController.getCitiesModel;
      getStreetsModel = GetStreetsController.getStreetsModel;
      // city = getCitiesModel!.data!.cities!.first.id.toString();
      // street = getStreetsModel!.data!.streets!.first.id.toString();
      if (getCitiesModel == null || getStreetsModel == null) {
        setState(() => requestState = RequestState.error);
        toastShow(text: 'برجاء اعادة المحاولة لاحقا', state: ToastStates.error);
        return;
      }
      requestState = RequestState.success;
    } else {
      requestState = RequestState.error;
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    hours_numberCtrl = TextEditingController();
    AddAdsController.city_id = '';
    AddAdsController.lat = '';
    AddAdsController.long = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // void _selectTime() async {
    //   final TimeOfDay? newTime = await showTimePicker(
    //     context: context,
    //     initialTime: _time,
    //   );
    //   if (newTime != null) {
    //     setState(() {
    //       _time = newTime;
    //     });
    //   }
    // }

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Builder(builder: (context) {
            if (requestState == RequestState.loading)
              return Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                ),
              );
            if (requestState == RequestState.error)
              return Center(
                child: CustomText(
                  text: 'تأكد من اتصالك بالانترنت',
                  color: Colors.red,
                ),
              );
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(pageTitle: 'حجز سائق'),
                  SizedBox(height: 6.0.h),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      'من فضلك قم باختيار وجهتك',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppFonts.t3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  customContainerDropdownButton(
                    hint: 'اختر المدينة',
                    value: city_id,
                    items: getCitiesModel!.data!.cities!
                        .map(
                          (element) => DropdownMenuItem(
                            value: element.id.toString(),
                            child: Text(element.title),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      AddAdsController.city_id = '$value';
                      streetRequestState = RequestState.loading;
                      setState(() {});
                      GetStreetsController.getStreets().then((res) {
                        if (!res) {
                          streetRequestState = RequestState.error;
                          setState(() {});
                          return;
                        }
                        getStreetsModel = GetStreetsController.getStreetsModel;
                        AddAdsController.lat =
                            getStreetsModel!.data!.streets!.first.lat!;
                        AddAdsController.long =
                            getStreetsModel!.data!.streets!.first.long!;
                        if (getStreetsModel!.data!.streets!.isNotEmpty) {
                          street_id =
                              getStreetsModel!.data!.streets![0].id!.toString();
                          setState(() {});
                        }
                        streetRequestState = RequestState.success;
                        setState(() {
                          city_id = value;
                        });
                        setState(() {
                          log("street ==> $street_id");
                          log("city ==> $city_id");
                        });
                      });
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Builder(builder: (context) {
                    if (streetRequestState == RequestState.loading)
                      return Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    if (streetRequestState == RequestState.error)
                      return ElevatedButton(
                          onPressed: () async {
                            streetRequestState = RequestState.loading;
                            setState(() {});
                            final res = await GetStreetsController.getStreets();
                            if (res) {
                              streetRequestState = RequestState.success;
                              setState(() {});
                            } else {
                              streetRequestState = RequestState.error;
                              setState(() {});
                            }
                          },
                          child: Text('اضغط لاعادة المحاولة'));

                    return customContainerDropdownButton(
                      hint: 'اختر الحي',
                      value: street_id,
                      items: getStreetsModel!.data!.streets!
                          .map(
                            (element) => DropdownMenuItem(
                              value: element.id.toString(),
                              child: Text(element.name!),
                            ),
                          )
                          .toList(),
                      onChanged: (value) async {
                        streetPositionRequestState = RequestState.loading;
                        setState(() {
                          street_id = value;
                        });
                        AddAdsController.street_id = '$street_id';
                        final res =
                            await GetStreetsController.getStreetPosition();
                        if (res) {
                          streetPositionRequestState = RequestState.success;
                        } else {
                          streetPositionRequestState = RequestState.error;
                        }
                        setState(() {});
                      },
                    );
                  }),
                  SizedBox(
                    height: 2.h,
                  ),
                  Builder(
                    builder: (context) {
                      if (streetPositionRequestState == RequestState.loading)
                        return Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      if (streetPositionRequestState == RequestState.error)
                        return Center(
                          child: CustomText(
                              text: 'تأكد من اتصالك بالانترنت',
                              color: Colors.red),
                        );
                      return Container(
                        alignment: Alignment.center,
                        width: size.width,
                        height: 32.5.h,
                        child: MapScreen(
                          checkCurrent: true,
                          disableMarker: false,
                          latlong: AddAdsController.lat.isNotEmpty &&
                                  AddAdsController.long.isNotEmpty
                              ? LatLng(double.parse(AddAdsController.lat),
                                  double.parse(AddAdsController.long))
                              : null,
                        ),
                      );
                    },
                  ),
                  /* Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                                width: size.width,
                                height: 7.5.h,
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
                                  readOnly: true,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      useSafeArea: true,
                                      builder: (context) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(1.h),
                                          contentPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.white,
                                          elevation: 4,
                                          shadowColor: Colors.grey,
                                          content: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              MapScreen(
                                                height: size.height * .70,
                                                checkCurrent: true,
                                                disableMarker: false,
                                                latlong: AddAdsController
                                                            .lat.isNotEmpty &&
                                                        AddAdsController
                                                            .long.isNotEmpty
                                                    ? LatLng(
                                                        double.parse(
                                                            AddAdsController.lat),
                                                        double.parse(
                                                            AddAdsController
                                                                .long))
                                                    : null,
                                              ),
                                              SizedBox(height: 2.0.h),
                                              SizedBox(
                                                height: 6.h,
                                                width: size.width * .8,
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.white),
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                          AppColor.buttonColor,
                                                        )),
                                                    onPressed: () {
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('حسنا')),
                                              )
                                            ],
                                          )),
                                        );
                                      },
                                    );
                                  },
                                  enableInteractiveSelection: true,
                                  cursorHeight: 25,
                                  cursorWidth: 2,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    hintText: AddAdsController.lat.isEmpty &&
                                            AddAdsController.long.isEmpty
                                        ? 'أين يأتي لك السائق ؟'
                                        : 'تم تحديد موقعك',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none,
                                  ),
                                )),
                             */
                  CustomText(
                    text: 'من فضلك قم بإضافة عدد الساعات',
                    color: Colors.black,
                    fontSize: AppFonts.t3,
                    fontweight: FontWeight.bold,
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    margin: EdgeInsets.all(4),
                    width: context.getWidth,
                    height: 6.5.h,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: customTextFormField(
                      context: context,
                      controller: hours_numberCtrl,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      hintText: 'عدد الساعات',
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  /*   GestureDetector(
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100),
                                  );
                                  if (date == null) {
                                    dateTime = null;
                                    return;
                                  }
                                  dateTime = date.year.toString() +
                                      '-' +
                                      date.month.toString() +
                                      '-' +
                                      date.day.toString();
                                  print(dateTime);
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppSvgImages.calendarIc,
                                      color: AppColor.orangeColor,
                                    ),
                                    CustomText(
                                        text: dateTime ?? 'تاريخ بدأ الرحلة',
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3.w, horizontal: 2.w),
                                        fontSize: AppFonts.t3,
                                        color: AppColor.grayColor),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.h),
                              GestureDetector(
                                onTap: () async {
                                  final TimeOfDay? newTime = await showTimePicker(
                                    confirmText: 'تم',
                                    cancelText: 'إلغاء',
                                    context: context,
                                    helpText: 'متي تريد ان تبدا الرحله',
                                    initialTime: TimeOfDay(hour: 12, minute: 00),
                                  );
              
                                  setState(() {
                                    if (newTime != null) {
                                      newTime.format(context);
                                      time = newTime.format(context);
                                      print(newTime.toString());
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer_rounded,
                                      color: AppColor.orangeColor,
                                    ),
                                    CustomText(
                                        text: time ?? 'متي نريد بدأ الرحلة',
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3.w, horizontal: 2.w),
                                        fontSize: AppFonts.t3,
                                        color: AppColor.grayColor),
                                  ],
                                ),
                              ),
                               */
                  SizedBox(height: 5.0.h),
                  CustomButton(
                    text: "رؤية المرشدين المتاحين حاليا",
                    onPressed: () {
                      /*  if (time == null) {
                                      toastShow(text: 'أختر وقت الرحلة');
                                      return;
                                    } */

                      if (city_id == null && street_id == null) {
                        return;
                      }
                      if (hours_numberCtrl.text.isEmpty) {
                        return;
                      }
                      /*   if (dateTime == null) {
                                      toastShow(text: 'أختر تاريخ الرحلة');
                                      return;
                                    } */
                      myNavigate(
                        screen: DriverResultScreen(
                          hours_number: hours_numberCtrl.text,
                          city_id: city_id!,
                          street_id: street_id!,
                          address: address,
                          lat: AddAdsController.lat,
                          lng: AddAdsController.long,
                        ),
                        context: context,
                      );
                    },
                    radius: 2.w,
                    height: 7.5.h,
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget customContainerDropdownButton({
    required String hint,
    required dynamic value,
    required List<DropdownMenuItem<String>>? items,
    required void Function(String?)? onChanged,
  }) {
    // getCitiesModel!.data!.cities!
    //     .map(
    //       (e) => DropdownMenuItem(
    //         value: e.id.toString(),
    //         child: Text(e.title!),
    //       ),
    //     )
    //     .toList();
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: EdgeInsets.all(4),
        width: context.getWidth,
        height: 7.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(
              hint,
              style:
                  TextStyle(fontSize: AppFonts.t3, fontWeight: FontWeight.bold),
            ),
            isExpanded: true,
            items: items,
            onChanged: onChanged,
          ),
        ));
  }
}

Widget CustomDevider({width}) {
  return Container(
    width: width ?? 13.w,
    margin: EdgeInsets.symmetric(vertical: 2.h),
    padding: EdgeInsets.all(.5.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w), color: AppColor.secondColor),
  );
}
