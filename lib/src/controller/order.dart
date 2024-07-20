import 'dart:convert';

import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/order/order.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';

class OrderController {
  final RestApi api = RestApi();

  Future<String> CreateOrder(String userID, String note, String address,
      double price, WeeklyPlan weeklyPlan) async {
    var value = await api.post(
        "api/order/create",
        Order(
                userId: userID,
                standerdWeeklyPlanId: weeklyPlan.id ?? "",
                note: note,
                address: address,
                totalPrice: price,
                recipeList: weeklyPlan.recipePlans.toList())
            .toJson());

    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return jsonDecode(value.body)["data"]["id"];
      } else {
        return jsonDecode(value.body)["message"];
      }
    }
    return jsonDecode(value.body)["message"];
  }
}
