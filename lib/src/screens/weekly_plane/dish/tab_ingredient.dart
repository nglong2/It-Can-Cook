import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class IngredientTabWidget extends StatefulWidget {
  final List<RecipeIngredient> ingredients;

  const IngredientTabWidget({super.key, required this.ingredients});

  @override
  _IngredientTabWidgetState createState() => _IngredientTabWidgetState();
}

class _IngredientTabWidgetState extends State<IngredientTabWidget> {
  @override
  Widget build(BuildContext context) {
    var systemBloc = context.watch<SystemBloc>().state;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      child: ListView.builder(
        itemCount: widget.ingredients.length,
        itemBuilder: (context, index) {
          final step = widget.ingredients[index];
          return ListTile(
            title: Text(step.ingredient?.name ?? "name",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.pakaging_method,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Flexible(child: Text("${step.ingredient?.packagingMethod}"))
                  ],
                ),
                const SizedBox(
                  width: 12,
                  height: 12,
                ),
                //preservationMethod
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.preservationMethod,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Flexible(
                        child: Text("${step.ingredient?.preservationMethod}"))
                  ],
                ),
                const SizedBox(
                  width: 10,
                  height: 10,
                ),
                Row(
                  children: [
                    Text("${S.current.amount} ${step.amount} "),
                    Text("${step.ingredient?.unit}"),
                  ],
                ),
                ExpansionTile(
                  title: Text(S.current.nutrition_facts),
                  backgroundColor: Colors.grey[200],
                  collapsedBackgroundColor: Colors.grey[200],
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "Calo: ${step.ingredient?.ingredientNutrient?.calories ?? 0} kcal"),
                        Text(
                            "Protein: ${step.ingredient?.ingredientNutrient?.protein ?? 0} g"),
                        Text(
                            "${S.current.total_fat}: ${step.ingredient?.ingredientNutrient?.fat ?? 0} g"),
                        //sugar
                        Text(
                            "${S.current.sugars}: ${step.ingredient?.ingredientNutrient?.sugar ?? 0} g"),
                        Text(
                            "${S.current.sodium}: ${step.ingredient?.ingredientNutrient?.sodium ?? 0} mg"),
                        Text(
                            "${S.current.total_carbohydrate}: ${step.ingredient?.ingredientNutrient?.carbonhydrate ?? 0} g"),
                      ],
                    )
                  ],
                ),
              ],
            ),
            leading: SizedBox(
                child: GestureDetector(
              child: CachedNetworkImage(
                imageUrl: step.ingredient?.img ?? "",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              onTap: () => {
                //show modal bottom sheet
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: step.ingredient?.img ?? "",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                )
              },
            )),
          );
        },
      ),
    );
  }
}
