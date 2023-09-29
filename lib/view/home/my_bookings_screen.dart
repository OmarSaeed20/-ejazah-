import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_svg.dart';
import 'package:ejazah/Widgets/customBottomNavBar.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/view/home/on_refresh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      bottomNavigationBar: CustomBottomNavBar(
        navigationTabsIndex: 1,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: size.height * 0.025,
            bottom: size.height * 0.02,
            left: size.height * 0.015,
            right: size.height * 0.015,
          ),
          alignment: Alignment.center,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'حجوزاتي',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: AppFonts.t1),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: size.width * 0.75,
                  height: 7.h,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 245, 245),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 2.0),
                          blurRadius: 6.0,
                        )
                      ]),
                  child: TextFormField(
                    // controller: searchController,
                    enableInteractiveSelection: true,
                    cursorHeight: 25,
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        'assets/svg/search-normal.svg',
                        width: 5.w,
                        height: 5.h,
                      ),
                      hintText: 'ابحث عن المدينة',
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  width: 15.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 2.0),
                          blurRadius: 6.0,
                        )
                      ]),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      AppSvgImages.calendarIc,
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  myNavigate(screen: OnRefreshScreen(), context: context);
                },
                child: SvgPicture.asset(
                  AppSvgImages.noBookingIc,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'لم تقم بأي حجوزات حتي الان من فضلك تصفح \n اقسام السكن وقم باختيار السكن \n المناسب لك',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: AppFonts.t3),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              width: size.width,
              height: 7.h,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondColor),
                  onPressed: () {
                    myNavigate(screen: OnRefreshScreen(), context: context);
                  },
                  child: Text(
                    'ريفريش',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: AppFonts.t3,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
