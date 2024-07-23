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
}
