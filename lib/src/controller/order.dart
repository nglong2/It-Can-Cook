import 'dart:convert';

import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/order/order.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:it_can_cook/src/models/zalopay/refund_response.dart';

class OrderController {
  final RestApi api = RestApi();
  final OutApi outApi = OutApi();

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
              longitude: lat,
              img: weeklyPlan.urlImage ?? "test",
              latitude: long,
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
        return orders.reversed.toList();
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

  // curl -X 'GET' \
  // 'https://api.wemealkit.ddns.net/api/order/get-order/e352e7d9-464d-4f97-f467-08dcb08d72f9' \
  // -H 'accept: */*' \

  Future<OrderHistory> GetOrder(String orderID) async {
    var value = await api.get("api/order/get-order/$orderID");
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return OrderHistory.fromJson(jsonDecode(value.body)["data"]);
      } else {
        return OrderHistory();
      }
    }
    return OrderHistory();
  }

  //refund zalopay  https://sb-openapi.Zalopay.vn/v2/refund

  Future<String> RefundOrder(Refund refund) async {
    var value = await outApi.post(
        "https://sb-openapi.zalopay.vn/v2/refund", refund.toJson());
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["return_code"] == 1) {
        return "Refund success";
      } else {
        return jsonDecode(value.body)["return_message"];
      }
    }
    return "Failed to refund";
  }

  //feedback
//   curl -X 'POST' \
//   'https://api.wemealkit.ddns.net/api/feedback/create' \
//   -H 'accept: */*' \
//   -H 'Content-Type: application/json' \
//   -d '{
//   "orderId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//   "rating": 1,
//   "description": "string",
//   "createdBy": "string"
// }'

  Future<String> FeedbackOrder(
      String orderID, int rating, String description, String createdBy) async {
    var body = {
      "orderId": orderID,
      "rating": rating,
      "description": description,
      "createdBy": createdBy
    };
    var value = await api.post("api/feedback/create", body);
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return jsonDecode(value.body)["message"];
      } else {
        return jsonDecode(value.body)["message"];
      }
    }
    return "Failed to feedback";
  }
}
