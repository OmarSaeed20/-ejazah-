import 'dart:developer';

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
import 'package:ejazah/view/auth/rest_new_password.dart';
import 'package:ejazah/view/auth/rest_password_code.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController phoneCtrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneCtrl = new TextEditingController();
  }

  bool visible = false;
  String? flag;
  String? code;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void forgetPasswordFun(String phone) async {
      setState(() {
        isLoading = true;
      });
      var url = '${ApiPath.baseurl}forgetPassword';
      var data = {
        "phone": phone,
      };

      var res = await http.post(Uri.parse(url), body: data);
      var resbody;
      if (res.body.isNotEmpty) {
        resbody = json.decode(res.body);

        if (resbody['status'] == true) {
          Fluttertoast.showToast(
              msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);

          myNavigate(
              screen: RestPasswordCodeScreen(
                phone: phone,
                nextScreen: RestNewPasswordScreen(phone: phone),
              ),
              context: context);
          setState(() {
            isLoading = false;
          });
        } else {
          Fluttertoast.showToast(
              msg: resbody['message'], toastLength: Toast.LENGTH_SHORT);
          setState(() {
            isLoading = false;
          });
        }
      }
    }

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
              CustomAppBar(pageTitle: 'نسيت كلمة المرور'),
              SizedBox(
                height: 6.h,
              ),
              SvgPicture.asset(
                'assets/svg/Forgot password-cuate.svg',
                width: 28.w,
                height: 28.h,
              ),
              SizedBox(height: 5.0.h),
              Column(
                children: [
                  ExpandableText(
                    'أدخل رقم هاتف تستطيع تلقي الرسائل \n النصيه عليه',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppFonts.t3,
                      fontWeight: FontWeight.bold,
                    ),
                    expandText: '',
                  ),
                  SizedBox(height: 4.0.h),
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
                    child: customTextFormField(
                      context: context,
                      controller: phoneCtrl,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Is Required".tr),
                      ]),
                      hintText: 'رقم الهاتـف',
                      keyboardType: TextInputType.phone,
                      suffixIcon: Icons.call,
                      isCountry: true,
                      flag: flag == null
                          ? GetCountries
                              .getCountriesModel!.data!.countries![0].flag
                          : flag,
                      code: code == null
                          ? GetCountries
                              .getCountriesModel!.data!.countries![0].code
                          : code,
                      callback: () {
                        visible = !visible;
                        setState(() {});
                      },
                    ),
                  ),
                  Visibility(
                    visible: visible,
                    child: Container(
                      margin: EdgeInsets.only(top: 1.0.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
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
                        children: GetCountries
                            .getCountriesModel!.data!.countries!
                            .map(
                          (element) {
                            return DropdownMenuItem<Countries>(
                              value: element,
                              child: InkWell(
                                onTap: () {
                                  CurrentUser.countryId = '${element.id}';
                                  flag = element.flag;
                                  code = element.code;
                                  visible = false;
                                  log("--------> ${CurrentUser.countryId}");
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
                                      borderRadius: BorderRadius.circular(6),
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
              SizedBox(height: 5.0.h),
              Container(
                width: size.width,
                height: 6.5.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonColor),
                  onPressed: () {
                    forgetPasswordFun(phoneCtrl.text);
                  },
                  child: isLoading
                      ? SizedBox(
                          width: 25,
                          height: 25,
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.whiteColor)),
                        )
                      : CustomText(
                          text: 'التـالي',
                          fontSize: AppFonts.t3,
                          color: Colors.white,
                          fontweight: FontWeight.bold,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
