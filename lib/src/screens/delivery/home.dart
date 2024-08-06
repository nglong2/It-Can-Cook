import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/order_group/order_group_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/shipper/ordergroup.dart';
import 'package:it_can_cook/src/models/system/trigger.dart';
import 'package:it_can_cook/src/screens/delivery/cancle.dart';
import 'package:it_can_cook/src/screens/delivery/pending.dart';
import 'package:it_can_cook/src/screens/delivery/shipped.dart';
import 'package:it_can_cook/src/screens/delivery/shipping.dart';
import 'package:it_can_cook/src/screens/setting/setting.dart';

class DeliveryHome extends StatefulWidget {
  @override
  _DeliveryHomeState createState() => _DeliveryHomeState();
}

class _DeliveryHomeState extends State<DeliveryHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PendingScreen(),
    ShippingScreen(),
    ShippedScreen(),
    CancleScreen(),
    const SettingsView()
  ];

  @override
  Widget build(BuildContext context) {
    var account = context.read<AccountBloc>().state;
    context.read<OrderGroupBloc>().add(GetOrderGroup(account?.id ?? ''));
    return BlocListener<TriggerBloc, Trigger>(
      listener: (context, state) {
        setState(() {
          _currentIndex = state.shipNum;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Delivery Page'),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.pending),
              label: S.current.pending,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: S.current.shipping,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              label: S.current.shipped,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cancel),
              label: S.current.cancel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: S.current.settings,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusPage extends StatelessWidget {
  final String status;

  OrderStatusPage({required this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Order Status: $status',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
