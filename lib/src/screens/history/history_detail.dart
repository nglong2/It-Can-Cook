import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:intl/intl.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/order_bloc/order_bloc.dart';
import 'package:it_can_cook/src/bloc/recipe_all/recipes_all_bloc.dart';
import 'package:it_can_cook/src/controller/order.dart';
import 'package:it_can_cook/src/controller/transaction.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/transactions/transaction.dart';
import 'package:it_can_cook/src/models/zalopay/payment_argument.dart';
import 'package:it_can_cook/src/models/zalopay/refund_response.dart';
import 'package:it_can_cook/src/screens/history/order_history_item.dart';
import 'package:it_can_cook/src/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryDetail extends StatefulWidget {
  final OrderHistory orderHistorys;

  const HistoryDetail({super.key, required this.orderHistorys});
  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  double rating = 0;
  int starCount = 5;
  //controller form rating
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<RecipesAllBloc>().add(FetchRecipesAllEvent(""));
    var account = context.read<AccountBloc>().state;
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.order_information),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 30),
              child: Column(
                children: [
                  Text(
                    S.current.order_code,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 247, 175, 42),
                        fontWeight: FontWeight.bold),
                  ),
                  Text("#${widget.orderHistorys.orderCode}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 51, 50, 49),
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
        body: BlocBuilder<OrderBloc, List<OrderHistory>>(
          builder: (context, state) {
            var select = state
                .firstWhere((element) => element.id == widget.orderHistorys.id);
            bool isDoneOrder =
                select.status == "Delivered" || select.status == "Shipped";
            // bool isShowFeedback = isDoneOrder && select.rating == 0;
            bool isShowFeedback = isDoneOrder && 0 == 0;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${S.current.delivery_to} :",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              "${S.current.status}: ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                "${select.status}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        getColorByStatus(select.status ?? "")),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    Flexible(
                                        child: Text(
                                      select.address ?? "No address",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ))
                                  ],
                                ),
                                onTap: () {
                                  MapUtils.openMap(double.parse("10.819139"),
                                      double.parse("106.6973554"));
                                },
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  Flexible(
                                    child: Text(
                                      select.receiveName ?? "No name",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.phone),
                                  Text(
                                    select.receivePhone ?? "No phone",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ))),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          S.current.orderdate,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          " ${getDate(DateTime.parse(select.orderDate ?? ""))} ${getHour(DateTime.parse(select.orderDate ?? ""))}",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          S.current.estimated_delivery_time,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          " ${getDate(DateTime.parse(select.shipDate ?? ""))}",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: //all
                              Border.all(color: Colors.grey[400]!),
                        ),
                        height: MediaQuery.of(context).size.height * 0.35,
                        child:
                            OrderHistoryItem(orderDetails: select.orderDetails),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            S.current.total,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                              " ${select.totalPrice?.toStringAsFixed(0).replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},',
                                  )} VND  ",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 224, 118, 18),
                                  fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Phương thức thanh toán: ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              select.transaction?.type ?? "No type",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 25, 94, 141),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${S.current.payment_status}: ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              getNamePayment(select.transaction?.status),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: getColorByPayment(
                                      select.transaction?.status)),
                            ),
                            (select.transaction?.type == "ZaloPay" &&
                                    select.transaction?.status == "Pending" &&
                                    select.status == "Processing")
                                ? TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white)),
                                    onPressed: () => {
                                      Navigator.pushReplacementNamed(
                                          context, "payment",
                                          arguments: PaymentArguemnt(
                                            orderID: select.id ?? "",
                                            price: select.totalPrice ?? 0,
                                            name: 'repayment',
                                          ))
                                    },
                                    child: Text(S.current.re_payment),
                                  )
                                : Container()
                          ],
                        )
                      ],
                    ),
                  ),
                  //note
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${S.current.note}: ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //textarea
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          margin: const EdgeInsets.only(right: 10),
                          width: MediaQuery.of(context).size.width * 1 - 30,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!),
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            select.note ?? "",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500),
                          ),
                        )
                        //if status is processing, show button cancel
                        ,
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: select.status == "Processing"
                              ? ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 255, 153, 146)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white)),
                                  onPressed: () {
                                    //show dialog confirm
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(S.current.cancle_order),
                                            content: Text(
                                                select.weeklyPlan?.title ?? ""),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      Text(S.current.cancel)),
                                              TextButton(
                                                  onPressed: () async {
                                                    //cancel order
                                                    //call api

                                                    var mess =
                                                        await OrderController()
                                                            .ChangeOrderStatus(
                                                                select.id ?? "",
                                                                7);

                                                    if (select.transaction
                                                                ?.type ==
                                                            "ZaloPay" &&
                                                        select.transaction
                                                                ?.status ==
                                                            "PAID") {
                                                      //call api
                                                      TransactionController()
                                                          .createTransaction(Transaction(
                                                              orderId:
                                                                  select.id ??
                                                                      "",
                                                              transactionType:
                                                                  2,
                                                              amount: select
                                                                  .totalPrice!
                                                                  .toInt(),
                                                              transactionDate:
                                                                  DateTime.now()
                                                                      .toIso8601String(),
                                                              notice: "Refund",
                                                              extraData:
                                                                  "Refund",
                                                              signature:
                                                                  "Refund",
                                                              status: 2));

                                                      var yymmdd = DateFormat(
                                                              "yyMMdd")
                                                          .format(
                                                              DateTime.now());
                                                      var mRefundId =
                                                          "${yymmdd}_2554_${DateTime.now().millisecondsSinceEpoch.toString().substring(2, 12)}";
                                                      var zpTransId = select
                                                              .transaction
                                                              ?.signature!
                                                              .split('_')[1] ??
                                                          "";
                                                      var amount = select
                                                          .totalPrice!
                                                          .toInt();
                                                      var refundFeeAmount = 0;
                                                      var timestamp = DateTime
                                                              .now()
                                                          .millisecondsSinceEpoch;
                                                      var description =
                                                          "Refund";
                                                      var mac = getMacCreateOrder(
                                                          "2554|$zpTransId|$amount|0|$description|$timestamp");
                                                      Refund re = Refund(
                                                          appId: 2554,
                                                          zpTransId: zpTransId,
                                                          mRefundId: mRefundId,
                                                          amount: amount,
                                                          description:
                                                              description,
                                                          timestamp: timestamp,
                                                          mac: mac);
                                                      var mess =
                                                          await OrderController()
                                                              .RefundOrder(re);
                                                      print(
                                                          "datarefund :$mess");
                                                      //show snackbar
                                                    } else {
                                                      TransactionController()
                                                          .createTransaction(Transaction(
                                                              orderId:
                                                                  select.id ??
                                                                      "",
                                                              transactionType:
                                                                  0,
                                                              amount: select
                                                                  .totalPrice!
                                                                  .toInt(),
                                                              transactionDate:
                                                                  DateTime.now()
                                                                      .toIso8601String(),
                                                              notice: "Refund",
                                                              extraData:
                                                                  "Refund",
                                                              signature:
                                                                  "Refund",
                                                              status: 4));
                                                    }
                                                    //show snackbar
                                                    Navigator.pop(context);
                                                    //show snackbar
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content:
                                                                Text(mess)));

                                                    context
                                                        .read<OrderBloc>()
                                                        .add(
                                                            GetHistoryOrderEvent(
                                                                account?.id ??
                                                                    ""));
                                                    // Navigator.pop(context);
                                                  },
                                                  child: Text(S.current.yes))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(S.current.cancle_order),
                                )
                              : Container(),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //feedback
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${S.current.feedback}: ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            StarRating(
                              size: 40.0,
                              rating: rating,
                              color: Colors.orange,
                              borderColor: Colors.grey,
                              allowHalfRating: true,
                              starCount: starCount,
                              onRatingChanged: (rating) => setState(() {
                                this.rating = rating;
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //textarea

                        //textarea ratting form
                        Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              margin: const EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width * 1 - 30,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)!),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: TextField(
                                controller: _controller,
                                readOnly: !isShowFeedback,
                                maxLines: 5,
                              ),
                            ),
                            //button send feedback
                            !isShowFeedback
                                ? const SizedBox()
                                : Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 29, 96, 19)),
                                        foregroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.white),
                                        //borderRadius: BorderRadius.circular(10
                                      ),
                                      onPressed: () {
                                        var feedback = _controller.text;

                                        //call api
                                        //show snackbar
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(feedback)));
                                      },
                                      child: Text(S.current.feedback),
                                    ),
                                  )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

