import 'package:flutter/material.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/tab_ingredient.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/tab_step.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/template_day.dart';

class DishDetail extends StatefulWidget {
  final Recipe recipe;

  const DishDetail({super.key, required this.recipe});
  @override
  _DishDetailState createState() => _DishDetailState();
}

class _DishDetailState extends State<DishDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipe.name ?? ''),
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
