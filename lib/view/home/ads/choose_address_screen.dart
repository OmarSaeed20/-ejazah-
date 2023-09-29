import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:ejazah/controller/add_service_controller/get_cities_controller.dart';
import 'package:ejazah/model/add_service_models/get_cities_model.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/home/ads/add_information_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../components/map_screen.dart';
import '../../../controller/auth/get_streets_controller.dart';
import '../../../model/add_service_models/get_streets_model.dart';

class ChooseAddressScreen extends StatefulWidget {
  const ChooseAddressScreen({super.key});

  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  String? city, street;
  Streets? selectStreet;

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
    initializeData();
    getData();
    super.initState();
  }

  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Center(
            child: Builder(builder: (context) {
              if (requestState == RequestState.loading)
                return Center(child: CircularProgressIndicator());
              if (requestState == RequestState.error)
                return Center(
                  child: CustomText(
                    text: 'تأكد من اتصالك بالانترنت',
                    color: Colors.red,
                  ),
                );

              return Column(children: [
                CustomAppBar(pageTitle: ''),
                SizedBox(height: 6.0.h),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'من فضلك قم بإضافة بيانات صحيحة',
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
                            (e) => DropdownMenuItem(
                              value: e.id.toString(),
                              child: Text(e.title),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        AddAdsController.city_id = value!;
                        print(AddAdsController.city_id);
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
                          // print('length');
                          // print(GetStreetsController.getStreetsModel!.data!.streets!.length);
                          // print(AddAdsController.street_id);
                          if (getStreetsModel!.data!.streets!.isNotEmpty) {
                            AddAdsController.street_id = getStreetsModel!
                                .data!.streets![0].id!
                                .toString();
                            street = AddAdsController.street_id;
                          }
                          streetRequestState = RequestState.success;
                          setState(() {
                            city = value;
                          });
                        });
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Builder(builder: (context) {
                      if (streetRequestState == RequestState.loading)
                        return Center(child: CircularProgressIndicator());
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
                      // print(getStreetsModel!.data!.streets!.length);
                      // return Container();
                      // print(street);
                      return customContainerDropdownButton(
                        hint: 'اختر الحي',
                        value: street,
                        items: getStreetsModel!.data!.streets!
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.id.toString(),
                                child: Text(e.name!),
                              ),
                            )
                            .toList(),
                        onChanged: (value) async {
                          streetPositionRequestState = RequestState.loading;
                          setState(() {
                            AddAdsController.street_id = value!;
                            street = value;
                          });
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
                    Builder(builder: (context) {
                      if (streetPositionRequestState == RequestState.loading)
                        return Center(child: CircularProgressIndicator());
                      if (streetPositionRequestState == RequestState.error)
                        return Center(
                            child: CustomText(
                                text: 'تأكد من اتصالك بالانترنت',
                                color: Colors.red));
                      return Container(
                        alignment: Alignment.center,
                        width: size.width,
                        height: 38.h,
                        child: MapScreen(
                          checkCurrent: true,
                          disableMarker: false,
                          latlong: AddAdsController.lat != ""
                              ? LatLng(double.parse(AddAdsController.lat),
                                  double.parse(AddAdsController.long))
                              : null,
                        ),
                      );
                    }),
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
                        AddAdsController.city_id = city!;
                        AddAdsController.street_id = street!;
                        if (AddAdsController.isChooseYourAddressScreenValid()) {
                          myNavigate(
                              screen: AddInfoEventsScreen(), context: context);
                        }
                      },
                      child: Text(
                        'التالي',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppFonts.t2,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ]);
            }),
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
