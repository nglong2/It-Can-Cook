import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/order_bloc/order_bloc.dart';
import 'package:it_can_cook/src/bloc/recipe_all/recipes_all_bloc.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/zalopay/payment_argument.dart';
import 'package:it_can_cook/src/screens/history/order_history_item.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryShipperDetail extends StatefulWidget {
  final OrderHistory orderHistorys;

  const HistoryShipperDetail({super.key, required this.orderHistorys});
  @override
  _HistoryShipperDetailState createState() => _HistoryShipperDetailState();
}

class _HistoryShipperDetailState extends State<HistoryShipperDetail> {
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
                          " ${getNextSunday(DateTime.parse(select.shipDate ?? ""))}",
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
      return "";
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
