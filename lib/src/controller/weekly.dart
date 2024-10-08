import 'dart:convert';
import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';

class WeeklyPlanController {
  final RestApi api = RestApi();

  Future<List<WeeklyPlan>> getWeeklys(String name) async {
    var value = await api.get("api/weeklyplan/get-all/?name=$name");
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        List<WeeklyPlan> recipes = [];
        for (var item in jsonDecode(value.body)["data"]) {
          recipes.add(WeeklyPlan.fromJson(item));
        }
        return recipes;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }
    throw Exception(jsonDecode(value.body)["message"]);
  }

  Future<String> createWeeklyForCustom(
      String userId, WeeklyPlan weeklyPlan) async {
    weeklyPlan.createdBy = userId;
    var data = await api.post(
        "api/weeklyplan/create-for-customer", weeklyPlan.toJsonCreate());
    if (data.statusCode == 200) {
      if (jsonDecode(data.body)["statusCode"] == 200) {
        return jsonDecode(data.body)["message"];
      } else {
        return jsonDecode(data.body)["message"];
      }
    }
    return jsonDecode(data.body)["message"];
  }

  Future<List<WeeklyPlan>> getWeeklyByCustomerId(String customerId) async {
    var value = await api.get("api/weeklyplan/get-by-customer-id/$customerId");
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        List<WeeklyPlan> recipes = [];
        for (var item in jsonDecode(value.body)["data"]) {
          recipes.add(WeeklyPlan.fromJson(item));
        }
        return recipes.reversed.toList();
      }
      return [];
    }
    return [];
  }

  //update weekly plan
  Future<String> updateWeeklyPlan(WeeklyPlan weeklyPlan) async {
    var data = await api.put("api/weeklyplan/update-full-info/${weeklyPlan.id}",
        weeklyPlan.toJsonCreate());
    if (data.statusCode == 200) {
      if (jsonDecode(data.body)["statusCode"] == 200) {
        return jsonDecode(data.body)["message"];
      } else {
        return jsonDecode(data.body)["message"];
      }
    }
    return jsonDecode(data.body)["message"];
  }

// curl -X 'DELETE' \
//   'https://api.wemealkit.ddns.net/api/weeklyplan/delete/85cc8c8a-8c6e-4624-f40c-08dcb1334769' \
//   -H 'accept: */*'

  Future<String> deleteWeeklyPlan(String id) async {
    var data = await api.delete("api/weeklyplan/delete/$id");
    if (data.statusCode == 200) {
      if (jsonDecode(data.body)["statusCode"] == 200) {
        return jsonDecode(data.body)["message"];
      } else {
        return jsonDecode(data.body)["message"];
      }
    }
    return jsonDecode(data.body)["message"];
  }
}
