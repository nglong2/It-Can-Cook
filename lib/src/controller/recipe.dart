import 'dart:convert';
import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/account.dart';
import 'package:it_can_cook/src/models/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeController {
  final RestApi api = RestApi();

  Future<List<RecipeModel>> getRecipes() async {
    var value = await api.get("api/recipes/get-all");
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        List<RecipeModel> recipes = [];
        for (var item in jsonDecode(value.body)["list"]) {
          recipes.add(RecipeModel.fromJson(item));
        }
        return recipes;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }
    throw Exception('Failed to get recipes');
  }
}
