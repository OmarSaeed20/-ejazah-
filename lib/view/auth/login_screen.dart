// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/constants/api_paths.dart';
import 'package:ejazah/controller/auth/get_countries_controller.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/model/register_models/get_countries_model.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/auth/choose_country_screen.dart';
import 'package:ejazah/view/auth/forget_password_screen.dart';
import 'package:ejazah/view/auth/register_screen.dart';
import 'package:ejazah/view/auth/rest_password_code.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

import '../../core/global.dart';

class LoginScreen extends StatefulWidget {
  static const String LoginRoute = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late TextEditingController phoneCtrl, passwordCtrl;
  final _formKey = GlobalKey<FormState>();

  bool processing = false;

  bool isVisiblePassword = false;
  RequestState requestState = RequestState.waiting;
  late final int len;
  List<Countries>? country;
  int countryValue = 1;

  @override
  void initState() {
    super.initState();
    phoneCtrl = new TextEditingController();
    passwordCtrl = new TextEditingController();
    requestState = RequestState.loading;
    GetCountries.getCountries().then((value) {
      if (value) {
        len = GetCountries.getCountriesModel!.data!.countries!.length;
        country = GetCountries.getCountriesModel!.data!.countries;
        requestState = RequestState.success;
      } else {
        requestState = RequestState.error;
      }

      setState(() {});
    });
    GetCountries.getDate();

    super.initState();
    setState(() {
      CurrentUser.countryId = countryValue.toString();
    });
  }

  late bool isActive;

  Future<bool> userSignIn(String phone, String password) async {
    CurrentUser.clearUser();
    setState(() {
      processing = true;
    });

    log(CurrentUser.deviceToken.toString());
    var url = ApiPath.baseurl + ApiPath.login;
    var data = {
      "phone": phone,
      "password": password,
      "device_token": CurrentUser.deviceToken,
      "country_id": "",
    };
    try {
      var resbody = await Dio()
          .post(url, data: data, options: Options(headers: {'lang': '1'}));
      setState(() {
        processing = false;
      });

      print(resbody.toString());
      if (resbody.data.isNotEmpty) {
        print(resbody);
        isActive = resbody.data['data']['isActive'] == 1;
        print('isActive');
        print(isActive);
        if (resbody.data['status'] == true) {
          CurrentUser.fromJson(resbody.data['data']['user']);
          CurrentUser.OTP = resbody.data['data']['code'].toString();
          print("==========> ${CurrentUser.id}");
        } else {
          toastShow(text: resbody.data['message'], state: ToastStates.black);
          return false;
        }

        return true;
      }
    } catch (e) {
      print("error");
      print(e);
      setState(() {
        processing = false;
      });
      toastShow(
          text: 'رقم الهاتف او كلمة المرور خاطئة'.tr, state: ToastStates.error);
    }
    return false;
  }

  bool visible = false;
  String? flag;
  String? code;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: size.height * 0.025,
                bottom: size.height * 0.05,
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomAppBar(pageTitle: ''),
                  ),
                  SvgPicture.asset(
                    'assets/svg/Group 36770.svg',
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: 'تسجيل الدخـول',
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: AppFonts.t2,
                    fontweight: FontWeight.bold,
                  ),
                  SizedBox(height: 2.h),
                  (requestState == RequestState.loading)
                      ? SizedBox(
                          height: 25,
                          width: 25,
                          child: Center(child: CircularProgressIndicator()))
                      : Column(
                          children: [
                            customContainerTextFormField(
                              TFF: customTextFormField(
                                context: context,
                                controller: phoneCtrl,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Is Required".tr),
                                ]),
                                hintText: 'رقم الهاتـف'.tr,
                                keyboardType: TextInputType.phone,
                                suffixIcon: Icons.call,
                                isCountry: true,
                                flag: flag == null ? country![0].flag : flag,
                                code: code == null ? country![0].code : code,
                                callback: () {
                                  visible = !visible;
                                  setState(() {});
                                },
                              ),
                            ),
                            Visibility(
                              visible: visible,
                              replacement: Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: customContainerTextFormField(
                                  TFF: customTextFormField(
                                    context: context,
                                    controller: passwordCtrl,
                                    obscureText: isVisiblePassword,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Is Required".tr),
                                    ]),
                                    hintText: 'كلمه المرور',
                                    keyboardType: TextInputType.visiblePassword,
                                    suffixIcon: isVisiblePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    suffixIconOnPressed: () {
                                      setState(() {
                                        isVisiblePassword = !isVisiblePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.only(top: 1.0.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5.0),
                                alignment: Alignment.center,
                                width: context.getWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      offset: const Offset(0, 1.0),
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: country!.map(
                                    (element) {
                                      return DropdownMenuItem<Countries>(
                                        value: element,
                                        child: InkWell(
                                          onTap: () {
                                            CurrentUser.countryId =
                                                '${element.id}';
                                            flag = element.flag;
                                            code = element.code;
                                            visible = false;
                                            setState(() {});
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${element.code}',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                  fontFamily: "Tajawal",
                                                ),
                                              ),
                                              SizedBox(width: 1.0.w),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                child: Image.network(
                                                  '${element.flag}',
                                                  height: 4.0.h,
                                                  width: 4.0.h,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: 2.0.h),
                  Container(
                    padding: EdgeInsets.only(right: size.width * 0.04),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.grey[300])),
                      child: Text(
                        'نسيت كلمة المرور ؟',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppFonts.t4_2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        myNavigate(
                            screen: ForgetPasswordScreen(), context: context);
                      },
                    ),
                  ),
                  SizedBox(height: 8.0.h),
                  Container(
                    width: size.width,
                    height: 6.5.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor),
                      onPressed: () async {
                        if (processing) return;
                        final isSuccess =
                            await userSignIn(phoneCtrl.text, passwordCtrl.text);
                        if (isSuccess) {
                          firebaseAuthUser
                              .signInWithEmailAndPassword(
                                  email: CurrentUser.email!,
                                  password: passwordCtrl.text)
                              .then((value) {
                            if (isActive) {
                              myNavigate(
                                  screen: ChooseCountryScreen(),
                                  context: context,
                                  withBackButton: false);
                            } else {
                              myNavigate(
                                  screen: RestPasswordCodeScreen(
                                    isResetPass: false,
                                    phone: phoneCtrl.text,
                                    nextScreen: ChooseCountryScreen(),
                                  ),
                                  context: context);
                            }
                          }).catchError((e) {
                            print(e.toString());
                          });
                        }
                      },
                      child: Builder(
                        builder: (context) {
                          if (processing)
                            return Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white));
                          return CustomText(
                            text: 'تسجيل الدخـول',
                            fontSize: AppFonts.t3,
                            color: Colors.white,
                            fontweight: FontWeight.bold,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حسـاب ؟',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppFonts.t4_2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          myNavigate(
                              screen: RegisterScreen(), context: context);
                        },
                        child: Text(
                          '  إنـشاء حسـاب',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: AppFonts.t4_2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customContainerTextFormField({required Widget TFF}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      alignment: Alignment.center,
      width: context.getWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0, 1.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: TFF,
    );
  }

  String text(String text) => 'برجاء ادخال $text';
}