//Container(
//   padding: const EdgeInsets.only(left: 20),
//   child: Row(
//     children: [
//       Text(
//         S.current.total,
//         style: const TextStyle(fontWeight: FontWeight.w500),
//       ),
//       Text(
//         " ${widget.orderHistory.totalPrice} VND",
//         style: TextStyle(
//             color: Colors.grey[500], fontWeight: FontWeight.w500),
//       )
//     ],
//   ),
// ),

// //return diferent color when status is Processing
// Shipping
// Shipped
// Delivered
// UnShipped
// Refund
// Canceled

Color getColorByStatus(String status) {
  switch (status) {
    case "Processing":
      return Colors.blue;
    case "Shipping":
      return Colors.orange;
    case "Shipped":
      return Colors.green;
    case "Delivered":
      return Colors.green;
    case "UnShipped":
      return Colors.red;
    case "Refund":
      return Colors.red;
    case "Canceled":
      return Colors.red;
    default:
      return Colors.black;
  }
}

//get color payment case (String name)
// PAID = 0,
// PendingMomo = 1,
// PendingZaloPay = 2,
// UNPAID = 3,
// Cancel = 4,
// Pending = 5

Color getColorByPayment(String? name) {
  switch (name) {
    case "PAID":
      return Colors.green;
    case "PendingMomo":
      return Colors.orange;
    case "PendingZaloPay":
      return Colors.orange;
    case "UNPAID":
      return Colors.red;
    case "Cancel":
      return Colors.red;
    case "Pending":
      return Colors.orange;
    default:
      return Colors.black;
  }
}

//get S.cureent name payment case (String name)

String getNamePayment(String? name) {
  switch (name) {
    case "PAID":
      return S.current.paid;
    case "PendingMomo":
      return S.current.pending_momo;
    case "PendingZaloPay":
      return S.current.pending_zalopay;
    case "UNPAID":
      return S.current.unpaid;
    case "Cancel":
      return S.current.cancel;
    case "Pending":
      return S.current.pending;
    default:
      return name ?? "";
  }
}

String getDate(DateTime date) {
  //"DD/MM/YYYY"
  return "${date.day}/${date.month}/${date.year}";
}

String getHour(DateTime date) {
  //"HH:MM"
  //14:01
  return DateFormat("HH:mm").format(date);
}

//get next sunday, if today is sunday, still retunt next sunday fotmay dd/mm/yyyy
String getNextSunday(DateTime date) {
  return DateFormat("dd/MM/yyyy")
      .format(date.add(Duration(days: 7 - date.weekday)));
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
