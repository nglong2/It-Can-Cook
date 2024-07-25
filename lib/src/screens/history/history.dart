import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Scaffold(
            appBar: AppBar(
              title: Text(S.current.history),
            ),
            body: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Ngay Dat:" +
                              DateTime.parse(state[index].orderDate.toString())
                                  .toIso8601String()),
                          SizedBox(
                            width: 22,
                          ),
                          Text("Ngay Giao:" +
                              DateTime.parse(state[index].shipDate.toString())
                                  .toIso8601String()),
                          SizedBox(
                            width: 22,
                          ),
                          Text(state[index].totalPrice.toString()),
                          SizedBox(
                            width: 22,
                          ),
                          Text(state[index].status.toString()),
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
}
