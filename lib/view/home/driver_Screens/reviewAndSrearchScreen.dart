import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazah/Widgets/Custom_TextField.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/app_images.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/customBtn.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/components/extentions.dart';
import 'package:ejazah/controller/get_payment_methods_controller.dart';
import 'package:ejazah/controller/my_wallet_controller.dart';
import 'package:ejazah/controller/reservation_details_controller.dart';
import 'package:ejazah/model/payment_methods_model.dart';
import 'package:ejazah/view/home/home_screen.dart';
import 'package:ejazah/view/home/my_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';
import 'package:sizer/sizer.dart';

import '../../../model/search_models/search_result_model.dart';
import '../../../utils/enums.dart';
import '../../payment/payment_screen.dart';

class ReviewAndSearchScreen extends StatefulWidget {
  final Ads ads;
  final String? hours_number;
  final String? city_id;
  final String? street_id;
  final String? address;
  final String? lat;
  final String? lng;
  ReviewAndSearchScreen({
    super.key,
    required this.ads,
    required this.hours_number,
    this.city_id,
    this.street_id,
    this.address,
    this.lat,
    this.lng,
  });
  @override
  State<ReviewAndSearchScreen> createState() => _ReviewAndSearchScreenState();
}

class _ReviewAndSearchScreenState extends State<ReviewAndSearchScreen> {
  TextEditingController phoneCtn = TextEditingController();
  TextEditingController emailCtn = TextEditingController();
  TextEditingController fristNameCtn = TextEditingController();
  TextEditingController familyCtn = TextEditingController();
  TextEditingController notesCtn = TextEditingController();
  TextEditingController desController = TextEditingController();
  String _selectedType = "online";
  RequestState requestState = RequestState.waiting;
  RequestState requestStatePayment = RequestState.waiting;
  RequestState requestStateCodeCoupon = RequestState.waiting;

  bool isWallet = false;
  late final int len;
  List<PaymentMethods>? payment = [];
  int totalWallet = 0;
  int final_total = 0;
  int Difference = 0;

