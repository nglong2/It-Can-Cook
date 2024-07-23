import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class NutrionTabWidget extends StatefulWidget {
  final Recipe recipe;

  const NutrionTabWidget({super.key, required this.recipe});
  @override
  _NutrionTabWidgetState createState() => _NutrionTabWidgetState();
}

class _NutrionTabWidgetState extends State<NutrionTabWidget> {
  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.recipe.img ?? "",
              height: 200,
              width: //200,
                  MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Row(
              children: widget.recipe.recipeCategories!
                  .map((e) => Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 5, top: 5),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 141, 170, 250),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(e.category?.name ?? ""),
                      ))
                  .toList(),
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "✦ ${widget.recipe.name}",
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                        wordSpacing: 1),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(child: Text(widget.recipe.description ?? ""))
              ],
            ),
            Row(
              children: [
                Text(
                  S.current.nutrition_facts,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              //start
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          S.current.serving_size,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${widget.recipe.servingSize}" +
                              " " +
                              S.current.person,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "• Calories: ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                            "${widget.recipe.recipeNutrient?.calories?.floorToDouble().toString()}" +
                                " kcal"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "• ${S.current.total_fat}: ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${widget.recipe.recipeNutrient?.fat?.floorToDouble()}" +
                                " g"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "• ${S.current.sodium}: ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${widget.recipe.recipeNutrient?.sodium?.floorToDouble()} mg"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "• ${S.current.total_carbohydrate}: ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${widget.recipe.recipeNutrient?.carbonhydrate?.floorToDouble()} g"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("• ${S.current.dietary_fiber}: ",
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        Text(
                            "${widget.recipe.recipeNutrient?.dietaryFiber?.floorToDouble()} g"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("• ${S.current.sugars}: ",
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        Text(
                            "${widget.recipe.recipeNutrient?.sugar?.floorToDouble()} g"),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("• Protein: ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Text(
                            "${widget.recipe.recipeNutrient?.protein?.floorToDouble()} g"),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
