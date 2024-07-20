import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/recipe_plan/recipe_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:it_can_cook/src/models/system/trigger.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class DishAddList extends StatefulWidget {
  @override
  _DishAddListState createState() => _DishAddListState();
}

class _DishAddListState extends State<DishAddList> {
  @override
  Widget build(BuildContext context) {
    var systemBloc = context.watch<SystemBloc>().state;
    return BlocBuilder<RecipePlanBloc, List<RecipePlan>>(
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              for (var recipe in state)
                Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: GestureDetector(
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: recipe.recipe?.img ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(recipe.recipe?.name ?? ''),
                        subtitle: Text(recipe.recipe?.description ?? ''),
                        trailing: Text(
                            "${recipe.recipe?.price!.toStringAsFixed(0).replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]}.',
                                )} vnđ"),
                      ),
                      onTap: () async {
                        context.read<WeeklyBloc>().add(AddRecipePlanEvent(
                            recipe, systemBloc.numberPersonInHouse));
                        context.read<TriggerBloc>().add(SeachTriggerEvent());
                        Navigator.pop(context);
                      },
                    ))
            ],
          ),
        );
      },
    );
  }
}
