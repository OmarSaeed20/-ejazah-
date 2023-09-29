import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/add_service_controller/add_ads_controller.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/myNavigate.dart';
import '../../../controller/add_information_tavel_groups_controller.dart';
import '../success_reservation.dart';

class AddCondetionsScreen extends StatefulWidget {
  final bool? isAddTravel;
  const AddCondetionsScreen({super.key, this.isAddTravel});

  @override
  State<AddCondetionsScreen> createState() => _AddCondetionsScreenState();
}

class _AddCondetionsScreenState extends State<AddCondetionsScreen> {
  RequestState requestState = RequestState.waiting;
  List<TextEditingController> listTextController = [
    new TextEditingController()
  ];
  List<String> terms = [''];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
            SizedBox(height: 6.h),
            Container(
              height: 40.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: false,
                      itemBuilder: (context, index) => Container(
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
                            controller: listTextController[index],
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.name,
                            cursorHeight: 30,
                            cursorWidth: 2,
                            onChanged: (value) {
                              terms[index] = value;
                            },
                            decoration: InputDecoration(
                                hintText: '${index + 1} -'
                                    'من فضلك قم بإضافة الشروط والاحكام',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: AppFonts.t3),
                                border: InputBorder.none),
                          )),
                      separatorBuilder: (context, index) =>
                          Padding(padding: EdgeInsets.all(10)),
                      itemCount: listTextController.length,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              width: size.width,
              height: 7.h,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.greenSecondColor),
                  onPressed: () {
                    listTextController.add(TextEditingController());
                    terms.add('');
                    setState(() {});
                  },
                  child: Text(
                    'إضافة',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: AppFonts.t2,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: size.width,
              height: 7.h,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.redColor),
                  onPressed: () {
                    if (terms.length == 1) return;
                    listTextController.removeAt(terms.length - 1);
                    terms.removeAt(terms.length - 1);
                    setState(() {});
                  },
                  child: Text(
                    'حذف',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: AppFonts.t2,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 2.h,
            ),
            Builder(builder: (context) {
              if (requestState == RequestState.loading)
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColor.buttonColor,
                ));
              return Container(
                width: size.width,
                height: 7.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.buttonColor),
                    onPressed: () async {
                      if (terms[0].isEmpty) {
                        toastShow(
                            text: 'يجب إضافة شرط علي الاقل',
                            state: ToastStates.error);
                        return;
                      }
                      for (int i = 0; i < terms.length; i++) {
                        final String element = terms[i];
                        final int test = element.removeAllWhitespace.length;
                        if (test < 5) {
                          toastShow(
                              text: 'الشرط رقم ${i + 1} بتطلب 5 احرف على الاقل',
                              state: ToastStates.error);
                          return;
                        }
                      }

                      setState(() => requestState = RequestState.loading);
                      bool res = false;
                      if (widget.isAddTravel != null) {
                        AddInformationTravelGroupsController.terms = terms;
                        final ress = await AddInformationTravelGroupsController
                            .addTravel();
                        if (ress) {
                          myNavigate(
                              screen: SuccessReservationScreen(
                                  ads_id: '', isAddTravel: true),
                              context: context);
                        } else {
                          setState(() => requestState = RequestState.error);
                        }
                      } else {
                        AddAdsController.terms = terms;
                        final ress = await AddAdsController.addAds();
                        res = ress;
                      }
                      if (res) {
                        setState(() => requestState = RequestState.success);
                        myNavigate(
                            screen: SuccessReservationScreen(
                                ads_id: '', isAddTravel: true),
                            context: context);
                      } else
                        setState(() => requestState = RequestState.error);
                    },
                    child: Text(
                      'التالي',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: AppFonts.t2,
                          fontWeight: FontWeight.bold),
                    )),
              );
            })
          ])),
    ));
  }
}