  @override
  void initState() {
    // final_total Wallet
    GetWalletController.getWallet().then((res) {
      if (res) {
        totalWallet = GetWalletController.getWalletModel!.data!.total!;
      }
    });

    // Payment Methods
    requestStatePayment = RequestState.loading;
    GetPaymentMethods.getPaymentMethodsFunction().then((value) {
      if (value) {
        len = GetPaymentMethods.getPaymentMethods!.data!.length;
        payment = GetPaymentMethods.getPaymentMethods!.data;
        requestStatePayment = RequestState.success;
      } else {
        requestStatePayment = RequestState.error;
      }
      setState(() {});
    });
    final_total = ((double.parse(widget.ads.price ?? '0.0') *
                double.parse(widget.hours_number ?? '0.0')) *
            double.parse(widget.ads.passengers ?? '0.0'))
        .toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*   log("---> ${widget.ads.id}");
    log("---> ${widget.ads.from}");
    log("---> ${widget.ads.to}");
    log("---> ${widget.ads.passengers}");
    log("---> ${widget.ads.additionValue}");
    log("review and search ---> ${widget.hours_number}"); */
    log("hours_number ---> ${widget.hours_number}");
    log("city_id ---> ${widget.city_id}");
    log("street_id ---> ${widget.street_id}");
    log("address ---> ${widget.address}");
    log("lat ---> ${widget.lat}");
    log("lng ---> ${widget.lng}");

    int total_price = ((double.parse(widget.ads.price ?? '0.0') *
                double.parse(widget.hours_number ?? '0.0')) *
            double.parse(widget.ads.passengers ?? '0.0'))
        .toInt();

    log("total_price ----> ${total_price}");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 5.h, left: 3.w, right: 3.w),
          child: Column(children: [
            CustomAppBar(pageTitle: 'المراجعة و البحث'),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                orderDetailsWidget(
                  carType: '${widget.ads.name} ${widget.ads.moodle}',
                  driverImage: widget.ads.guide_image,
                  rating: '${widget.ads.rate}',
                  driverName: widget.ads.driverName == 'null'
                      ? '${widget.ads.ads_user_id}'
                      : '${widget.ads.driverName}',
                  from: '${widget.ads.city}',
                ),
                tawasleWidget(
                  familyName: familyCtn,
                  fristName: fristNameCtn,
                  phone: phoneCtn,
                ),
                infoWidget(data: widget.ads.terms),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                      text: 'إضافة ملاحظة للسائق',
                      fontSize: AppFonts.t3,
                      fontweight: FontWeight.w600),
                ),
                SizedBox(
                  height: 1.h,
                ),
                customContainerTextFormField(
                  TFF: customTextFormField(
                    context: context,
                    controller: desController,
                    hintText: 'اكتب ملاحظتك هنا',
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Is Required".tr),
                    ]),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "استخدم رصيد المحفظة",
                          fontSize: AppFonts.t3,
                          fontweight: FontWeight.w800,
                        ),
                        AbsorbPointer(
                          absorbing: isWallet,
                          child: Switch(
                            value: isWallet,
                            onChanged: (_) async {
                              if (totalWallet > 0 &&
                                  total_price >= totalWallet) {
                                final_total =
                                    (total_price - totalWallet).toInt();
                                Difference =
                                    (total_price - final_total).toInt();
                                log("final_total(1) ----> $final_total");
                                log("Difference(1) ----> $Difference");

                                setState(() {
                                  isWallet = true;
                                });
                              } else if (totalWallet > 0 &&
                                  totalWallet >= total_price) {
                                Difference = (totalWallet +
                                            total_price -
                                            totalWallet)
                                        .toInt() +
                                    int.parse(widget.ads.additionValue ?? '0');

                                log("final_total(2) ----> $final_total");
                                log("Difference(2) ----> $Difference");

                                setState(() {
                                  isWallet = true;
                                });
                                setState(
                                    () => requestState = RequestState.loading);
                                final res =
                                    await ReservationController.addOrder(
                                  count: widget.hours_number.toString(),
                                  house_id: widget.ads.id.toString(),
                                  from: widget.ads.from!,
                                  to: widget.ads.to!,
                                  passengers: widget.ads.passengers,
                                  payment_type: "wallet",
                                  coupon: '0',
                                  city_id: widget.city_id,
                                  street_id: widget.street_id,
                                  address: widget.address,
                                  lat: widget.lat,
                                  lng: widget.lng,
                                );
                                setState(
                                  () => requestState = res
                                      ? RequestState.success
                                      : RequestState.error,
                                );
                                if (requestState == RequestState.error) {
                                  myNavigate(
                                    screen: MyWalletScreen(),
                                    context: context,
                                  );
                                  setState(() {
                                    isWallet = false;
                                  });
                                }
                                if (requestState == RequestState.success) {
                                  await ReservationController.walletPayment(
                                    price: '$Difference',
                                  );
                                  myNavigate(
                                    screen: HomeScreen(),
                                    context: context,
                                    withBackButton: false,
                                  );
                                  setState(() {
                                    isWallet = false;
                                  });
                                }
                              } else if (totalWallet <= 0) {
                                myNavigate(
                                  screen: MyWalletScreen(),
                                  context: context,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Card(
                  elevation: 3,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      padding: EdgeInsets.all(12),
                      color: Colors.white70,
                      alignment: Alignment.topRight,
                      child: (requestStatePayment == RequestState.loading)
                          ? Center(child: CircularProgressIndicator())
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  CustomText(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.w),
                                      text: 'طريقة الدفع',
                                      fontSize: AppFonts.t3,
                                      fontweight: FontWeight.bold),
                                  ...payment!.map((element) {
                                    return ListTile(
                                      title: Row(
                                        children: [
                                          ...element.image!
                                              .map(
                                                (image) => Image.network(
                                                  image,
                                                  height: 10.0.w,
                                                  width: 10.0.w,
                                                ),
                                              )
                                              .toList(),
                                          SizedBox(width: 2.5.w),
                                          CustomText(
                                            text: element.name,
                                            fontSize: AppFonts.t4_2,
                                          ),
                                        ],
                                      ),
                                      leading: Radio<String>(
                                        value: '${element.type}',
                                        activeColor: AppColor.primaryColor,
                                        groupValue: _selectedType,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedType = value!;
                                          });
                                          log("------> ${_selectedType}");
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ])),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Builder(builder: (context) {
                  if (requestState == RequestState.loading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  return CustomButton(
                    radius: 2.w,
                    text:
                        'احجز الان (${final_total + double.parse(widget.ads.additionValue ?? '0.0')}  )',
                    onPressed: () async {
                      final double total = final_total +
                          double.parse(widget.ads.additionValue ?? '0.0');
                      PaymentStatus? status;
                      if (_selectedType == "online")
                        status = await Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  PaymentScreen(
                                amount: total,
                                currency: 'SAR',
                                description:
                                    '${widget.ads.name}:${widget.ads.desc}',
                              ),
                              transitionsBuilder:
                                  (xontext, animation, animation2, child) =>
                                      FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                            ));
                      if (_selectedType != "online" ||
                          status == PaymentStatus.paid) {
                        setState(() => requestState = RequestState.loading);
                        final res = await ReservationController.addOrder(
                          count: widget.hours_number.toString(),
                          house_id: widget.ads.id.toString(),
                          from: widget.ads.from!,
                          to: widget.ads.to!,
                          passengers: widget.ads.passengers,
                          payment_type: _selectedType,
                          coupon: '0',
                          city_id: widget.city_id,
                          street_id: widget.street_id,
                          address: widget.address,
                          lat: widget.lat,
                          lng: widget.lng,
                        );
                        setState(
                          () => requestState =
                              res ? RequestState.success : RequestState.error,
                        );
                        if (requestState == RequestState.error) {
                          log("error when payment ---> ${RequestState.error}");
                        }
                        if (requestState == RequestState.success)
                          myNavigate(
                            screen: HomeScreen(),
                            context: context,
                            withBackButton: false,
                          );
                      }
                      if (Difference > 0) {
                        await ReservationController.walletPayment(
                          price: '$Difference',
                        );
                      }
                    },
                    /*  onPressed: () async {
                        if (_selectedType == "applepay") {
                          toastShow(text: 'سيتم تفعيل خدمة الدفع بأبل باي قريبا');
                          return;
                        }
                        final double total = double.parse(total_price) *
                                double.parse(widget.ads.passengers ?? '0.0') +
                            double.parse(widget.ads.additionValue ?? '0.0');
                        PaymentStatus? status;
                        if (_selectedType == "online")
                          status = await Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) =>
                                    PaymentScreen(
                                  amount: total,
                                  currency: 'SAR',
                                  description:
                                      '${widget.ads.name}:${widget.ads.desc}',
                                ),
                                transitionsBuilder:
                                    (context, animation, animation2, child) =>
                                        FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                              ));
                        if (_selectedType != "online" ||
                            status == PaymentStatus.paid) {
                          setState(() => requestState = RequestState.loading);
                          final res = await ReservationController.addOrder(
                            count: widget.hours_number.toString(),
                            house_id: widget.ads.id.toString(),
                            from: widget.ads.from!,
                            to: widget.ads.to!,
                            payment_type: _selectedType,
                            coupon: '0',
                          );
                          setState(() => requestState =
                              res ? RequestState.success : RequestState.error);
                          if (requestState == RequestState.error) {
                            if (_selectedType == "wallet")
                              myNavigate(
                                  screen: MyWalletScreen(), context: context);
                          }
                          if (requestState == RequestState.success)
                            myNavigate(
                              screen: HomeScreen(),
                              context: context,
                              withBackButton: false,
                            );
                        }
                      }, */
                    //     {
                    //   myNavigate(
                    //     screen: PaymentScreen(
                    //       amount: double.parse(total_price) *
                    //               double.parse(widget.ads.passengers ?? '0.0') +
                    //           double.parse(widget.ads.additionValue ?? '0.0'),
                    //       currency: 'SAR',
                    //       description: '${widget.ads.name}:${widget.ads.desc}',
                    //     ),
                    //     context: context,
                    //   );
                    // },
                  );
                }),
              ],
            ))
          ]),
        ),
      ),
    );
  }

  Widget customContainerTextFormField({
    required Widget TFF,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      alignment: Alignment.center,
      width: context.getWidth,
      decoration: BoxDecoration(
        color: AppColor.backGroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 1.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: TFF,
    );
  }
}

