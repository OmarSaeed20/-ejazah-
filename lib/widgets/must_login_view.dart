import 'package:ejazah/Widgets/customBtn.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'MyListEmpety.dart';

class MustLoginView extends StatelessWidget {
  const MustLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        myListEmpety('يجب عليك تسجيل الدخول اولا '),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
            text: 'تسجيل الدخول',
            onPressed: () {
              // myNavigate(
              //     screen: LoginScreen(),
              //     context: context,
              //     withBackButton: false);
            })
      ]),
    );
  }
}
