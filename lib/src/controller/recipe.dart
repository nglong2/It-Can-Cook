import 'dart:convert';

import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class RecipeController {
  final RestApi api = RestApi();

  Future<List<RecipePlan>> getRecipePlansByName(
      String name, bool status) async {
    if (name.isEmpty) {
      name = " ";
    }
    var value = await api.get("api/recipes/get-by-name/$name/$status");
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        List<Recipe> recipes = [];
        for (var item in jsonDecode(value.body)["data"]) {
          recipes.add(Recipe.fromJson(item));
        }

        var recipePlans = <RecipePlan>[];
        for (var recipe in recipes) {
          recipePlans.add(RecipePlan(
              recipeId: recipe.id, price: recipe.price, recipe: recipe));
        }

        return recipePlans;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }
    throw Exception('Failed to get recipes');
  }
}
