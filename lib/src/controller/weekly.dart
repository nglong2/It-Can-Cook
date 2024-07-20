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
        var emplyPlan = WeeklyPlan(
            id: Uuid.NAMESPACE_NIL,
            title: "Custom Plan +",
            urlImage:
                'https://wemealkit.s3.amazonaws.com/369Plus_icon-icons.com_71848.png',
            description:
                "If you cant find any plan, you can create your own, we can provide you the recipe, it's easy",
            recipePlans: []);

        recipes.add(emplyPlan);

        return recipes;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }
    throw Exception('Failed to get recipes');
  }
}
