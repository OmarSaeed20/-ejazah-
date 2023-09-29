import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/Widgets/custom_text.dart';
import 'package:ejazah/components/components.dart';
import 'package:ejazah/utils/enums.dart';
import 'package:ejazah/view/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moyasar/moyasar.dart';
import 'package:sizer/sizer.dart';

import '../../controller/my_wallet_controller.dart';
import '../../model/get_wallet_model.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  final priceController = TextEditingController();
  RequestState requestState = RequestState.waiting;
  GetWalletModel? getWalletModel;
  GetWalletModel? AddToWalletModel;
  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    final res = await GetWalletController.getWallet();
    if (res) {
      getWalletModel = GetWalletController.getWalletModel;
      setState(() => requestState = RequestState.success);
    } else {
      setState(() => requestState = RequestState.error);
    }
  }

  addToWallet(value) async {
    setState(() => requestState = RequestState.loading);
    final res = await GetWalletController.addToWallet(value);
    if (res) {
      getData();
      setState(() => requestState = RequestState.success);
      priceController.clear();
    } else {
      setState(() => requestState = RequestState.error);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Builder(builder: (context) {
          if (requestState == RequestState.loading)
            return Center(child: CircularProgressIndicator());
          if (requestState == RequestState.error)
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('تأكد من اتصالك بالانترنت'),
                ElevatedButton(
                    onPressed: () {
                      getData();
                    },
                    child: Text('اعادة المحاولة'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber[900]))),
              ],
            ));
          return RefreshIndicator(
            onRefresh: () async {
              await getData();
            },
            child: Stack(
              children: <Widget>[
                (Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.04,
                                      bottom: size.height * 0.05,
                                      left: size.height * 0.015,
                                      right: size.height * 0.015,
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
                                        height: size.height * .28),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        CustomAppBar(
                                          pageTitle: 'محفظتي',
                                          titleColor: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                      top: 17.h,
                                      right: 9.w,
                                      bottom: 0.4.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: getCardContainer(
                                              '${getWalletModel!.data!.total!}'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 2.5.w, right: 2.5.w),
                                  child: getNotification())
                            ]),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget getCardContainer(String totalWallet) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4.5.h),
          height: 35.5.h,
          width: size.width * .8,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'رصيدك في المحفظة',
                style: TextStyle(
                    fontSize: AppFonts.t4_2, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                '$totalWallet ',
                style: TextStyle(
                    fontSize: AppFonts.t1, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Container(
                    width: size.width * .6,
                    height: 9.h,
                    padding: EdgeInsets.only(top: 2.5.h, right: 5.w),
                    child: TextFormField(
                      controller: priceController,
                      validator: (value) =>
                          value!.isEmpty ? 'Is Required' : null,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'أدخل القيمة',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: 40.w,
                    height: 6.h,
                    child: TextButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(5)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: AppColor.orangeColor)))),
                        onPressed: () async {
                          if (priceController.text.isEmpty ||
                              double.tryParse(priceController.text) == null) {
                            toastShow(text: 'ادخل القيمة بشكل صحيح');
                            return;
                          }
                          PaymentStatus res = await Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => PaymentScreen(
                                    amount: double.parse(priceController.text),
                                    description: '${priceController.text} '),
                                transitionsBuilder: (c, anim, a2, child) =>
                                    FadeTransition(opacity: anim, child: child),
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                              ));
                          if (res == PaymentStatus.paid)
                            addToWallet(priceController.text);
                        },
                        child: CustomText(
                            text: 'أضف إلى المحفظة', color: Colors.blueAccent)),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  getNotification() {
    Size size = MediaQuery.of(context).size;

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        final Wallets wallet = getWalletModel!.data!.wallets![index];
        return Container(
          padding: EdgeInsets.all(15),
          // height: 19.h,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(0, 2.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(wallet.date!),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: SvgPicture.asset(
                    'assets/svg/Group 45890.svg',
                    height: 11.h,
                    width: 11.w,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    wallet.desc!,
                    style: TextStyle(
                        color: Color.fromRGBO(169, 169, 169, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: AppFonts.t4_2),
                  ),
                ),
              ],
            ),
          ]),
        );
      },
      itemCount: getWalletModel!.data!.wallets!.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 2.5.h,
      ),
    );
  }
}
