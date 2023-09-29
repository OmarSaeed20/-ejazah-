import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/home/home_screen.dart';
import 'package:ejazah/view/home/rate_owner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SuccessReservationScreen extends StatefulWidget {
  final String ads_id;
  final bool? isAddTravel;
  const SuccessReservationScreen(
      {super.key, required this.ads_id, this.isAddTravel});

  @override
  State<SuccessReservationScreen> createState() =>
      _SuccessReservationScreenState();
}

class _SuccessReservationScreenState extends State<SuccessReservationScreen> {
  RequestState requestState = RequestState.waiting;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: size.height * 0.2,
              bottom: size.height * 0.05,
              left: size.height * 0.02,
              right: size.height * 0.02,
            ),
            child: Column(children: [
              SvgPicture.asset(
                'assets/svg/Ok-amico (1).svg',
                width: 190,
                height: 260,
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 2.h),
                child: CustomText(
                    text:
                        'تم إضافة اعلانك و سيتم مراجعتة من قبل الادارة للموافقة و العرض',
                    fontSize: AppFonts.t2,
                    color: AppColor.blackColor),
              ),
              SizedBox(
                height: 12.h,
              ),
              Builder(builder: (context) {
                if (requestState == RequestState.loading)
                  Center(child: CircularProgressIndicator());
                if (requestState == RequestState.error)
                  Text(
                    'يرجي التأكد من اتصالك بالانترنت',
                    style: context.textTheme.titleLarge!.copyWith(
                      color: Colors.red,
                    ),
                  );

                return Container(
                  width: size.width,
                  height: 7.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor),
                      onPressed: () {
                        if (widget.isAddTravel != null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => HomeScreen(),
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(opacity: anim, child: child),
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                            ),
                            (route) => false,
                          );
                        } else {
                          myNavigate(
                              screen: RateOwnerScreen(
                                ads_id: widget.ads_id,
                              ),
                              context: context);
                        }
                      },
                      child: Text(
                        'حسنا',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppFonts.t2,
                            fontWeight: FontWeight.bold),
                      )),
                );
              }),
            ])));
  }
}
