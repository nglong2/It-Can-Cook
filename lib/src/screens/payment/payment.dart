import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/controller/transaction.dart';
import 'package:it_can_cook/src/models/transactions/transaction.dart';
import 'package:it_can_cook/src/models/zalopay/payment_argument.dart';
import 'package:it_can_cook/src/repo/payment.dart';
import 'package:it_can_cook/src/utils/theme_data.dart';

class Payment extends StatefulWidget {
  final PaymentArguemnt arg;

  Payment(this.arg);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  static const EventChannel eventChannel =
      EventChannel('flutter.native/eventPayOrder');
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');
  final textStyle = const TextStyle(color: Colors.black54);
  final valueStyle = const TextStyle(
      color: AppColor.accentColor, fontSize: 18.0, fontWeight: FontWeight.w400);
  String zpTransToken = "";
  String payResult = "";
  String payAmount = "1000";
  bool showResult = false;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      eventChannel
          .receiveBroadcastStream()
          .listen(_onEvent as void Function(dynamic event)?, onError: _onError);
    }
  }

  void _onEvent(Object event) {
    print("_onEvent: '$event'.");
    var res = Map<dynamic, dynamic>.from(event as Map);
    setState(() {
      if (res["errorCode"] == 1) {
        payResult = "Thanh toán thành công";

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 79, 181, 82),
          content: Container(
            padding: const EdgeInsets.all(5),
            child: const Text("Thanh toán thành công"),
          ),
          duration: const Duration(seconds: 2),
        ));
        Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
      } else if (res["errorCode"] == 4) {
        payResult = "User hủy thanh toán";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 235, 74, 25),
          content: Container(
            padding: const EdgeInsets.all(5),
            child: const Text("User hủy thanh toán"),
          ),
          duration: const Duration(seconds: 2),
        ));
      } else {
        payResult = "Giao dịch thất bại";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 206, 71, 66),
          content: Container(
            padding: const EdgeInsets.all(5),
            child: const Text("Giao dịch thất bại"),
          ),
          duration: const Duration(seconds: 2),
        ));
      }
    });
  }

  void _onError(Object error) {
    print("_onError: '$error'.");
    setState(() {
      payResult = "Giao dịch thất bại";
    });
  }

  // Button Create Order
  Widget _btnCreateOrder(String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: GestureDetector(
          onTap: () async {
            int amount = int.parse(value);
            if (amount < 1000 || amount > 1000000) {
              setState(() {
                zpTransToken = "Invalid Amount";
              });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              var result = await createOrder(widget.arg.price.toInt());
              if (result != null) {
                Navigator.pop(context);
                zpTransToken = result.zptranstoken;
                setState(() {
                  zpTransToken = result.zptranstoken;
                  showResult = true;
                });
                try {
                  final String result = await platform
                      .invokeMethod('payOrder', {"zptoken": zpTransToken});

                  //scafod show snackbar success
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: const Color.fromARGB(255, 79, 181, 82),
                    content: Container(
                      padding: const EdgeInsets.all(5),
                      child: const Text("Thanh toán thành công"),
                    ),
                    duration: const Duration(seconds: 2),
                  ));
                  Navigator.pushNamedAndRemoveUntil(
                      context, "home", (route) => false);
                  TransactionController().createTransaction(Transaction(
                      orderId: widget.arg.orderID,
                      transactionType: 2,
                      amount: widget.arg.price.toInt(),
                      transactionDate: DateTime.now().toString(),
                      notice: "Thanh toán",
                      extraData: "Thanh toán",
                      signature: "Thanh toán",
                      status: 0));
                  print("payOrder Result: '$result'.");
                } on PlatformException catch (e) {
                  print("Failed to Invoke: '${e.message}'.");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text("Thanh toán thất bại"),
                    ),
                    duration: const Duration(seconds: 2),
                  ));
                  TransactionController().createTransaction(Transaction(
                      orderId: widget.arg.orderID,
                      transactionType: 2,
                      amount: widget.arg.price.toInt(),
                      transactionDate: DateTime.now().toString(),
                      notice: "Thanh toán",
                      extraData: "Thanh toán",
                      signature: "Thanh toán",
                      status: 4));
                }
              }
            }
          },
          child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text("Thanh toán",
                  style: TextStyle(color: Colors.white, fontSize: 20.0))),
        ),
      );

  /// Build Button Pay

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //selected 2 value
          const SizedBox(
            height: 50,
          ),

          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                CachedNetworkImage(
                    imageUrl: "https://wemealkit.s3.amazonaws.com/zlp.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover),
                Text("Thanh Toán Bằng ZaloPay", style: textStyle),
              ],
            ),
          ),

          Row(
            //end
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  "${S.current.total} ${widget.arg.price.toStringAsFixed(0).replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]}.',
                      )}đ",
                  style: const TextStyle(
                      color: AppColor.accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          _btnCreateOrder(payAmount),
        ],
      ),
    );
  }
}

/// Build Info App