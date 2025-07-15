import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:payment_integrations/payment_configuration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String amount1 = "0.05";
  String amount2 = "0.03";

// using getter method to able to use amount1 and amount 2 as variables,
// if want  to use default => var applePayButton = ApplePayButton()

  ApplePayButton get applePayButton => ApplePayButton(
        paymentConfiguration:
            PaymentConfiguration.fromJsonString(defaultApplePay),
        loadingIndicator: Center(child: CircularProgressIndicator()),
        paymentItems: [
          PaymentItem(
            label: "Item A",
            amount: amount1,
            status: PaymentItemStatus.final_price,
          ),
          PaymentItem(
            label: "Item B",
            amount: amount2,
            status: PaymentItemStatus.final_price,
          ),
          PaymentItem(
            label: "Total",
            amount: (double.parse(amount1) + double.parse(amount2))
                .toStringAsFixed(2),
            status: PaymentItemStatus.final_price,
          )
        ],
        style: ApplePayButtonStyle.automatic,
        width: double.infinity,
        height: 50,
        type: ApplePayButtonType.buy,
        margin: const EdgeInsets.only(top: 15.0),
        onPaymentResult: (result) =>
            debugPrint('Apple Pay Payment Result $result'),
      );

  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: [
      PaymentItem(
        label: "Total",
        amount: "0.01",
        status: PaymentItemStatus.final_price,
      )
    ],
    width: double.infinity,
    height: 50.0,
    type: GooglePayButtonType.pay,
    margin: EdgeInsets.only(top: 15),
    onPaymentResult: (result) =>
        debugPrint("Google Pay Payment Result $result"),
    loadingIndicator: Center(child: CircularProgressIndicator()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(child: Platform.isIOS ? applePayButton : googlePayButton),
      ),
    );
  }
}
