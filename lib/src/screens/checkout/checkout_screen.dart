import 'package:flutter/material.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';

class CheckoutScreen extends StatefulWidget {
  final WeeklyPlan weeklyPlan;

  const CheckoutScreen({super.key, required this.weeklyPlan});
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Checkout ${widget.weeklyPlan.description ?? "Custom Plan"}'),
      ),
      body: Container(
          // Add your checkout screen content here
          ),
    );
  }
}
