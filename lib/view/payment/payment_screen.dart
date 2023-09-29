import 'dart:developer';

import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/components/components.dart';
import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({
    super.key,
    this.currency = 'SAR',
    required this.amount,
    required this.description,
  });

  final double amount;
  final String currency;
  final String description;

  void onPaymentResult(result, context) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          Navigator.pop(context, result.status);
          toastShow(text: 'تم الدفع بنجاح');
          break;
        case PaymentStatus.failed:
          toastShow(text: 'فشل الدفع');
          break;
        case PaymentStatus.initiated:
          break;
      }
    }
    // handle other type of failures.
    if (result is AuthError) {}
    if (result is ValidationError) {}
    if (result is PaymentCanceledError) {}
  }

  @override
  Widget build(BuildContext context) {
    log("Payment ----> $amount");

    print((amount.truncate() * 100) + ((amount - amount.truncate()) * 100));
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: size.height * 0.025,
            left: size.height * 0.020,
            right: size.height * 0.020,
            top: size.height * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(pageTitle: 'بيانات الدفع'),
              Image.asset('assets/images/credit-card-6379.png'),
              CreditCard(
                locale: Localization.ar(),
                config: PaymentConfig(
                  publishableApiKey:
                      'pk_test_ePwt4US42kkUWjvzmH6HpcUKyqCW6Q4uMW3dJE17',
                  amount: ((amount.truncate() * 100) +
                          ((amount - amount.truncate()) * 100))
                      .toInt(),
                  currency: currency,
                  description: description,
                  metadata: {'description': description},
                ),
                onPaymentResult: (result) {
                  onPaymentResult(result, context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // void processPayment(String paymentTokenId) async {
  //   try {
  //     final payment = await Moyasar.payment.create(
  //       token: paymentTokenId,
  //       source: CreditCard(
  //         config: paymentConfig,
  //         onPaymentResult: onPaymentResult,

  //       ),
  //     );
  //     print('Payment succeeded: ${payment.id}');
  //   } catch (e) {
  //     print('Payment failed: $e');
  //   }
  // }

  void showToast(context, status) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Status: $status",
        style: const TextStyle(fontSize: 20),
      ),
    ));
  }
}
