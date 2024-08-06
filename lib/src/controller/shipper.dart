import 'dart:convert';
import 'dart:math';

import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/shipper/ordergroup.dart';
import 'package:it_can_cook/src/models/transactions/transaction.dart';

class ShipperController {
  final RestApi api = RestApi();

// curl -X 'GET' \
//   'https://api.wemealkit.ddns.net/api/order-group/get-all' \
//   -H 'accept: */*'

  Future<List<OrderGroup>> getAllOrderGroup(String userid) async {
    final response = await api.get('api/order-group/get-all');
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["statusCode"] == 200) {
        List<OrderGroup> orderGroups = [];
        for (var item in jsonDecode(response.body)["data"]) {
          orderGroups.add(OrderGroup.fromJson(item));
        }

        return orderGroups
            .where((element) => element.shipperId == userid)
            .toList();
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } else {
      return [];
    }
  }
}
