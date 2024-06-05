import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_can_cook/src/screens/weekly_plane.dart/weekly/template_day.dart';

class Part extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuPart(title: 'Breakfast', menuItems: menu1),
        MenuPart(title: 'Lunch', menuItems: menu2),
        MenuPart(title: 'Dinner', menuItems: menu3),
      ],
    );
  }
}

class MenuPart extends StatelessWidget {
  final String title;
  final List<MenuItem> menuItems;
  const MenuPart({Key? key, required this.title, required this.menuItems})
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
                menuItems: menuItems,
              )),
          SizedBox(height: 4),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'dish_detail');
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

var menu1 = [
  MenuItem(
    title: 'Bun Bo Hue',
    imageUrl: '1.jpg',
    minutes: 60,
    persons: 4,
  ),
  MenuItem(
    title: 'Chao An Lien',
    imageUrl: '2.jpg',
    minutes: 120,
    persons: 4,
  ),
  MenuItem(
    title: 'Fresh Fruit',
    imageUrl: '3.png',
    minutes: 60,
    persons: 2,
  ),
];

var menu2 = [
  MenuItem(
    title: 'Hamburger',
    imageUrl: '4.png',
    minutes: 60,
    persons: 4,
  ),
  MenuItem(
    title: 'Chicken Pho',
    imageUrl: '5.png',
    minutes: 120,
    persons: 4,
  ),
  MenuItem(
    title: 'Fresh Fruit',
    imageUrl: '6.png',
    minutes: 60,
    persons: 2,
  ),
];
var menu3 = [
  MenuItem(
    title: 'Thit Bam',
    imageUrl: '7.png',
    minutes: 60,
    persons: 4,
  ),
  MenuItem(
    title: 'Com Suon',
    imageUrl: '8.png',
    minutes: 120,
    persons: 4,
  ),
  MenuItem(
    title: 'Com Chien',
    imageUrl: '9.png',
    minutes: 60,
    persons: 2,
  ),
];
