import 'dart:developer';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/Widgets/myNavigate.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/controller/get_payment_methods_controller.dart';
import 'package:ejazah/controller/my_wallet_controller.dart';
import 'package:ejazah/controller/reservation_details_controller.dart';
import 'package:ejazah/model/payment_methods_model.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/home/home_screen.dart';
import 'package:ejazah/view/home/my_wallet_screen.dart';
import 'package:ejazah/view/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moyasar/moyasar.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/Custom_TextField.dart';
import '../../controller/check_code_controller.dart';
import '../../model/search_models/search_result_model.dart';

class ReservationdetailsScreen extends StatefulWidget {
  final Ads ads;
  final String from;
  final String to;
  final String payment_type;
  final int count;
  final double total;

  const ReservationdetailsScreen({
    super.key,
    required this.ads,
    required this.to,
    required this.from,
    required this.count,
    required this.total,
    required this.payment_type,
  });

  @override
  State<ReservationdetailsScreen> createState() =>
      _ReservationdetailsScreenState();
}

enum TypePayment { online, wallet, cash, applePay }

class _ReservationdetailsScreenState extends State<ReservationdetailsScreen> {
  RequestState requestState = RequestState.waiting;
  RequestState requestStatePayment = RequestState.waiting;
  RequestState requestStateCodeCoupon = RequestState.waiting;
  String _selectedType = "online";
  double? discount;
  TextEditingController codeController = TextEditingController();
  bool isWallet = false;
  late final int len;
  List<PaymentMethods>? payment = [];
  int totalWallet = 0;
  int Total = 0;
  int Difference = 0;

  CheckCode(String coupon) async {
    setState(() => requestStateCodeCoupon = RequestState.loading);
    final res = await CheckCodeController.checkCode(coupon);
    if (res) {
      if (CheckCodeController.discount != null)
        discount = CheckCodeController.discount! / 100;
      setState(() => requestStateCodeCoupon = RequestState.success);
    } else {
      setState(() => requestStateCodeCoupon = RequestState.error);
    }
  }

