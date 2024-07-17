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
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: ListView.builder(
        itemCount: widget.ingredients.length,
        itemBuilder: (context, index) {
          final step = widget.ingredients[index];
          return ListTile(
            title: Text(step.ingredient?.name ?? "name",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("${S.current.amount} ${step.amount} "),
                    Text("x"),
                    Text(systemBloc.numberPersonInHouse.toString()),
                    Text("= "),
                    Text("${step.amount! * systemBloc.numberPersonInHouse} "),
                    Text("${step.ingredient?.unit}"),
                  ],
                )
              ],
            ),
            leading: SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: step.ingredient?.img ?? "",
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
