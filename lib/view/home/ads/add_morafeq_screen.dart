import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/view/home/ads/add_condetions_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../components/components.dart';
import '../../../controller/add_service_controller/get_cities_controller.dart';
import '../../../model/add_service_models/get_accompanying_model.dart';
import '../../../utils/enums.dart';

class AddMorafeqScreen extends StatefulWidget {
  const AddMorafeqScreen({super.key});

  @override
  State<AddMorafeqScreen> createState() => _AddMorafeqScreenState();
}

class _AddMorafeqScreenState extends State<AddMorafeqScreen> {
  bool isKitchenVisible = AddAdsController.kitchen_table == '0' ? false : true,
      isCouncil = AddAdsController.council == 1 ? true : false;
  TextEditingController kitchenTableController = TextEditingController(
      text: AddAdsController.kitchen_table == '0'
          ? ''
          : AddAdsController.kitchen_table);
  TextEditingController bedRoomController =
      TextEditingController(text: AddAdsController.bed_room);
  TextEditingController bathroomsController =
      TextEditingController(text: AddAdsController.Bathrooms);

  late List<Accompanyings> accompanyings;
  late List<bool> selectedOptions;
  List<int> selectedOptionsId = [];
  RequestState requestState = RequestState.waiting;
  GetAccompanyingModel? getAccompanyingModel;
  Future getData() async {
    AddAdsController.accompanying = selectedOptionsId;

    requestState = RequestState.loading;
    final res = await GetCitiesController.getAccompanying();
    if (res) {
      getAccompanyingModel = GetCitiesController.getAccompanyingModel;
      if (getAccompanyingModel == null) {
        setState(() => requestState = RequestState.error);
        toastShow(text: 'برجاء اعادة المحاولة لاحقا', state: ToastStates.error);
        return;
      }
      accompanyings = getAccompanyingModel!.data!.accompanyings!;

      selectedOptions =
          List<bool>.generate(accompanyings.length, (index) => false);
      requestState = RequestState.success;
    } else {
      requestState = RequestState.error;
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
              child: Builder(builder: (context) {
                print(CurrentUser.token);
                if (requestState == RequestState.loading)
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColor.buttonColor,
                  ));

                return Column(children: [
                  CustomAppBar(pageTitle: ''),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      'من فضلك قم بإضافة المرافق',
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
                          controller: bedRoomController,
                          enableInteractiveSelection: true,
                          keyboardType: TextInputType.number,
                          cursorHeight: 25,
                          cursorWidth: 2,
                          onChanged: (value) {
                            AddAdsController.bed_room = value;
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.bed_outlined),
                              hintText: 'عدد غرف النوم',
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: AppFonts.t3),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
                          controller: bathroomsController,
                          enableInteractiveSelection: true,
                          keyboardType: TextInputType.number,
                          cursorHeight: 25,
                          cursorWidth: 2,
                          onChanged: (value) {
                            AddAdsController.Bathrooms = value;
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.bathroom_outlined),
                              hintText: 'عدد دورات المياه',
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: AppFonts.t3),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text('أختر المرافق',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: accompanyings.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                              title: Text(accompanyings[index].name!,
                                  style: TextStyle(fontSize: 14)),
                              value: selectedOptions[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedOptions[index] = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return StatefulBuilder(
                      //           builder: (BuildContext context, void Function(void Function()) setState) {
                      //             return AlertDialog(
                      //               title: Text('أختر المرافق'),
                      //               content: Container(
                      //                 width: double.maxFinite,
                      //                 child: ListView.builder(
                      //                   shrinkWrap: true,
                      //                   itemCount: accompanyings.length,
                      //                   itemBuilder:
                      //                       (BuildContext context, int index) {
                      //                     return CheckboxListTile(
                      //                       title: Text(accompanyings[index].name!),
                      //                       value: selectedOptions[index],
                      //                       onChanged: (bool? value) {
                      //                         setState(() {
                      //                           selectedOptions[index] = value!;
                      //                         });
                      //                       },
                      //                     );
                      //                   },
                      //                 ),
                      //               ),
                      //               actions: [
                      //                 TextButton(
                      //                   onPressed: () {
                      //                     Navigator.pop(context);
                      //                   },
                      //                   child: Text('OK'),
                      //                 ),
                      //               ],
                      //             );
                      //           },
                      //         );
                      //       },
                      //     );
                      //   },
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton<String>(
                      //       hint: Text('أختر المرافق'),
                      //       items:  [],
                      //       onChanged: null,
                      //       elevation: 2,
                      //       style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 16,
                      //       ),
                      //       dropdownColor: Colors.white,
                      //       icon: Icon(
                      //         Icons.arrow_drop_down,
                      //         color: Colors.black,
                      //       ),
                      //       iconSize: 28,
                      //       isExpanded: true,
                      //       // Build the dropdown menu with checkboxes
                      //       onTap: () {
                      //
                      //       },
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 2.h),
                      if (isKitchenVisible)
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
                            controller: kitchenTableController,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.number,
                            cursorHeight: 25,
                            cursorWidth: 2,
                            onChanged: (value) {
                              AddAdsController.kitchen_table = value;
                            },
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.table_bar_outlined),
                                hintText: 'عدد طاولات بالمطبخ',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: AppFonts.t3),
                                border: InputBorder.none),
                          ),
                        ),
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
                            selectedOptionsId.clear();
                            if (AddAdsController.isMorafeqValid()) {
                              for (int i = 0; i < selectedOptions.length; i++) {
                                if (selectedOptions[i])
                                  selectedOptionsId.add(accompanyings[i].id!);
                              }
                              AddAdsController.accompanying = selectedOptionsId;
                              print(AddAdsController.accompanying);
                              myNavigate(
                                  screen: AddCondetionsScreen(),
                                  context: context);
                            }
                          },
                          child: CustomText(
                              text: 'التـالي',
                              fontSize: AppFonts.t2,
                              color: Colors.white,
                              fontweight: FontWeight.bold)))
                ]);
              })),
        ));
  }
}
