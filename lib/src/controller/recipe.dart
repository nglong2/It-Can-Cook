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
    throw Exception(jsonDecode(value.body)["message"]);
  }

  // var data = api.get("api/categories/get-all").then((value) {
  //   if (value.statusCode == 200) {
  //     if (jsonDecode(value.body)["statusCode"] == 200) {
  //       for (var item in jsonDecode(value.body)["data"]) {
  //        var categet = Category.fromJson(item);
  //         if (categet.name == null) continue;
  //         if (cates.indexWhere((element) => element.name == categet.name) == -1) {
  //           cates.add(Cates(id: 6, name: categet.name!));
  //       }
  //     }
  //   }
  // });

  Future<List<Category>> getCategories() async {
    var value = await api.get("api/categories/get-all");
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        List<Category> categories = [];
        for (var item in jsonDecode(value.body)["data"]) {
          categories.add(Category.fromJson(item));
        }
        return categories;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }
    throw Exception(jsonDecode(value.body)["message"]);
  }
}
