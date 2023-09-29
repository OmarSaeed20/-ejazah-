import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/constants/constants.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:ejazah/controller/add_service_controller/get_cities_controller.dart';
import 'package:ejazah/model/add_service_models/get_cities_model.dart';
import 'package:ejazah/model/search_models/search_result_model.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/home/driver_Screens/reviewAndSrearchScreen.dart';
import 'package:ejazah/widgets/myNavigate.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../components/map_screen.dart';
import '../../../controller/auth/get_streets_controller.dart';
import '../../../model/add_service_models/get_streets_model.dart';

class ChooseAddressDriverScreen extends StatefulWidget {
  const ChooseAddressDriverScreen({
    super.key,
    required this.ads,
  });
  final Ads ads;
  @override
  State<ChooseAddressDriverScreen> createState() =>
      _ChooseAddressDriverScreenState();
}

class _ChooseAddressDriverScreenState extends State<ChooseAddressDriverScreen> {
  String? city, street;
  late TextEditingController hours_numberCtrl;
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
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Builder(
            builder: (context) {
              if (requestState == RequestState.loading)
                return Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
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
                    CustomAppBar(pageTitle: ''),
                    SizedBox(height: 4.0.h),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customContainerDropdownButton(
                          hint: 'اختر المدينة',
                          value: city,
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
                              getStreetsModel =
                                  GetStreetsController.getStreetsModel;
                              AddAdsController.lat =
                                  getStreetsModel!.data!.streets!.first.lat!;
                              AddAdsController.long =
                                  getStreetsModel!.data!.streets!.first.long!;
                              if (getStreetsModel!.data!.streets!.isNotEmpty) {
                                street = getStreetsModel!.data!.streets![0].id!
                                    .toString();
                              }
                              streetRequestState = RequestState.success;
                              setState(() {
                                city = value;
                              });
                            });
                          },
                        ),
                        SizedBox(height: 2.h),
                        Builder(builder: (context) {
                          if (streetRequestState == RequestState.loading)
                            return Center(
                                child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator()));
                          if (streetRequestState == RequestState.error)
                            return ElevatedButton(
                                onPressed: () async {
                                  streetRequestState = RequestState.loading;
                                  setState(() {});
                                  final res =
                                      await GetStreetsController.getStreets();
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
                            value: street,
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
                                street = value;
                              });
                              AddAdsController.street_id = '$street';
                              final res = await GetStreetsController
                                  .getStreetPosition();
                              if (res) {
                                streetPositionRequestState =
                                    RequestState.success;
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
                            if (streetPositionRequestState ==
                                RequestState.loading)
                              return Center(
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            if (streetPositionRequestState ==
                                RequestState.error)
                              return Center(
                                child: CustomText(
                                  text: 'تأكد من اتصالك بالانترنت',
                                  color: Colors.red,
                                ),
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
                      ],
                    ),
                    CustomText(
                      text: 'من فضلك قم بإضافة عدد الساعات',
                      color: Colors.black,
                      fontSize: AppFonts.t3,
                      fontweight: FontWeight.bold,
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    SizedBox(height: 5.h),
                    Container(
                      width: size.width,
                      height: 7.5.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor,
                        ),
                        onPressed: () {
                          if (city == null && street == null) {
                            return;
                          }
                          if (hours_numberCtrl.text.isEmpty) {
                            return;
                          }
                          myNavigate(
                            screen: ReviewAndSearchScreen(
                              ads: widget.ads,
                              hours_number: hours_numberCtrl.text,
                              city_id: city,
                              street_id: street,
                              address: address,
                              lat: AddAdsController.lat,
                              lng: AddAdsController.long,
                            ),
                            context: context,
                          );
                        },
                        child: Text(
                          'التالي',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppFonts.t2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
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
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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

  void initializeData() {
    // city = AddAdsController.city_id;
    // street = AddAdsController.street_id;
    // addressController.text = AddAdsController.address;
  }
}
