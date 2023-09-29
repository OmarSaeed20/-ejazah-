import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/home/ads/address_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/add_service_controller/add_user_details_controller.dart';
import '../../../utils/enums.dart';

class SendIdentifyScreen extends StatefulWidget {
  const SendIdentifyScreen({super.key});

  @override
  State<SendIdentifyScreen> createState() => _SendIdentifyScreenState();
}

class _SendIdentifyScreenState extends State<SendIdentifyScreen> {
  final ImagePicker picker = ImagePicker();

  RequestState requestState = RequestState.waiting;

  XFile? backIDImage, forwardIDImage;
  TextEditingController iBANController = TextEditingController();
  TextEditingController id_numberController = TextEditingController();
  TextEditingController Residence_permitController = TextEditingController();

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
                        'مرحبا بك , هذه معلومات خاصة في إدارة الموقع ولا تظهر في الإعلان.',
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
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          width: size.width,
                          height: 7.h,
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
                            controller: id_numberController,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.number,
                            cursorHeight: 25,
                            cursorWidth: 2,
                            onChanged: (value) {
                              AddUserDetailsController.id_number = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'رقم بطاقة الهوية',
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: AppFonts.t3),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          width: size.width,
                          height: 7.h,
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
                            controller: Residence_permitController,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.text,
                            cursorHeight: 25,
                            cursorWidth: 2,
                            onChanged: (value) {
                              AddUserDetailsController.Residence_permit = value;
                            },
                            decoration: InputDecoration(
                                hintText: 'تصريح السكن والتأجير',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: AppFonts.t3),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          width: size.width,
                          height: 6.5.h,
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
                            controller: iBANController,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.text,
                            cursorHeight: 25,
                            cursorWidth: 2,
                            onChanged: (value) {
                              AddUserDetailsController.iBAN = value;
                            },
                            decoration: InputDecoration(
                                hintText: 'رقم الأيبان',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: AppFonts.t3),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
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
                            if (requestState == RequestState.loading) return;
                            AddUserDetailsController.id_number =
                                id_numberController.text;
                            AddUserDetailsController.Residence_permit =
                                Residence_permitController.text;
                            AddUserDetailsController.iBAN = iBANController.text;
                            if (AddUserDetailsController.isValid()) {
                              requestState = RequestState.loading;
                              setState(() {});
                              AddUserDetailsController.addUserDetails()
                                  .then((value) {
                                if (value) {
                                  requestState = RequestState.success;
                                  myNavigate(
                                      screen: AddressInfoScreen(),
                                      context: context);
                                } else {
                                  requestState = RequestState.error;
                                }
                                setState(() {});
                              });
                            }
                          },
                          child: Builder(builder: (context) {
                            if (requestState == RequestState.loading)
                              return CircularProgressIndicator(
                                color: Colors.white,
                              );
                            return Text(
                              'ارسال',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppFonts.t2,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          })),
                    )
                  ])),
        ));
  }
}
