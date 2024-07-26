import 'dart:convert';

import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/order/order.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';

class OrderController {
  final RestApi api = RestApi();

  Future<String> CreateOrder(String userID, String note, String address,
      double lat, double long, double price, WeeklyPlan weeklyPlan) async {
    var value = await api.post(
        "api/order/create",
        Order(
                userId: userID,
                standerdWeeklyPlanId: weeklyPlan.id ?? "",
                note: note,
                longitude: long,
                latitude: lat,
                address: address,
                totalPrice: price,
                recipeList: weeklyPlan.recipePlans.toList())
            .toJson());

    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return jsonDecode(value.body)["data"];
      } else {
        return jsonDecode(value.body)["message"];
      }
    }
    return jsonDecode(value.body)["message"];
  }

  Future<List<OrderHistory>> GetOrderHistory(String userID) async {
    // var value = await api.get("api/order/get/$userID");
    // https://api.wemealkit.ddns.net/api/order/get-by-userid?userId=b1ddfd01-4093-4f83-5cb3-08dc7eefb10b
    var value = await api.get("api/order/get-by-userid?userId=$userID");
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        List<OrderHistory> orders = [];
        for (var item in jsonDecode(value.body)["data"]) {
          orders.add(OrderHistory.fromJson(item));
        }
        return orders;
      } else {
        return [];
      }
    }
    return [];
  }
}
