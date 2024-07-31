import 'dart:convert';

import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/order/order.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';

class OrderController {
  final RestApi api = RestApi();

  Future<String> CreateOrder(
      String userID,
      String receiveName,
      String receivePhone,
      int transactionType,
      String note,
      String address,
      double lat,
      double long,
      double price,
      WeeklyPlan weeklyPlan) async {
    try {
      var body = Order(
              userId: userID,
              receiveName: receiveName,
              receivePhone: receivePhone,
              transactionType: transactionType,
              standerdWeeklyPlanId: weeklyPlan.id ?? "",
              note: note,
              longitude: long,
              img: weeklyPlan.urlImage ?? "test",
              latitude: lat,
              address: address,
              totalPrice: price,
              recipeList: weeklyPlan.recipePlans.toList())
          .toJson();
      var value = await api.post("api/order/create", body);

      if (value.statusCode == 200) {
        if (jsonDecode(value.body)["statusCode"] == 200) {
          return jsonDecode(value.body)["data"];
        } else {
          return jsonDecode(value.body)["message"];
        }
      }
      return jsonDecode(value.body)["message"];
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<OrderHistory>> GetOrderHistory(String userID) async {
    // var value = await api.get("api/order/get/$userID");
    // https://api.wemealkit.ddns.net/api/order/get-by-userid?userId=b1ddfd01-4093-4f83-5cb3-08dc7eefb10b
    var value = await api.get("api/order/get-by-userid/$userID");
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

// curl -X 'PUT' \
//   'https://api.wemealkit.ddns.net/api/order/change-status/97C52DCE-9A2C-465F-E85B-08DCB136598F?Status=0' \
//   -H 'accept: */*'

  Future<String> ChangeOrderStatus(String orderID, int status) async {
    var value =
        await api.put("api/order/change-status/$orderID?Status=$status", {});
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return jsonDecode(value.body)["message"];
      } else {
        return jsonDecode(value.body)["message"];
      }
    }
    return "Failed to change status";
  }
}
