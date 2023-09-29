import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/constants/api_paths.dart';
import 'package:ejazah/database/local/cache_helper.dart';
import 'package:ejazah/widgets/app_fonts.dart';
import 'package:ejazah/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController subject = TextEditingController();
  bool processing = false;
  Future<bool> contactUs() async {
    setState(() {
      processing = true;
    });

    var url = ApiPath.baseurl + ApiPath.contact;
    var data = {
      "name": name.text,
      "email": email.text,
      "phone": "0${phone.text}",
      "message": message.text,
      "subject": subject.text,
    };
    try {
      var resbody = await Dio().post(
        url,
        data: data,
      );
      setState(() {
        processing = false;
      });

      log(resbody.toString());
      if (resbody.data.isNotEmpty) {
        if (resbody.data['status'] == true) {
          toastShow(text: resbody.data['message'], state: ToastStates.black);
        } else {
          toastShow(text: resbody.data['message'], state: ToastStates.black);
          return false;
        }

        return true;
      }
    } catch (e) {
      log(e.toString());
      setState(() {
        processing = false;
      });
    }
    return false;
  }

  bool visible = false;
  String? flag;
  String? code;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.05,
            bottom: size.height * 0.05,
            left: size.height * 0.02,
            right: size.height * 0.02,
          ),
          child: Column(
            children: [
              CustomAppBar(pageTitle: 'تواصــل معنا'),
              SizedBox(height: 6.h),
              customContainerTextFormField(
                TFF: customTextFormField(
                  context: context,
                  controller: name,
                  hintText: "اسـم المستخدم",
                  keyboardType: TextInputType.name,
                  validator: (val) {
                    return (val!.isEmpty) ? "هذا الحقـل مطلوب" : null;
                  },
                ),
              ),
              SizedBox(height: 2.h),
              customContainerTextFormField(
                TFF: customTextFormField(
                  context: context,
                  controller: email,
                  hintText: "البريد الالكتروني",
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    return (val!.isEmpty) ? "هذا الحقـل مطلوب" : null;
                  },
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                width: size.width,
                height: 6.5.h,
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
                child: customTextFormField(
                  context: context,
                  controller: phone,
                  validator: (val) {
                    return (val!.isEmpty) ? "هذا الحقـل مطلوب" : null;
                  },
                  hintText: 'رقم الهاتـف',
                  keyboardType: TextInputType.phone,
                  isCountry: true,
                  flag: flag == null ? CacheHelper.getData(key: "flag") : flag,
                  code: code == null ? CacheHelper.getData(key: "code") : code,
                  callback: () {
                    visible = !visible;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 2.h),
              customContainerTextFormField(
                TFF: customTextFormField(
                  context: context,
                  controller: message,
                  hintText: "اترك رسالـتك هنا",
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    return (val!.isEmpty) ? "هذا الحقـل مطلوب" : null;
                  },
                ),
              ),
              SizedBox(height: 2.h),
              customContainerTextFormField(
                TFF: customTextFormField(
                  context: context,
                  controller: subject,
                  hintText: "الموضوع",
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    return (val!.isEmpty) ? "هذا الحقـل مطلوب" : null;
                  },
                ),
              ),
              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          top: size.height * 0.025,
          bottom: size.height * 0.025,
          left: size.height * 0.02,
          right: size.height * 0.02,
        ),
        width: size.width,
        height: 6.5.h,
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColor.buttonColor),
          onPressed: () async {
            if (name.text.isEmpty) {
              toastShow(
                  text: "الرجاء إدخال اسـم المستخدم", state: ToastStates.black);
            } else if (email.text.isEmpty) {
              toastShow(
                  text: "الرجاء إدخال البريد الالكتروني",
                  state: ToastStates.black);
            } else if (phone.text.isEmpty) {
              toastShow(
                  text: "الرجاء إدخال رقم الهاتف", state: ToastStates.black);
            } else if (phone.text.startsWith("0")) {
              toastShow(
                  text: "الرجاء إدخال رقم الهاتف صحـيح",
                  state: ToastStates.black);
            } else if (message.text.isEmpty) {
              toastShow(text: "الرجاء إدخال رسالـتك", state: ToastStates.black);
            } else if (subject.text.isEmpty) {
              toastShow(
                  text: "الرجاء إدخال الموضـوع", state: ToastStates.black);
            } else {
              await contactUs();
            }
          },
          child: Builder(builder: (context) {
            if (processing)
              return SizedBox(
                height: 25,
                width: 25,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            return CustomText(
              text: "إرسال",
              fontSize: AppFonts.t3,
              color: Colors.white,
              fontweight: FontWeight.bold,
            );
          }),
        ),
      ),
    );
  }

  Widget customContainerTextFormField({required Widget TFF}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.center,
      width: context.getWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 1.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: TFF,
    );
  }
}
