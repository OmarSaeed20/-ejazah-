// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/customBottomNavBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/controller/auth/user_controller.dart';
import 'package:ejazah/database/local/cache_helper.dart';
import 'package:ejazah/view/auth/login_screen.dart';
import 'package:ejazah/view/auth/policy_privacy_screen.dart';
import 'package:ejazah/view/auth/terms_and_conditions_screen.dart';
import 'package:ejazah/view/home/ask_me_screen.dart';
import 'package:ejazah/view/home/my_adds_screen.dart';
import 'package:ejazah/view/home/my_favourite_screen.dart';
import 'package:ejazah/view/home/my_rates_screen.dart';
import 'package:ejazah/view/home/my_wallet_screen.dart';
import 'package:ejazah/view/home/notifications_screen.dart';
import 'package:ejazah/view/home/personal_info_screen.dart';
import 'package:ejazah/view/home/share_and_win_screen.dart';
import 'package:ejazah/view/home/wheel_spin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../controller/home_controller/home_controller.dart';

class ShowMoreScreen extends StatefulWidget {
  const ShowMoreScreen({super.key});

  @override
  State<ShowMoreScreen> createState() => _ShowMoreScreenState();
}

class _ShowMoreScreenState extends State<ShowMoreScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      bottomNavigationBar: CustomBottomNavBar(
        navigationTabsIndex: 4,
      ),
      body: Stack(
        children: <Widget>[
          (Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  bottom: size.height * 0.05,
                                  left: size.height * 0.02,
                                  right: size.height * 0.02,
                                ),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/group45871.png",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                constraints: BoxConstraints.expand(
                                    height: size.height * .26),
                                child: Container(
                                  margin: EdgeInsets.only(top: 5.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(99),
                                                        color: Colors.white),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          CurrentUser.image ??
                                                              '',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                CurrentUser.name ?? 'الاسم',
                                                style: TextStyle(
                                                    fontSize: AppFonts.t2,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black26,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      myNavigate(
                                                          screen:
                                                              NotificationScreen(),
                                                          context: context);
                                                    },
                                                    child: Badge(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .topStart,
                                                      backgroundColor: HomeController
                                                                  .getHomeModel
                                                                  ?.data
                                                                  ?.countNotification
                                                                  .toString() ==
                                                              '0'
                                                          ? Colors.transparent
                                                          : Color(0xffE24255),
                                                      label: HomeController
                                                                  .getHomeModel
                                                                  ?.data
                                                                  ?.countNotification
                                                                  .toString() ==
                                                              '0'
                                                          ? null
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(HomeController
                                                                      .getHomeModel
                                                                      ?.data
                                                                      ?.countNotification
                                                                      .toString() ??
                                                                  '0'),
                                                            ),
                                                      textStyle: TextStyle(
                                                          fontSize: 10),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/svg/bell.svg',
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.h),
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: getCardContainer(),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    myNavigate(
                                        screen: PersonalInfoScreen(),
                                        context: context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'الملف الشخصي',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/profile-linear.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    myNavigate(
                                        screen: MyAdsScreen(
                                          selectedIndex: 0,
                                        ),
                                        context: context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'اعلاناتي',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/share.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    myNavigate(
                                        screen: MyFavouriteScreen(),
                                        context: context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'المفضلة',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/vuesax-linear-heart.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    myNavigate(
                                        screen: AskMeScreen(),
                                        context: context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'الاسئلة المتكررة',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/01 align center.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    myNavigate(
                                        screen: MyRattingScreen(),
                                        context: context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'تقيماتي',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/like.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    myNavigate(
                                        screen: ShareAndWinScreen(),
                                        context: context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'ادع اصدقائك',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/share.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    myNavigate(
                                        screen: PrivacyAndPolicy(),
                                        context: context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'شروط الاستخدام',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/messages-linear.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    myNavigate(
                                        screen: TermsAndConditionsScreen(),
                                        context: context);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'سياسة الخصوصية',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/shield-tick.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          icon: Image(
                                            image: AssetImage(
                                              AppImages.logOutIc,
                                            ),
                                            height: 18.h,
                                            width: 15.w,
                                          ),
                                          elevation: 4,
                                          shadowColor: Colors.grey,
                                          title: Text(
                                            'هل انت متأكد من تسجيل الخروج؟',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: AppFonts.t2,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: size.width * 0.33,
                                                    height: 7.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor:
                                                                AppColor
                                                                    .secondColor,
                                                            alignment: Alignment
                                                                .center),
                                                        onPressed: () async {
                                                          _auth.signOut();
                                                          HomeController
                                                                  .getHomeModel =
                                                              null;
                                                          HomeController
                                                                  .getAdsByCityModel =
                                                              null;
                                                          await CacheHelper
                                                              .clearData(
                                                                  key:
                                                                      'isUserDateSaved');
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                            context,
                                                            PageRouteBuilder(
                                                              pageBuilder: (c,
                                                                      a1, a2) =>
                                                                  LoginScreen(),
                                                              transitionDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                            ),
                                                            (route) => false,
                                                          );
                                                        },
                                                        child: Text(
                                                          'تسجيل الخروج',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  AppFonts.t2,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Container(
                                                    width: size.width * 0.33,
                                                    height: 7.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey.shade300,
                                                          blurRadius: 3.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    243,
                                                                    243,
                                                                    243),
                                                            alignment: Alignment
                                                                .center),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'لا',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  AppFonts.t2,
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'تسجيل خروج',
                                      style: TextStyle(
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Image.asset(
                                      'assets/images/login.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                color: Color(0xffEA914E),
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          icon: Image(
                                            image: AssetImage(
                                              AppImages.logOutIc,
                                            ),
                                            height: 18.h,
                                            width: 15.w,
                                          ),
                                          elevation: 4,
                                          shadowColor: Colors.grey,
                                          title: Text(
                                            'هل انت متأكد من حذف الحساب؟',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: AppFonts.t2,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: size.width * 0.33,
                                                    height: 7.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor:
                                                                AppColor
                                                                    .secondColor,
                                                            alignment: Alignment
                                                                .center),
                                                        onPressed: () async {
                                                          deleteAcc();
                                                          _auth.signOut();
                                                          HomeController
                                                                  .getHomeModel =
                                                              null;
                                                          HomeController
                                                                  .getAdsByCityModel =
                                                              null;
                                                          await CacheHelper
                                                              .clearData(
                                                                  key:
                                                                      'isUserDateSaved');
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                            context,
                                                            PageRouteBuilder(
                                                              pageBuilder: (c,
                                                                      a1, a2) =>
                                                                  LoginScreen(),
                                                              transitionDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                            ),
                                                            (route) => false,
                                                          );
                                                        },
                                                        child: Text(
                                                          'حذف الحساب',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  AppFonts.t2,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Container(
                                                    width: size.width * 0.33,
                                                    height: 7.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey.shade300,
                                                          blurRadius: 3.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    243,
                                                                    243,
                                                                    243),
                                                            alignment: Alignment
                                                                .center),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'لا',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  AppFonts.t2,
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      'حذف الحساب',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppFonts.t3,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.delete,
                                      color: AppColor.whiteColor,
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow-right-linear.png',
                                      color: Colors.white,
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget getCardContainer() {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            myNavigate(screen: MyWalletScreen(), context: context);
          },
          child: Container(
            margin: EdgeInsets.only(
              right: 5,
              left: 5,
              bottom: 30,
            ),
            height: size.height * .13,
            width: size.width * .3,
            padding: EdgeInsets.only(top: 2.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/empty-wallet-linear.svg',
                  height: 4.h,
                  width: 4.w,
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Text(
                  'محفظتي',
                  style: TextStyle(
                      fontSize: AppFonts.t4, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            myNavigate(screen: WheelSpinScreen(), context: context);
          },
          child: Container(
            margin: EdgeInsets.only(
              right: 5,
              left: 5,
              bottom: 30,
            ),
            height: size.height * .13,
            width: size.width * .3,
            padding: EdgeInsets.only(top: 2.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/chrome-linear.svg',
                  height: 4.h,
                  width: 4.w,
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Text(
                  'عجلة الحظ',
                  style: TextStyle(
                      fontSize: AppFonts.t4, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            myNavigate(screen: ShareAndWinScreen(), context: context);
          },
          child: Container(
            margin: EdgeInsets.only(
              right: 5,
              left: 5,
              bottom: 30,
            ),
            padding: EdgeInsets.only(top: 2.h),
            height: size.height * .13,
            width: size.width * .3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/share-linear.svg',
                  height: 4.h,
                  width: 4.w,
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Text(
                  'شارك واكسب',
                  style: TextStyle(
                      fontSize: AppFonts.t4, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  deleteAcc() async {
    // ignore: unused_local_variable
    var resbody = await Dio().post('https://visooft-code.com/api/deleteAccount',
        options: Options(headers: {'Authorization': CurrentUser.token}));
  }
}
