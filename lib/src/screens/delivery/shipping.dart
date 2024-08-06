import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/order_bloc/order_bloc.dart';
import 'package:it_can_cook/src/bloc/order_group/order_group_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/controller/order.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/order/order.dart';
import 'package:it_can_cook/src/models/shipper/ordergroup.dart';
import 'package:it_can_cook/src/screens/history/history_shipper.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ShippingScreen extends StatefulWidget {
  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderGroupBloc, List<OrderGroup>>(
      builder: (context, lstOrderGroup) {
        var list =
            lstOrderGroup.where((element) => element.status == 0).toList();
        var listorder = List<OrderHistory>.empty(growable: true);
        for (var item in list) {
          listorder.addAll(item.orders);
        }
        listorder =
            listorder.where((element) => element.status == "Shipping").toList();
        return LoaderOverlay(
            child: Scaffold(
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
                              GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.code),
                                        Text(
                                          ' ${S.current.order_code}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text('${e.orderCode}')
                                      ],
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        children: [
                                          Icon(Icons.gps_fixed),
                                          Text(
                                            ' ${S.current.address}:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(' ${e.address}')
                                        ],
                                      ),
                                      onTap: () {
                                        MapUtils.openMap(
                                            e.latitude ??
                                                double.parse("10.762622"),
                                            e.longitude ??
                                                double.parse("106.660172"));
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.phone),
                                        Text(
                                          ' ${S.current.phone_number}:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(' ${e.receivePhone}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.note),
                                        Text(
                                          ' ${S.current.note}:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(' ${e.note}')
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  context.loaderOverlay.show();
                                  context.read<OrderBloc>().add(
                                      GetHistoryOrderByOrderIdEvent(
                                          e.id ?? ''));

                                  //delay 2s

                                  await Future.delayed(Duration(seconds: 2));
                                  context.loaderOverlay.hide();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HistoryShipperDetail(
                                        orderHistorys: OrderHistory(
                                            orderCode: e.orderCode, id: e.id),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            //show dialog

                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text(S.current.shipped),
                                                    content: Text(S.current
                                                        .shiped_confirm),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(S
                                                              .current.cancel)),
                                                      TextButton(
                                                          onPressed: () async {
                                                            await OrderController()
                                                                .ChangeOrderStatus(
                                                                    e.id ?? '',
                                                                    2);
                                                            var account = context
                                                                .read<
                                                                    AccountBloc>()
                                                                .state;
                                                            context
                                                                .read<
                                                                    OrderGroupBloc>()
                                                                .add(GetOrderGroup(
                                                                    account?.id ??
                                                                        ''));
                                                            //settime out 2s
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 2),
                                                                () {
                                                              context
                                                                  .read<
                                                                      TriggerBloc>()
                                                                  .add(
                                                                      TriggerShipEvent(
                                                                          2));
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(S
                                                              .current.shipped))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text(S.current.shipped)),
                                      TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(S.current
                                                        .customer_not_take_order),
                                                    content:
                                                        Text(S.current.cancel),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(S
                                                              .current.cancel)),
                                                      TextButton(
                                                          onPressed: () async {
                                                            await OrderController()
                                                                .ChangeOrderStatus(
                                                                    e.id ?? '',
                                                                    4);
                                                            var account = context
                                                                .read<
                                                                    AccountBloc>()
                                                                .state;
                                                            context
                                                                .read<
                                                                    OrderGroupBloc>()
                                                                .add(GetOrderGroup(
                                                                    account?.id ??
                                                                        ''));
                                                            context
                                                                .read<
                                                                    TriggerBloc>()
                                                                .add(
                                                                    TriggerShipEvent(
                                                                        3));
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(S.current
                                                              .customer_not_take_order))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text(S
                                              .current.customer_not_take_order))
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(S.current.pending),
                                                content:
                                                    Text(S.current.pending),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                          S.current.cancel)),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await OrderController()
                                                            .ChangeOrderStatus(
                                                                e.id ?? '', 0);
                                                        var account = context
                                                            .read<AccountBloc>()
                                                            .state;
                                                        context
                                                            .read<
                                                                OrderGroupBloc>()
                                                            .add(GetOrderGroup(
                                                                account?.id ??
                                                                    ''));
                                                        context
                                                            .read<TriggerBloc>()
                                                            .add(
                                                                TriggerShipEvent(
                                                                    0));
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          Text(S.current.yes))
                                                ],
                                              );
                                            });
                                      },
                                      child: Text(S.current.cancel))
                                ],
                              )
                            ],
                          )),
                    ))
                .toList(),
          ),
        ));
      },
    );
  }
}
