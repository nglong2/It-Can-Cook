import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
            body: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                              width: 100,
                              height: 100,
                              imageUrl:
                                  state[index].orderDetails[0].recipe?.img ??
                                      ""),
                          Text(state[index].orderDetails[0].recipe?.name ?? ""),
                          // Text("Ngày đặt: " +
                          //     DateFormat("yyyy-MM-dd").format(DateTime.parse(
                          //         state[index].orderDate.toString()))),
                          // SizedBox(
                          //   width: 22,
                          // ),
                          // Text("Ngày Giao Dự Kiến: " +
                          //     DateFormat("yyyy-MM-dd").format(getNextMonday(
                          //         DateTime.parse(
                          //             state[index].orderDate.toString())))),
                          // SizedBox(
                          //   width: 22,
                          // ),
                          // Text(state[index].totalPrice.toString() + " VND"),
                          // SizedBox(
                          //   width: 22,
                          // ),
                          // Text(state[index].status.toString()),
                        ],
                      ),
                    ],
                  ),
                );
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
}
