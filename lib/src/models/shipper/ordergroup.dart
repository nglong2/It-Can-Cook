import 'package:it_can_cook/src/models/order/history_order.dart';

class OrderGroup {
  String? id;
  String? shipperId;
  String? shipperUserName;
  String? location;
  String? asignAt;
  String? asignBy;
  int? status;
  List<OrderHistory> orders = [];

  OrderGroup(
      {this.id,
      this.shipperId,
      this.shipperUserName,
      this.location,
      this.asignAt,
      this.asignBy,
      this.status,
      required this.orders});

  factory OrderGroup.fromJson(Map<String, dynamic> json) {
    return OrderGroup(
      id: json['id'],
      shipperId: json['shipperId'],
      shipperUserName: json['shipperUserName'],
      location: json['location'],
      asignAt: json['asignAt'],
      asignBy: json['asignBy'],
      status: json['status'],
      orders: json['orders'] != null
          ? List<OrderHistory>.from(
              json['orders'].map((x) => OrderHistory.fromJson(x)))
          : [],
    );
  }
}
