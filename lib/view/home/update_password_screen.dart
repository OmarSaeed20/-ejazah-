import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/app_colors.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController =
        TextEditingController();

    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.05,
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
              child: Column(children: [
                CustomAppBar(pageTitle: 'تغير كلمة المرور'),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  children: [
                    Text(
                      'الرجاء كتابة كلمة مرور جديدة \n التأكد من أن لا أحد يعرف عن ذلك',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppFonts.t4_2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
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
                        controller: currentPasswordController,
                        enableInteractiveSelection: true,
                        obscureText: true,
                        cursorHeight: 25,
                        cursorWidth: 2,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            hintText: 'كلمة المرور الحاليه',
                            hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: AppFonts.t4_2),
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
                        controller: newPasswordController,
                        enableInteractiveSelection: true,
                        obscureText: true,
                        cursorHeight: 25,
                        cursorWidth: 2,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            hintText: 'كلمة المرور',
                            hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: AppFonts.t4_2),
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
                        controller: confirmNewPasswordController,
                        enableInteractiveSelection: true,
                        obscureText: true,
                        cursorHeight: 25,
                        cursorWidth: 2,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            hintText: 'تأكيد كلمة المرور',
                            hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: AppFonts.t4_2),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: size.width,
                  height: 7.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              elevation: 2,
                              title: Text(
                                'هل تريد تغير كلمة المرور؟',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: AppFonts.t2,
                                    fontWeight: FontWeight.bold),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        style: TextButton.styleFrom(),
                                        onPressed: () {
                                          myNavigate(
                                              screen: LoginScreen(),
                                              context: context);
                                        },
                                        child: Text(
                                          'نعم',
                                          style: TextStyle(
                                              fontSize: AppFonts.t4_2,
                                              color: Colors.black87),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'لا',
                                          style: TextStyle(
                                              fontSize: AppFonts.t4_2,
                                              color: Colors.black87),
                                        )),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'تــم',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppFonts.t2,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ])),
        ));
  }
}
