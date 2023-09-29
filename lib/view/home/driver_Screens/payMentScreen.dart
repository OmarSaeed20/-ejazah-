// import 'package:ejazah/Widgets/Custom_TextField.dart';
// import 'package:ejazah/Widgets/app_colors.dart';
// import 'package:ejazah/Widgets/app_fonts.dart';
// import 'package:ejazah/Widgets/customAppBar.dart';
// import 'package:ejazah/Widgets/customBtn.dart';
// import 'package:ejazah/Widgets/myNavigate.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../controller/auth/user_controller.dart';
// import 'payedDone.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   TextEditingController phoneCtn = TextEditingController();
//   TextEditingController emailCtn = TextEditingController();
//   TextEditingController fristNameCtn = TextEditingController();
//   TextEditingController familyCtn = TextEditingController();
//   TextEditingController notesCtn = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: AppColor.backGroundColor,
//         body: SafeArea(
//           child: Container(
//             margin: EdgeInsets.only(top: 5.h, left: 3.w, right: 3.w),
//             child: Column(children: [
//               CustomAppBar(pageTitle: ''),
//               Expanded(
//                   child: ListView(
//                 shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 children: [
//                   // Card(
//                   //     elevation: 3,
//                   //     margin: EdgeInsets.all(10),
//                   //     child: Container(
//                   //       padding: EdgeInsets.all(20),
//                   //       color: Colors.white70,
//                   //       child: Column(
//                   //         children: [
//                   //           Container(
//                   //             alignment: Alignment.topRight,
//                   //             child: Text(
//                   //               'طريقة الدفع',
//                   //               style: TextStyle(
//                   //                   fontSize: AppFonts.t4_2,
//                   //                   fontWeight: FontWeight.bold),
//                   //             ),
//                   //           ),
//                   //           SizedBox(
//                   //             height: 20,
//                   //           ),
//                   //           Column(
//                   //             crossAxisAlignment: CrossAxisAlignment.start,
//                   //             children: [
//                   //               Row(
//                   //                 mainAxisAlignment:
//                   //                     MainAxisAlignment.spaceBetween,
//                   //                 children: [
//                   //                   Row(
//                   //                     mainAxisAlignment: MainAxisAlignment.start,
//                   //                     children: [
//                   //                       CustomCheckBox(
//                   //                           value: true,
//                   //                           shouldShowBorder: false,
//                   //                           borderRadius: 15,
//                   //                           checkBoxSize: 14,
//                   //                           onChanged: (val) {
//                   //                             setState(() {
//                   //                               _value = val;
//                   //                             });
//                   //                           }),
//                   //                       Text(
//                   //                         'مدي',
//                   //                         style: TextStyle(
//                   //                             fontSize: AppFonts.t4_2,
//                   //                             color: Colors.black,
//                   //                             fontWeight: FontWeight.w500),
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                   Image.asset(
//                   //                     AppImages.a1,
//                   //                     width: 12.w,
//                   //                   )
//                   //                 ],
//                   //               ),
//                   //               Row(
//                   //                 mainAxisAlignment:
//                   //                     MainAxisAlignment.spaceBetween,
//                   //                 children: [
//                   //                   Row(
//                   //                     mainAxisAlignment: MainAxisAlignment.start,
//                   //                     children: [
//                   //                       CustomCheckBox(
//                   //                           value: _value,
//                   //                           borderRadius: 15,
//                   //                           checkBoxSize: 14,
//                   //                           onChanged: (val) {
//                   //                             setState(() {
//                   //                               _value = val;
//                   //                             });
//                   //                           }),
//                   //                       Text(
//                   //                         'فيزا',
//                   //                         style: TextStyle(
//                   //                             fontSize: AppFonts.t4_2,
//                   //                             color: Colors.black,
//                   //                             fontWeight: FontWeight.w500),
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                   Image.asset(
//                   //                     AppImages.a2,
//                   //                     width: 12.w,
//                   //                   )
//                   //                 ],
//                   //               ),
//                   //               Row(
//                   //                 mainAxisAlignment:
//                   //                     MainAxisAlignment.spaceBetween,
//                   //                 children: [
//                   //                   Row(
//                   //                     mainAxisAlignment: MainAxisAlignment.start,
//                   //                     children: [
//                   //                       CustomCheckBox(
//                   //                           value: _value,
//                   //                           borderRadius: 15,
//                   //                           checkBoxSize: 14,
//                   //                           onChanged: (val) {
//                   //                             setState(() {
//                   //                               _value = val;
//                   //                             });
//                   //                           }),
//                   //                       Text(
//                   //                         'ماستر كارد',
//                   //                         style: TextStyle(
//                   //                             fontSize: AppFonts.t4_2,
//                   //                             color: Colors.black,
//                   //                             fontWeight: FontWeight.w500),
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                   Image.asset(
//                   //                     AppImages.a3,
//                   //                     width: 12.w,
//                   //                   )
//                   //                 ],
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     )),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 2.h),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CustomTextFormField(
//                               width: 65.w, hintText: 'لديك كود خصم ؟ '),
//                           CustomButton(
//                               radius: 1.w,
//                               width: 25.w,
//                               height: 6.h,
//                               fontSize: AppFonts.t3,
//                               color: AppColor.whiteColor,
//                               textColor: AppColor.primaryColor,
//                               text: 'تفعيل')
//                         ]),
//                   ),
//                   Card(
//                     child: Padding(
//                       padding: EdgeInsets.all(3.w),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'عدد الساعات',
//                                 style: TextStyle(
//                                     fontSize: AppFonts.t4_2,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '3 ساعات',
//                                 style: TextStyle(
//                                     fontSize: AppFonts.t4_2,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'القيمة المضافة',
//                                 style: TextStyle(
//                                     fontSize: AppFonts.t4_2,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 ' 434 ',
//                                 style: TextStyle(
//                                     fontSize: AppFonts.t4_2,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'السعر الكلي',
//                                 style: TextStyle(
//                                     fontSize: AppFonts.t4_2,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.transparent),
//                               ),
//                               Text(
//                                 '434 ',
//                                 style: TextStyle(
//                                     fontSize: AppFonts.t4_2,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.transparent),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 2.h),
//                     child: CustomButton(
//                         radius: 2.w,
//                         text: 'دفع و تاكيد الحجز',
//                         onPressed: () => myNavigate(
//                             screen: PayedDoneScreen(), context: context)),
//                   )
//                 ],
//               ))
//             ]),
//           ),
//         ));
//   }
// }
