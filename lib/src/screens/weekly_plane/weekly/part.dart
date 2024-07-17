import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/template_day.dart';

class Part extends StatefulWidget {
  final int dayInWeek;
  final List<RecipePlan> recipes;

  const Part({Key? key, required this.recipes, required this.dayInWeek});
  @override
  _PartState createState() => _PartState();
}

class _PartState extends State<Part> {
  @override
  Widget build(BuildContext context) {
    var beakfast =
        widget.recipes.where((element) => element.mealInDay == 1).toList();
    var lunch =
        widget.recipes.where((element) => element.mealInDay == 2).toList();
    var dinner =
        widget.recipes.where((element) => element.mealInDay == 3).toList();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MenuPart(title: "Breakfast", recipesPart: beakfast),
          MenuPart(title: "Lunch", recipesPart: lunch),
          MenuPart(title: "Dinner", recipesPart: dinner),
        ]);
  }
}

class MenuPart extends StatelessWidget {
  final String title;
  final List<RecipePlan> recipesPart;
  const MenuPart({Key? key, required this.title, required this.recipesPart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              //uppercase
            ),
          ),
          SizedBox(height: 8),
          Container(
              width: MediaQuery.of(context).size.width - 20,
              child: TemplateDay(
                  recipesParts: recipesPart.map((e) => e.recipe!).toList())),
          SizedBox(height: 4),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'dish_detail', arguments: []);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      size: 35,
                    ),
                    Text("Add Dishes")
                  ],
                ),
              ))
          //devide line
        ],
      ),
    );
  }
}
