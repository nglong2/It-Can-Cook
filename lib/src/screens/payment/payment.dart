import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/models/zalopay/payment_argument.dart';
import 'package:it_can_cook/src/repo/payment.dart';
import 'package:it_can_cook/src/utils/theme_data.dart';
import 'package:shelf_router/shelf_router.dart';

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
  final textStyle = TextStyle(color: Colors.black54);
  final valueStyle = TextStyle(
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
      } else if (res["errorCode"] == 4) {
        payResult = "User hủy thanh toán";
      } else {
        payResult = "Giao dịch thất bại";
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
                    return Center(
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
                    backgroundColor: Color.fromARGB(255, 79, 181, 82),
                    content: Container(
                      padding: const EdgeInsets.all(15),
                      child: Text("Thanh toán thành công"),
                    ),
                    duration: Duration(seconds: 2),
                  ));

                  Navigator.pushNamedAndRemoveUntil(
                      context, "home", (route) => false);

                  print("payOrder Result: '$result'.");
                } on PlatformException catch (e) {
                  print("Failed to Invoke: '${e.message}'.");
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
              child: Text("Thanh toán",
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
          SizedBox(
            height: 50,
          ),

          SizedBox(
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
                  style: TextStyle(
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