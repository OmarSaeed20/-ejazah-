import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/customBtn.dart';
import 'package:ejazah/view/home/rate_owner.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/myNavigate.dart';

class PayedDoneScreen extends StatefulWidget {
  const PayedDoneScreen({super.key});

  @override
  State<PayedDoneScreen> createState() => _PayedDoneScreenState();
}

class _PayedDoneScreenState extends State<PayedDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: Container(
            height: 100.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 5.h, left: 3.w, right: 3.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    AppImages.scussesIc,
                    width: 75.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: CustomButton(
                        radius: 2.w,
                        text: 'حسنا',
                        onPressed: () => myNavigate(
                            screen: RateOwnerScreen(ads_id: ''),
                            context: context)),
                  )
                ]),
          ),
        ));
  }
}
