import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/auth/update_profile_controller.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/home/home_screen.dart';
import 'package:ejazah/view/home/update_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../database/local/cache_helper.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  XFile? img;
  TextEditingController updatedUsernameController =
      TextEditingController(text: CurrentUser.name);
  TextEditingController updatedEmailController =
      TextEditingController(text: CurrentUser.email);

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
                bottom: size.height * 0.03,
                left: size.height * 0.02,
                right: size.height * 0.02,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAppBar(pageTitle: 'معلوماتي الشخصية'),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () async {
                        img = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        setState(() {
                          print(img?.path);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: img == null
                                ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: CurrentUser.image ??
                                        'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80',
                                  )
                                : Image.file(File(img?.path ?? ''))),
                      ),
                    ),
                    // SizedBox(height: 15,),

                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.topRight,
                      child: Text(
                        'اسم المستخدم',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFonts.t4_2),
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
                        controller: updatedUsernameController,
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.name,
                        cursorHeight: 30,
                        cursorWidth: 2,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            hintText: CurrentUser.name ?? 'null',
                            hintStyle: TextStyle(
                                color: Colors.black45, fontSize: AppFonts.t4_2),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.topRight,
                      child: Text(
                        'البريد الاكتروني',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFonts.t4_2),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
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
                      child: TextFormField(
                        controller: updatedEmailController,
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.emailAddress,
                        cursorHeight: 25,
                        cursorWidth: 2,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            hintText: CurrentUser.email ?? 'null',
                            hintStyle: TextStyle(
                                color: Colors.black45, fontSize: AppFonts.t4_2),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.topRight,
                      child: Text(
                        'كلمة المرور',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFonts.t4_2),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: size.width,
                      height: 7.5.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(left: 10, top: 2)),
                          onPressed: () {
                            myNavigate(
                                screen: UpdatePasswordScreen(),
                                context: context);
                          },
                          child: ListTile(
                            title: Text(
                              'تغير كلمة المرور',
                              style: TextStyle(fontSize: AppFonts.t4),
                            ),
                            trailing: Image.asset(
                              'assets/images/arrow-right-linear.png',
                              width: 30,
                              height: 30,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      width: size.width,
                      height: 7.h,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttonColor),
                          onPressed: () async {
                            requestState = RequestState.loading;
                            setState(() {});
                            final res = await UpdateProfileController.update(
                                updatedUsernameController.text,
                                updatedEmailController.text,
                                img);
                            if (res) {
                              CurrentUser.name = updatedUsernameController.text;
                              CurrentUser.email = updatedEmailController.text;
                              await CacheHelper.saveData(
                                  key: 'name', value: CurrentUser.name);
                              await CacheHelper.saveData(
                                  key: 'email', value: CurrentUser.email);
                              requestState = RequestState.success;
                              myNavigate(
                                  screen: HomeScreen(), context: context);
                            } else {
                              requestState = RequestState.error;
                            }
                            setState(() {});
                          },
                          child: Builder(builder: (context) {
                            if (requestState == RequestState.loading)
                              return CircularProgressIndicator(
                                color: Colors.white,
                              );
                            return Text(
                              'تعديل',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppFonts.t2,
                                  fontWeight: FontWeight.bold),
                            );
                          })),
                    ),
                  ])),
        ));
  }
}
