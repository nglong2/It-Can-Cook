import 'dart:convert';
import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:uuid/uuid.dart';

class WeeklyPlanController {
  final RestApi api = RestApi();

  Future<List<WeeklyPlan>> getWeeklys() async {
    var value = await api.get("api/weeklyplan/get-all");
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
    throw Exception('Failed to get recipes');
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
    return "Failed to create weekly";
  }

  Future<List<WeeklyPlan>> getWeeklyByCustomerId(String customerId) async {
    var value =
        await api.get("api/weeklyplan/get-by-customer-id?id=$customerId");
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
    throw Exception('Failed to get recipes');
  }

  //update weekly plan
  Future<String> updateWeeklyPlan(WeeklyPlan weeklyPlan) async {
    var data = await api.put(
        "api/weeklyplan/update-full-info", weeklyPlan.toJsonCreate());
    if (data.statusCode == 200) {
      if (jsonDecode(data.body)["statusCode"] == 200) {
        return jsonDecode(data.body)["message"];
      } else {
        return jsonDecode(data.body)["message"];
      }
    }
    return "Failed to update weekly";
  }
}
