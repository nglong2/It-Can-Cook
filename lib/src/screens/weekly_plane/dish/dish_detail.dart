import 'package:flutter/material.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/tab_ingredient.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/tab_nutrion.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/tab_step.dart';

class DishDetail extends StatefulWidget {
  final RecipePlan recipe;

  const DishDetail({super.key, required this.recipe});
  @override
  _DishDetailState createState() => _DishDetailState();
}

class _DishDetailState extends State<DishDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipe.recipe?.name ?? ''),
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Row(
                children: widget.recipe.recipe!.recipeCategories
                    .map((e) => const Text(""))
                    .toList(),
              ),
              TabBar(
                tabs: [
                  Tab(text: S.current.detail),
                  Tab(text: S.current.ingredients),
                  Tab(text: S.current.step),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Ingredients tab content
                    NutrionTabWidget(recipe: widget.recipe.recipe!),
                    IngredientTabWidget(
                        ingredients: widget.recipe.recipe!.recipeIngredients),
                    // Steps tab content
                    StepTabWidget(
                      steps: widget.recipe.recipe!.recipeSteps,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