  @override
  void initState() {
    // Total Wallet
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
    // FINAL TOTAL
    Total = widget.total.toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("count ==============> ${widget.count}");
    log("count_days ==========> ${widget.ads.count_days}");

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: WillPopScope(
        onWillPop: () async {
          if (requestState == RequestState.loading) return false;
          return true;
        },
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: size.height * 0.025,
                  bottom: size.height * 0.20,
                  left: size.width * 0.015,
                  right: size.width * 0.015,
                ),
                child: Column(children: [
                  CustomAppBar(pageTitle: 'المراجعة و البحث'),
                  SizedBox(
                    height: 3.h,
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Container(
                        width: size.width,
                        padding: EdgeInsets.only(
                            left: 5.w, top: 3.5.h, right: 5.w, bottom: 3.5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.ads.name != 'null')
                              Text(
                                widget.ads.name!,
                                style: TextStyle(
                                  fontSize: AppFonts.t3,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            if (widget.ads.travel_name != 'null')
                              Text(
                                widget.ads.travel_name!,
                                style: TextStyle(
                                  fontSize: AppFonts.t3,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.ads.price} ${widget.ads.currency}',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  widget.ads.city ?? '',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'الإجمالي ${Total} ${widget.ads.currency} ',
                                  style: TextStyle(
                                      fontSize: AppFonts.t4_2,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Container()
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 1.h,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      color: Colors.white70,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              'تفاصيل الحجز',
                              style: TextStyle(
                                  fontSize: AppFonts.t3,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          if (widget.ads.categoryId != '8')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.ads.categoryId == '6'
                                    ? Text(
                                        'تاريخ بدء الفاعلية',
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'تاريخ الدخول',
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                widget.ads.categoryId == '6'
                                    ? Text(
                                        widget.ads.from ?? '',
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        widget.from,
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ],
                            ),
                          if (widget.ads.categoryId != '8')
                            SizedBox(height: 2.h),
                          if (widget.ads.categoryId != '8')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.ads.categoryId == '6'
                                    ? Text(
                                        'تاريخ إنتهاء الفاعلية',
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'تاريخ المغادرة',
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                widget.ads.categoryId == '6'
                                    ? Text(
                                        widget.ads.to ?? '',
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        widget.to,
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ],
                            ),
                          if (widget.ads.categoryId != '8')
                            SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.ads.categoryId == '6'
                                  ? Text(
                                      'عدد التذاكر المحجوزة',
                                      style: TextStyle(
                                        fontSize: AppFonts.t4_2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      widget.ads.categoryId == '8'
                                          ? 'عدد الايام'
                                          : 'عدد الليالي',
                                      style: TextStyle(
                                        fontSize: AppFonts.t4_2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              widget.ads.categoryId == '6'
                                  ? Text(
                                      widget.count == 1 || widget.count == 2
                                          ? '${widget.count} تذكرة'
                                          : '${widget.count} تذاكر',
                                      style: TextStyle(
                                        fontSize: AppFonts.t4_2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          widget.ads.count_days == '0'
                                              ? '${widget.count}'
                                              : '${widget.ads.count_days}',
                                          style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (widget.ads.categoryId == '8')
                                          Text(
                                            int.parse(widget.ads.count_days!) >
                                                    1
                                                ? " الايام"
                                                : " يوم",
                                            style: TextStyle(
                                              fontSize: AppFonts.t4_2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        if (widget.ads.categoryId != '8')
                                          Text(
                                            widget.count == 1
                                                ? " ليلة"
                                                : " ليالي",
                                            style: TextStyle(
                                              fontSize: AppFonts.t4_2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                      ],
                                    ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          if (widget.ads.categoryId == '6')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.ads.categoryId == '6'
                                    ? Text(
                                        'سعر التذكرة',
                                        style: TextStyle(
                                            fontSize: AppFonts.t4_2,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Container(),
                                widget.ads.categoryId == '6'
                                    ? Text(
                                        '${widget.ads.price!} ${widget.ads.currency!}',
                                        style: TextStyle(
                                          fontSize: AppFonts.t4_2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'القيمة المضافة',
                                style: TextStyle(
                                    fontSize: AppFonts.t4_2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'رسوم ${widget.ads.additionValue!} ${widget.ads.currency!}',
                                style: TextStyle(
                                    fontSize: AppFonts.t4_2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'السعر الكلي',
                                style: TextStyle(
                                  decoration: discount != null
                                      ? TextDecoration.lineThrough
                                      : null,
                                  fontSize: AppFonts.t3,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(68, 151, 173, 1),
                                ),
                              ),
                              Text(
                                '${widget.total + double.parse(widget.ads.additionValue ?? '0.0')} ${widget.ads.currency!}',
                                style: TextStyle(
                                  decoration: discount != null
                                      ? TextDecoration.lineThrough
                                      : null,
                                  fontSize: AppFonts.t3,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(68, 151, 173, 1),
                                ),
                              ),
                            ],
                          ),
                          if (Total < widget.total) SizedBox(height: 1.0.h),
                          if (Total < widget.total)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "السعـر المتبقي",
                                  style: TextStyle(
                                    decoration: discount != null
                                        ? TextDecoration.lineThrough
                                        : null,
                                    fontSize: AppFonts.t3,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade600,
                                  ),
                                ),
                                Text(
                                  '${Total + double.parse(widget.ads.additionValue ?? '0.0')} ${widget.ads.currency!}',
                                  style: TextStyle(
                                    decoration: discount != null
                                        ? TextDecoration.lineThrough
                                        : null,
                                    fontSize: AppFonts.t3,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade600,
                                  ),
                                ),
                              ],
                            ),
                          if (discount != null)
                            Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'قيمة الخصم',
                                      style: TextStyle(
                                          fontSize: AppFonts.t3,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(68, 151, 173, 1)),
                                    ),
                                    Builder(builder: (context) {
                                      return Text(
                                        '${discount! * 100}%',
                                        style: TextStyle(
                                            fontSize: AppFonts.t3,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                68, 151, 173, 1)),
                                      );
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'السعر الكلي بعد الخصم',
                                      style: TextStyle(
                                          fontSize: AppFonts.t3,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(68, 151, 173, 1)),
                                    ),
                                    Builder(builder: (context) {
                                      final double total = (Total +
                                          double.parse(
                                              widget.ads.additionValue ??
                                                  '0.0'));
                                      return Text(
                                        '${total - total * discount!} ${widget.ads.currency!}',
                                        style: TextStyle(
                                          fontSize: AppFonts.t3,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(68, 151, 173, 1),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Divider(
                    thickness: 0.3,
                    height: 2,
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        width: 65.w,
                        height: 6.5.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(210, 211, 212, 0.392)),
                        child: CustomTextFormField(
                          controller: codeController,
                          textSize: AppFonts.t2,
                          onChangedFun: () {
                            discount = null;
                            setState(() {});
                          },
                          contentPadding: EdgeInsets.only(right: 10, top: 5),
                          hintText: 'لديك كود خصم ؟',
                          width: 65.w,
                          radius: 2.w,
                          keyBoardType: TextInputType.text,
                        ),
                      ),
                      Container(
                          width: 100,
                          height: 6.0.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color.fromRGBO(68, 151, 173, 1))),
                          child: Builder(builder: (context) {
                            if (requestStateCodeCoupon == RequestState.loading)
                              return Center(child: CircularProgressIndicator());
                            return TextButton(
                                onPressed: () {
                                  if (requestStateCodeCoupon ==
                                      RequestState.loading) return;
                                  if (codeController.text.isNotEmpty)
                                    CheckCode(codeController.text);
                                },
                                child: Text('تفعيل'));
                          })),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Divider(
                    thickness: 0.30,
                    height: 2,
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  /*  Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        width: 65.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(210, 211, 212, 0.392)),
                        child: CustomTextFormField(
                          readOnly: true,
                          contentPadding: EdgeInsets.only(right: 10, top: 5),
                          hintText: "استخدم رصيد المحفظة",
                          width: 65.w,
                          radius: 2.0.w,
                        ),
                      ),
                      Container(
                          width: 100,
                          height: 6.5.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color.fromRGBO(68, 151, 173, 1))),
                          child: Builder(builder: (context) {
                            return TextButton(
                                onPressed: () async {}, child: Text('تفعيل'));
                          })),
                    ],
                  ),
                ),
                */
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
                                    widget.total >= totalWallet) {
                                  Total = (widget.total - totalWallet).toInt();
                                  Difference = (widget.total - Total).toInt();
                                  log("Total(1) ----> $Total");
                                  log("Difference(1) ----> $Difference");

                                  setState(() {
                                    isWallet = true;
                                  });
                                } else if (totalWallet > 0 &&
                                    totalWallet >= widget.total) {
                                  Difference =
                                      (totalWallet + widget.total - totalWallet)
                                              .toInt() +
                                          int.parse(
                                              widget.ads.additionValue ?? '0');

                                  log("Total(2) ----> $Total");
                                  log("Difference(2) ----> $Difference");

                                  setState(() {
                                    isWallet = true;
                                  });
                                  setState(() =>
                                      requestState = RequestState.loading);
                                  final res =
                                      await ReservationController.addOrder(
                                    count: widget.count.toString(),
                                    house_id: widget.ads.id.toString(),
                                    from: widget.from,
                                    to: widget.to,
                                    payment_type: "wallet",
                                    coupon: discount != null
                                        ? codeController.text
                                        : '0',
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
                        padding: EdgeInsets.all(15),
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'شروط الحجز',
                                style: TextStyle(
                                    fontSize: AppFonts.t3,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.ads.terms!.length,
                              itemBuilder: (context, index) {
                                final item = widget.ads.terms![index];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: SvgPicture.asset(
                                        'assets/svg/Ellipse 3756.svg',
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        item.term!,
                                        style: TextStyle(
                                          fontSize: AppFonts.t4_2,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 2.5.h,
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
                                  padding: EdgeInsets.symmetric(vertical: 2.w),
                                  text: 'طريقة الدفع',
                                  fontSize: AppFonts.t3,
                                  fontweight: FontWeight.bold,
                                ),
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
                              ],
                            ),
                    ),
                  )
                ]),
              ),
              /* (Difference ==
                    (Total + int.parse('${widget.ads.additionValue ?? '0'}')))
                ? const SizedBox.shrink()
                : */
              Positioned(
                height: 12.0.h,
                bottom: 0,
                width: size.width,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Color.fromARGB(255, 251, 251, 251),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: size.width,
                  height: 16.h,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 20, bottom: 0.0),
                    child: Builder(builder: (context) {
                      if (requestState == RequestState.loading)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 6.5.h,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  elevation: 3,
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      Color.fromRGBO(83, 138, 153, 1)),
                              child: Builder(builder: (context) {
                                if (requestState == RequestState.loading)
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                return Builder(builder: (context) {
                                  final double total = (Total +
                                      double.parse(
                                          widget.ads.additionValue ?? '0.0'));
                                  return Text(
                                    'ادفع الان (${total - total * (discount ?? 0)} ${widget.ads.currency!} )',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                });
                              }),
                              onPressed: () async {
                                final double total = (Total +
                                    double.parse(
                                        widget.ads.additionValue ?? '0.0'));
                                log("total ===> $total");

                                if (_selectedType == "applepay") {
                                  toastShow(
                                      text:
                                          'سيتم تفعيل خدمة الدفع بأبل باي قريبا');
                                  return;
                                }
                                PaymentStatus? status;
                                if (_selectedType == "online")
                                  status = await Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation, animation2) =>
                                                PaymentScreen(
                                          amount:
                                              total - total * (discount ?? 0),
                                          currency: 'SAR',
                                          description:
                                              '${widget.ads.name}:${widget.ads.desc}',
                                        ),
                                        transitionsBuilder: (context, animation,
                                                animation2, child) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                        transitionDuration:
                                            const Duration(milliseconds: 300),
                                      ));
                                if (_selectedType != "online" ||
                                    status == PaymentStatus.paid) {
                                  setState(() =>
                                      requestState = RequestState.loading);
                                  final res =
                                      await ReservationController.addOrder(
                                    count: widget.count.toString(),
                                    house_id: widget.ads.id.toString(),
                                    from: widget.from,
                                    to: widget.to,
                                    payment_type: _selectedType,
                                    coupon: discount != null
                                        ? codeController.text
                                        : '0',
                                  );

                                  setState(
                                    () => requestState = res
                                        ? RequestState.success
                                        : RequestState.error,
                                  );
                                  if (requestState == RequestState.error) {
                                    log("error when payment ==> $requestState");
                                  }
                                  if (requestState == RequestState.success) {
                                    myNavigate(
                                      screen: HomeScreen(),
                                      context: context,
                                      withBackButton: false,
                                    );
                                  }
                                }
                                if (Difference > 0)
                                  await ReservationController.walletPayment(
                                    price: '$Difference',
                                  );
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<bool> isCheckList = List<bool>.generate(3, (index) {
    if (index == 0) return true;
    return false;
  });
  List<String> textCheckList = ['مدي', 'فيزا', 'ماستر كارد'];
  int last = 0;

  void changeCheckBok(int index) {
    isCheckList[last] = false;
    isCheckList[index] = true;
    last = index;
    setState(() {});
  }

  Widget BuildCustomCheckBox(int i) {
    return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomCheckBox(
                value: isCheckList[i],
                shouldShowBorder: false,
                borderRadius: 15,
                checkBoxSize: 14,
                onChanged: (val) {
                  changeCheckBok(i);
                }),
            Text(
              textCheckList[i],
              style: TextStyle(
                  fontSize: AppFonts.t4_2,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
