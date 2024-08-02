import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/order_bloc/order_bloc.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, List<OrderHistory>>(
      listener: (context, state) {},
      child: BlocBuilder<OrderBloc, List<OrderHistory>>(
        builder: (context, state) {
          var date = DateTime.now();

          var nextMonday = date.add(Duration(days: 1 - date.weekday + 7));

          return Scaffold(
            appBar: AppBar(
              title: Text(S.current.history),
            ),
            backgroundColor: Colors.grey[200],
            body: state.length == 0
                ? Center(
                    child: Text(S.current.you_dont_have_any_order),
                  )
                : ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(10)),
                          child: GestureDetector(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: state[index]
                                                    .weeklyPlan
                                                    ?.urlImage ??
                                                "",
                                            width: 80,
                                            fit: BoxFit.cover,
                                            height: 80,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state[index]
                                                            .weeklyPlan
                                                            ?.title
                                                            .toString() ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${state[index].orderDetails.length} items",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(state[index].status ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: getColorByStatus(
                                                      state[index].status ??
                                                          ""))),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              getDay(DateTime.parse(
                                                  state[index].orderDate ??
                                                      "")),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Text(
                                              getTime(DateTime.parse(
                                                  state[index].orderDate ??
                                                      "")),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black))
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.pushNamed(
                                    context,
                                    "history_detail",
                                    arguments: state[index],
                                  )));
                    },
                  ),
          );
        },
      ),
    );
  }

  //get daay, if date is to day, retrun today, yesterday return yesterday, else return date
  String getDay(DateTime date) {
    var now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return S.current.today;
    } else if (date.day == now.day - 1 &&
        date.month == now.month &&
        date.year == now.year) {
      return S.current.yesterday;
    } else {
      return DateFormat("dd/MM/yyyy").format(date);
    }
  }

  DateTime getNextMonday(DateTime date) {
    return date.add(Duration(days: 1 - date.weekday + 7));
  }

  //get time from date
  String getTime(DateTime date) {
    return DateFormat("HH:mm").format(date.add(Duration(hours: 7)).toLocal());
  }
}

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
