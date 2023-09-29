import 'dart:developer';

import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/auth/register_controller.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/database/local/cache_helper.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../utils/enums.dart';

class RestPasswordCodeScreen extends StatefulWidget {
  final String phone;
  final Widget nextScreen;
  final bool isResetPass;

  const RestPasswordCodeScreen(
      {super.key,
      required this.phone,
      required this.nextScreen,
      this.isResetPass = true});

  @override
  State<RestPasswordCodeScreen> createState() => _RestPasswordCodeScreenState();
}

class _RestPasswordCodeScreenState extends State<RestPasswordCodeScreen> {
  String otpCode = '';
  bool isTrueOTP = false;
  TextEditingController otpController = TextEditingController();
  int endTime = DateTime.now().millisecondsSinceEpoch + 2000 * 30;
  RequestState requestState = RequestState.waiting;

  void sendOTP() async {
    setState(() => requestState = RequestState.loading);
    final res = await RegisterController.sendOTP();
    if (res) {
      setState(() => requestState = RequestState.success);
      myNavigate(
          screen: widget.nextScreen, context: context, withBackButton: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    log("-------> ${CurrentUser.OTP}");
    log("-------> ${CacheHelper.getData(key: "token")}");

    Size size = MediaQuery.of(context).size;
    CountdownTimerController controller =
        CountdownTimerController(endTime: endTime);
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: size.height * 0.025,
            bottom: size.height * 0.05,
            left: size.height * 0.02,
            right: size.height * 0.02,
          ),
          child: Column(
            children: [
              CustomAppBar(
                pageTitle:
                    widget.isResetPass ? 'نسيت كلمة المرور' : 'تفعيل الحساب',
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                children: [
                  ExpandableText(
                    'أدخل رمز التأكيد ذلك \n المرسل إلى رقم الهاتف',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppFonts.t4_2,
                      fontWeight: FontWeight.bold,
                    ),
                    expandText: '',
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    widget.phone,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: AppFonts.t4_2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                        controller: otpController,
                        appContext: context,
                        length: 4,
                        autoFocus: true,
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        backgroundColor: Color.fromARGB(219, 244, 241, 241),
                        pinTheme: PinTheme(
                          activeFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedColor: Colors.white,
                          disabledColor: Colors.white,
                          inactiveColor: Colors.white,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(4),
                          fieldHeight: 5.h,
                          fieldWidth: size.width * 0.12,
                          borderWidth: 0.5,
                          fieldOuterPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                        ),
                        animationType: AnimationType.scale,
                        animationDuration: Duration(milliseconds: 300),
                        onChanged: (pin) {
                          otpCode = pin;
                          log("Changed: " + pin);
                          // if (otpCode.length == 4 && !isTrueOTP) confirmOTP();
                        },
                        onCompleted: (pin) {
                          CurrentUser.OTP = pin;
                          log("Completed: " + pin);
                          sendOTP();
                        }),
                  )
                  // Directionality(
                  //   textDirection: TextDirection.rtl,
                  //   child: OTPTextField(
                  //       controller: otpController,
                  //       keyboardType: TextInputType.number,
                  //       length: 4,
                  //       width: MediaQuery.of(context).size.width,
                  //       fieldWidth: size.width * 0.12,
                  //       style: TextStyle(fontSize: AppFonts.t4_2),
                  //       otpFieldStyle: OtpFieldStyle(
                  //           backgroundColor:
                  //               Color.fromARGB(219, 244, 241, 241)),
                  //       textFieldAlignment: MainAxisAlignment.spaceAround,
                  //       fieldStyle: FieldStyle.box,
                  //       onChanged: (pin) {
                  //         otpCode = pin;
                  //         print("Changed: " + pin);
                  //         if (otpCode.length == 4 && !isTrueOTP) confirmOTP();
                  //       },
                  //       onCompleted: (pin) {
                  //         otpCode = pin;
                  //         print("Completed: " + pin);
                  //         if (!isTrueOTP) confirmOTP();
                  //       }),
                  // ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                  width: size.width,
                  height: 6.5.h,
                  child: Builder(builder: (context) {
                    if (requestState == RequestState.loading)
                      return Center(child: CircularProgressIndicator());
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor),
                      onPressed: () {
                        if (requestState == RequestState.loading) return;
                        sendOTP();
                      },
                      child: CustomText(
                          text: 'التـالي',
                          fontSize: AppFonts.t3,
                          color: Colors.white,
                          fontweight: FontWeight.bold),
                    );
                  })),
              SizedBox(
                height: 6.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      await RegisterController.resendOTP();
                    },
                    child: CustomText(
                        text: 'إعادة ارسال الكود', fontSize: AppFonts.t4_2),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: CountdownTimer(
                      controller: controller,
                      endTime: endTime,
                    ),
                    onTap: () {
                      controller.disposeTimer();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/*   void confirmOTP() {
    if (otpCode == CurrentUser.OTP) {
      isTrueOTP = true;
      sendOTP();
    } else {
      toastShow(text: 'رمز التأكيد غير صحيح');
      otpController.clear();
    }
  } */
}
