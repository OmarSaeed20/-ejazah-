import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/auth/change_password_controller.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/auth/login_screen.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RestNewPasswordScreen extends StatefulWidget {
  final String phone;
  RestNewPasswordScreen({super.key, required this.phone});

  @override
  State<RestNewPasswordScreen> createState() => _RestNewPasswordScreenState();
}

class _RestNewPasswordScreenState extends State<RestNewPasswordScreen> {
  bool isVisiblePassword = false;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  RequestState requestState = RequestState.waiting;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              child: Column(children: [
                CustomAppBar(pageTitle: 'نسيت كلمة المرور'),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  children: [
                    ExpandableText(
                      'الرجاء كتابة كلمة مرور جديدة \n التأكد من أن لا أحد يعرف عن ذلك',
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
                      height: 8.h,
                    ),
                    Container(
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
                      child: customTextFormField(
                        obscureText: isVisiblePassword,
                        context: context,
                        controller: newPasswordController,
                        hintText: 'كلمة المرور',
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) {
                          return null;
                        },
                        suffixIconOnPressed: () {
                          isVisiblePassword = !isVisiblePassword;
                          setState(() {});
                        },
                        suffixIcon: isVisiblePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
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
                      child: customTextFormField(
                        obscureText: isVisiblePassword,
                        context: context,
                        controller: confirmNewPasswordController,
                        hintText: 'تأكيد كلمة المرور',
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) {
                          return null;
                        },
                        suffixIconOnPressed: () {
                          isVisiblePassword = !isVisiblePassword;
                          setState(() {});
                        },
                        suffixIcon: isVisiblePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                    width: size.width,
                    height: 7.5.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.buttonColor),
                        onPressed: () async {
                          if (requestState == RequestState.loading) return;
                          if (newPasswordController.text.length < 6) {
                            toastShow(
                                text:
                                    'يجب ان تكون كلمة المرور 6 رموز علي الافل');
                            return;
                          }
                          if (newPasswordController.text ==
                              confirmNewPasswordController.text) {
                            setState(() => requestState = RequestState.loading);
                            final res =
                                await ChangePasswordController.changePassword(
                                    widget.phone, newPasswordController.text);
                            if (res) {
                              setState(
                                  () => requestState = RequestState.success);
                              // myNavigate(screen: LoginScreen(), context: context);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => LoginScreen(),
                                    transitionDuration:
                                        const Duration(milliseconds: 300),
                                  ),
                                  (route) => false);
                            } else {
                              setState(() => requestState = RequestState.error);
                            }
                          } else {
                            toastShow(text: 'كلمة المرور غير متوافقة');
                          }
                        },
                        child: Builder(builder: (context) {
                          if (requestState == RequestState.loading)
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ));
                          return CustomText(
                              text: 'تــم',
                              fontSize: AppFonts.t3,
                              color: Colors.white,
                              fontweight: FontWeight.bold);
                        }))),
              ])),
        ));
  }
}
