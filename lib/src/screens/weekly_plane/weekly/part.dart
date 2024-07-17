import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/template_day.dart';

class Part extends StatefulWidget {
  final Recipe? recipe;

  const Part({Key? key, required this.recipe});
  @override
  _PartState createState() => _PartState();
}

class _PartState extends State<Part> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }
}

class MenuPart extends StatelessWidget {
  final String title;
  const MenuPart({Key? key, required this.title}) : super(key: key);

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
                menuItems: [],
              )),
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
