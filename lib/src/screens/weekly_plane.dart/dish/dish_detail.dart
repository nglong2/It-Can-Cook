import 'package:flutter/material.dart';
import 'package:it_can_cook/src/models/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane.dart/dish/tab_ingredient.dart';
import 'package:it_can_cook/src/screens/weekly_plane.dart/dish/tab_step.dart';
import 'package:it_can_cook/src/screens/weekly_plane.dart/weekly/template_day.dart';

class DishDetail extends StatefulWidget {
  final RecipeModel menuItem;

  const DishDetail({super.key, required this.menuItem});
  @override
  _DishDetailState createState() => _DishDetailState();
}

class _DishDetailState extends State<DishDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.menuItem.name ?? ''),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              TabBar(
                tabs: [
                  Tab(text: 'Ingredients'),
                  Tab(text: 'Steps'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Ingredients tab content
                    Container(
                      child: IngredientTabWidget(),
                    ),
                    // Steps tab content
                    Container(
                      child: StepTabWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
