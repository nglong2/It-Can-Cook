import 'package:flutter/material.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/weekly/ingredient.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class HistoryDetail extends StatefulWidget {
  final OrderHistory orderHistory;

  const HistoryDetail({super.key, required this.orderHistory});
  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.order_information),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 30),
              child: Row(
                children: [
                  Text(
                    "ID: ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 247, 175, 42),
                        fontWeight: FontWeight.bold),
                  ),
                  Text("${widget.orderHistory.id?.substring(0, 8) ?? "No ID"}")
                ],
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                S.current.delivery_to,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row()
            ],
          ),
        ));
  }
}
