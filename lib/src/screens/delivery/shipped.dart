import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/order_bloc/order_bloc.dart';
import 'package:it_can_cook/src/bloc/order_group/order_group_bloc.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/shipper/ordergroup.dart';

import 'package:it_can_cook/src/screens/history/history_shipper.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ShippedScreen extends StatefulWidget {
  const ShippedScreen({super.key});

  @override
  _ShippedScreenState createState() => _ShippedScreenState();
}

class _ShippedScreenState extends State<ShippedScreen> {
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
        listorder =
            listorder.where((element) => element.status == "Shipped").toList();
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
                                        const Icon(Icons.code),
                                        Text(
                                          ' ${S.current.order_code}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text('${e.orderCode}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.person),
                                        Text(
                                          ' ${S.current.name}:',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(' ${e.receiveName}')
                                      ],
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        children: [
                                          const Icon(Icons.gps_fixed),
                                          Text(
                                            ' ${S.current.address}:',
                                            style: const TextStyle(
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
                                        const Icon(Icons.phone),
                                        Text(
                                          ' ${S.current.phone_number}:',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(' ${e.receivePhone}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.note),
                                        Text(
                                          ' ${S.current.note}:',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                            '  ${e.note == null ? '' : (e.note!.length > 20 ? "${e.note!.substring(0, 20)}..." : "${e.note}")}')
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
                                  await Future.delayed(const Duration(seconds: 2));
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
                              Text(
                                S.current.shipped,
                                style: const TextStyle(color: Colors.green),
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