Widget orderDetailsWidget(
    {from, to, driverName, rating, carType, driverImage}) {
  return Container(
    margin: EdgeInsets.only(bottom: 2.w),
    padding: EdgeInsets.all(2.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.w),
      color: AppColor.whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          offset: const Offset(0, 3.0),
          blurRadius: 5.0,
        ),
      ],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(
          padding: EdgeInsets.symmetric(vertical: 2.w),
          text: 'تفاصيل الحجز',
          fontSize: AppFonts.t2,
          fontweight: FontWeight.bold),
      CustomText(
        fontSize: AppFonts.t3,
        text: from,
      ),
      SizedBox(height: 3.w),
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.w),
            child: CachedNetworkImage(
              imageUrl: driverImage,
              width: 10.w,
              height: 10.w,
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                      text: "السائق " + driverName,
                      fontweight: FontWeight.bold,
                      fontSize: AppFonts.t3),
                  SizedBox(
                    width: 3.w,
                  ),
                  Image.asset(
                    AppImages.starIc,
                    width: 3.w,
                  ),
                  CustomText(
                      text: ' ($rating) ',
                      color: AppColor.orangeColor,
                      fontSize: AppFonts.t4_2)
                ],
              ),
              CustomText(
                padding: EdgeInsets.symmetric(vertical: 2.w),
                text: carType,
                fontSize: AppFonts.t3,
              ),
            ],
          )
        ],
      )
    ]),
  );
}

