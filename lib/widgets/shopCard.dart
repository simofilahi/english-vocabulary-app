import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lenglish/widgets/payment/ConfirmPaymentInfo.dart';
import 'package:lenglish/widgets/payment/PaymentIntentInfo.dart';
import 'package:lenglish/widgets/payment/StripePaymentManager.dart';
import 'package:lenglish/widgets/payment/cancelPaymentInfo.dart';
import 'package:lenglish/widgets/payment/constant.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:stripe_native/stripe_native.dart';
import 'package:lenglish/widgets/payment/localization.dart';
import 'package:lenglish/widgets/payment/toast.dart';
import 'package:stripe_payment/stripe_payment.dart';
import '../constants.dart';
import 'customButton.dart';

class ShopCard extends StatefulWidget {
  ShopCard({Key key}) : super(key: key);

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  // double totalAmount = 0;
  // double amount = 0;
  // String currencyName = "";
  // Map receipt;
  // Receipt finalReceipt;
  // String generatedToken = "";
  // final StripePaymentManager _stripePaymentManager = StripePaymentManager();

  @override
  void initState() {
    super.initState();
    // StripeNative.setPublishableKey(publishableKey);
    // StripeNative.setMerchantIdentifier(merchantIdentifier);
    // StripeNative.setCurrencyKey("USD");
  }

//   Future<String> receiptPayment(Receipt finalReceipt) async {
//     return await StripeNative.useReceiptNativePay(finalReceipt);
//   }

//   //Click Event Method For Google Pay Button
//   _onNativeButtonClicked() async {
//     print("holla");
//     currencyName = currency();
//     print(currencyName);
//     print("after");
// //    Below Two lines is for Example To Show How To Pass Details To receiptPayment
// //    Method For Generating Token
//     receipt = <String, double>{"Nice Hat": 5.00, "Used Hat": 1.50};
//     finalReceipt = Receipt(receipt, "lenglish");
//     //You can pass Amount According To Your Payment
//     amount = 0;
//     receipt.values.forEach((element) {
//       amount = amount + element;
//     });
//     print("I'm here");
//     totalAmount = amount * 100.0;
//     print(totalAmount);
//     generatedToken = await receiptPayment(finalReceipt);
//     print("before");
//     try {
//       print(currencyName);
//       dynamic result = await _stripePaymentManager.startCreatePayment(
//           context, totalAmount, currencyName, generatedToken);
//       if (result is PaymentIntentInfo) {
//         if (result != null) {
//           confirmDialog(receipt, finalReceipt, result.paymentIntentId,
//               result.paymentMethodId);
//         }
//       }
//     } catch (e) {
//       ToastUtils.showToast(e, Colors.black, Colors.white);
//       return e;
//     }
//   }

//   //To Get Locale Based Currency Name
//   String currency() {
//     Locale locale = Localizations.localeOf(context);
//     var format = NumberFormat.simpleCurrency(locale: locale.toString());
//     return format.currencyName;
//   }

//   //To Ask User To Confirm Payment Or Not
//   confirmDialog(
//       Map receipt, Receipt finalReceipt, String intentId, String methodId) {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               title: Text(
//                 Localization.of(context).confirmDialogTitle,
//               ),
//               content: Container(
//                   child:
//                       Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                 Column(
//                     children: finalReceipt.items.entries.map((e) {
//                   totalAmount = totalAmount + e.value;
//                   return Column(children: <Widget>[
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             "${e.key}",
//                           ),
//                           Text(
//                             "${e.value}",
//                           ),
//                         ])
//                   ]);
//                 }).toList()),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         "${Localization.of(context).payTo} ${finalReceipt.merchantName}",
//                       ),
//                       Text(
//                         "${finalReceipt.items.values.elementAt(0) + finalReceipt.items.values.elementAt(1)}",
//                       )
//                     ])
//               ])),
//               actions: <Widget>[
//                 RaisedButton(
//                   child: Text(
//                     Localization.of(context).cancel,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     cancelPayment(intentId);
//                   },
//                 ),
//                 RaisedButton(
//                     child: Text(Localization.of(context).confirm,
//                         style: confirmTextStyle),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       confirmPayment(intentId, methodId);
//                     })
//               ]);
//         });
//   }

//   //To Confirm the payment process
//   confirmPayment(String intentId, String methodId) async {
//     try {
//       dynamic result = await _stripePaymentManager.confirmPaymentIntent(
//           context, intentId, methodId);
//       if (result is ConfirmPaymentInfo) {
//         if (result != null) {
//           if (result.paymentStatus ==
//               Localization.of(context).paymentSuccessStatus) {
//             ToastUtils.showToast(Localization.of(context).successPaymentStatus,
//                 Colors.black, Colors.white);
//           }
//         }
//       }
//     } catch (e) {
//       ToastUtils.showToast(e, Colors.black, Colors.white);
//       return e;
//     }
//   }

//   //To Cancel the payment process
//   cancelPayment(String intentId) async {
//     try {
//       dynamic result =
//           await _stripePaymentManager.cancelPayment(context, intentId);
//       if (result is CancelPaymentInfo) {
//         if (result != null) {
//           if (result.cancelStatus == Localization.of(context).cancelStatus) {
//             ToastUtils.showToast(Localization.of(context).cancelPaymentStatus,
//                 Colors.black, Colors.white);
//           }
//         }
//       }
//     } catch (e) {
//       ToastUtils.showToast(e, Colors.black, Colors.white);
//       return e;
//     }
//   }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 2.0,
        right: 2.0,
      ),
      child: Container(
        height: 160,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextWidget(
                          text: 'Premium account',
                          size: 20.0,
                          color: Theme.of(context).textSelectionColor,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        TextWidget(
                          text: 'Remove ads',
                          color: Theme.of(context).cursorColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: 'Buy',
                    buttonHeightSize: 40.0,
                    buttonWidthSize: 150.0,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(
                  right: 30.0,
                ),
                margin: const EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: FittedBox(
                  child: SvgPicture.asset(
                    crownIcon,
                    height: 80.0,
                    width: 80.0,
                    color: primaryYellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
