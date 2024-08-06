import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/order_group/order_group_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/controller/order.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/order/order.dart';
import 'package:it_can_cook/src/models/shipper/ordergroup.dart';

class PendingScreen extends StatefulWidget {
  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderGroupBloc, List<OrderGroup>>(
      builder: (context, lstOrderGroup) {
        var list = lstOrderGroup.toList();
        var listorder = List<OrderHistory>.empty(growable: true);
        for (var item in list) {
          listorder.addAll(item.orders);
        }
        listorder = listorder
            .where((element) => element.status == "Processing")
            .toList();
        return Scaffold(
          body: Column(
            children: listorder
                .map((e) => Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${S.current.order_code}${e.orderCode}'),
                                  Text('${S.current.address}: ${e.address}'),
                                  Text(
                                      '${S.current.phone_number}: ${e.receivePhone}'),
                                  Text('${S.current.note}: ${e.note}'),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    //show dialog

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(S.current.ship),
                                            content:
                                                Text(S.current.ship_confirm),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      Text(S.current.cancel)),
                                              TextButton(
                                                  onPressed: () {
                                                    OrderController()
                                                        .ChangeOrderStatus(
                                                            e.id ?? '', 1);
                                                    var account = context
                                                        .read<AccountBloc>()
                                                        .state;
                                                    context
                                                        .read<OrderGroupBloc>()
                                                        .add(GetOrderGroup(
                                                            account?.id ?? ''));
                                                    context
                                                        .read<TriggerBloc>()
                                                        .add(TriggerShipEvent(
                                                            1));
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(S.current.ship))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(S.current.ship))
                            ],
                          )),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