Widget tawasleWidget({fristName, familyName, phone}) {
  return Container(
    margin: EdgeInsets.only(bottom: 2.w),
    padding: EdgeInsets.all(2.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.w),
      color: AppColor.whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          offset: const Offset(0, 3.0),
          blurRadius: 5.0,
        ),
      ],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(
          padding: EdgeInsets.symmetric(vertical: 2.w),
          text: 'بيبانات التواصل ( مطلوبة )',
          fontSize: AppFonts.t2,
          fontweight: FontWeight.bold),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextFormField(
              width: 40.w, hintText: 'الاسم الاول', controller: fristName),
          CustomTextFormField(
              width: 40.w, hintText: 'اسم العائلة', controller: familyName)
        ],
      ),
      CustomTextFormField(hintText: 'رقم الهاتف', controller: phone)
    ]),
  );
}

Widget NotesWidget({notes}) {
  return Container(
    alignment: Alignment.topRight,
    margin: EdgeInsets.only(bottom: 2.w),
    padding: EdgeInsets.all(2.w),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          text: 'إضافة ملاحظه للسائق',
          fontSize: AppFonts.t2,
          fontweight: FontWeight.bold),
      Container(
        child: CustomTextFormField(
            hintText: 'اكتب ملاحظتك هنا', controller: notes),
      )
    ]),
  );
}

Widget infoWidget({List<Terms>? data}) {
  return Container(
      margin: EdgeInsets.only(bottom: 2.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 3.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              padding: EdgeInsets.symmetric(vertical: 2.w),
              text: 'من الجيد ان تعرف',
              fontSize: AppFonts.t2,
              fontweight: FontWeight.bold),
          ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
              itemCount: data!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                final item = data[index].term;
                return Padding(
                  padding: EdgeInsets.only(bottom: 2.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 1.5.w,
                        backgroundColor: AppColor.secondColor,
                      ),
                      Expanded(
                          child: CustomText(
                              padding: EdgeInsets.only(right: 2.w),
                              text: item,
                              fontSize: AppFonts.t4_2))
                    ],
                  ),
                );
              }),
        ],
      ));
}
