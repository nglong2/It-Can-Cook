import 'package:flutter/material.dart';
import 'package:it_can_cook/src/screens/setting/setting.dart';

class DeliveryHome extends StatefulWidget {
  @override
  _DeliveryHomeState createState() => _DeliveryHomeState();
}

class _DeliveryHomeState extends State<DeliveryHome> {
  int _currentIndex = 0;

  List<Widget> _pages = [
    OrderStatusPage(status: 'Pending'),
    OrderStatusPage(status: 'In Progress'),
    OrderStatusPage(status: 'Delivered'),
    OrderStatusPage(status: 'Cancelled'),
    SettingsView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Page'),
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
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'In Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Delivered',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Cancelled',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
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
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
