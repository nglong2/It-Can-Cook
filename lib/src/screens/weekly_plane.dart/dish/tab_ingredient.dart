import 'package:flutter/material.dart';

class IngredientTabWidget extends StatefulWidget {
  @override
  _IngredientTabWidgetState createState() => _IngredientTabWidgetState();
}

class _IngredientTabWidgetState extends State<IngredientTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final step = ingredients[index];
          return ListTile(
            title:
                Text(step.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [step.quantity].map((desc) => Text("- $desc")).toList(),
            ),
            leading: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                step.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

//ingredient class with title and quantity and image
class Ingredient {
  final String title;
  final String quantity;
  final String imageUrl;

  Ingredient(
      {required this.title, required this.quantity, required this.imageUrl});
}

final List<Ingredient> ingredients = [
  Ingredient(
    title: "Beef Bones",
    quantity: "2 lbs x 2 person = 4 lbs",
    imageUrl: "assets/images/ingredientdemo/beef_bones.jpg",
  ),
  Ingredient(
    title: "Beef Slices",
    quantity: "1 lb x 2 person = 2 lbs",
    imageUrl: "assets/images/ingredientdemo/beef_slices.jpg",
  ),
  Ingredient(
    title: "Pork Blood",
    quantity: "1/2 cup x 2 person = 1 cup",
    imageUrl: "assets/images/ingredientdemo/pork_blood.jpg",
  ),
  Ingredient(
    title: "Lemongrass",
    quantity: "3 stalks x 2 person = 6 stalks",
    imageUrl: "assets/images/ingredientdemo/lemongrass.jpg",
  ),
  Ingredient(
    title: "Shallots",
    quantity: "5 bulbs x 2 person = 10 bulbs",
    imageUrl: "assets/images/ingredientdemo/shallots.jpg",
  ),
  Ingredient(
    title: "Rice Noodles",
    quantity: "1 lb x 2 person = 2 lbs",
    imageUrl: "assets/images/ingredientdemo/rice_noodles.jpg",
  ),
  Ingredient(
    title: "Banana Blossom",
    quantity: "1 bunch x 2 person = 2 bunches",
    imageUrl: "assets/images/ingredientdemo/banana_blossom.jpg",
  ),
  Ingredient(
    title: "Herbs (Mint, Cilantro)",
    quantity: "1 bunch x 2 person = 2 bunches",
    imageUrl: "assets/images/ingredientdemo/herbs.jpg",
  ),
  Ingredient(
    title: "Lime",
    quantity: "2 pieces x 2 person = 4 pieces",
    imageUrl: "assets/images/ingredientdemo/lime.jpg",
  ),
  Ingredient(
    title: "Bean Sprouts",
    quantity: "1 cup x 2 person = 2 cups",
    imageUrl: "assets/images/ingredientdemo/bean_sprouts.jpg",
  ),
  // Add more ingredients as needed
];
