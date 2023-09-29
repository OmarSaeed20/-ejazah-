import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/components/components.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ShareAndWinScreen extends StatefulWidget {
  @override
  _ShareAndWinScreenState createState() => _ShareAndWinScreenState();
}

class _ShareAndWinScreenState extends State<ShareAndWinScreen> {
  @override
  void initState() {
    super.initState();
  }

  String shareLink = 'https://www.freepik';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: size.height * 0.04,
                        bottom: size.height * 0.05,
                        left: size.height * 0.01,
                        right: size.height * 0.01,
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/group45871.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                      constraints:
                          BoxConstraints.expand(height: size.height * .31),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomAppBar(pageTitle: ''),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'شارك واكسب'.tr,
                                    style: TextStyle(
                                        fontSize: AppFonts.t1,
                                        color: Color.fromRGBO(
                                          234,
                                          145,
                                          78,
                                          1,
                                        ),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                      'شارك التطبيق مع اصدقائك عن طريق لينك \n خاص بيك واحصل علي كوبونات خصم',
                                      style: TextStyle(
                                          fontSize: AppFonts.t4_2,
                                          color: Colors.white))
                                ],
                              ),
                              Container(
                                child: SvgPicture.asset(
                                  'assets/svg/group36771.svg',
                                  height: 16.h,
                                  width: 16.w,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.02,
                        right: size.width * 0.02,
                        bottom: size.height * 0.01,
                      ),
                      margin: EdgeInsets.only(top: 26.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            // height: size.height * .67,
                            width: size.width,
                            child: getCardContainer(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCardContainer() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        top: size.height * 0.04,
        bottom: size.height * 0.02,
        right: size.width * 0.03,
        left: size.width * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          new BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'رشح التطبيق الي اصدقائك وأكسب نقاط يمكنك استخدامها في الحصول علي أكواد خصم'),
          SizedBox(
            height: 2.5.h,
          ),
          Text(
            'كيفية الحصول علي اكواد الخصم ؟؟',
            style: TextStyle(
                fontSize: AppFonts.t3,
                color: Color.fromRGBO(234, 145, 78, 1),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          ExpandableText(
            'ارسل الرابط الخاص بك الي أصدقائك وعند استخدامهم التطبيق عن طريق الرابط الخاص بك ستحصل علي 20 نقطه عن كل شخص',
            maxLines: 3,
            expandText: '',
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Text(
              ' في نظام الدعوات لا يسمح بأرسال أكثر من دعوة لنفس  الشخص أكثر من مره , يرجي تجنب ذلك لتفادي إيقاف  الحساب من النظام تلقائياً , $text '),
          SizedBox(
            height: 2.5.h,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              'الرابط الخاص بك',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: AppFonts.t3,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 72.5.w,
                height: 7.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(210, 211, 212, 0.392)),
                child: Text(
                  shareLink,
                  style: TextStyle(
                    fontSize: AppFonts.t4_2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  width: 15.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(234, 145, 78, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: shareLink));
                      Fluttertoast.showToast(
                          msg: 'تم النسخ', toastLength: Toast.LENGTH_SHORT);
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/content_copy_black_24dp.svg',
                      width: 40,
                      height: 40,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width,
                height: 7.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(210, 211, 212, 0.392)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' النقاط المكتبسة : ',
                      style: TextStyle(
                        fontSize: AppFonts.t4_2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '80 نقطة',
                      style: TextStyle(
                        color: Color.fromRGBO(234, 145, 78, 1),
                        fontSize: AppFonts.t4_2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width,
                height: 7.h,
                child: ElevatedButton(
                  onPressed: () {
                    toastShow(text: 'تحت الإنشاء!');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'احصل علي النقاط',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      SvgPicture.asset(
                        'assets/svg/arrow_back_black_24dp (2).svg',
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(68, 151, 173, 1)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String text = 'تطبق الشروط والاحكام';
}
