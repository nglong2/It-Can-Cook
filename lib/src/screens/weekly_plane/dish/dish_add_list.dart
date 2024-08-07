import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/src/bloc/custom_plan/custom_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/recipe_plan/recipe_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class DishAddList extends StatefulWidget {
  final bool isShowAddButton;

  const DishAddList({super.key, required this.isShowAddButton});
  @override
  _DishAddListState createState() => _DishAddListState();
}

class _DishAddListState extends State<DishAddList> {
  @override
  Widget build(BuildContext context) {
    var systemBloc = context.watch<SystemBloc>().state;
    return BlocBuilder<RecipePlanBloc, List<RecipePlan>>(
      builder: (context, state) {
        return Column(
          children: [
            for (var recipe in state)
              Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                        onTap: () {
                          Navigator.pushNamed(context, 'dish_detail',
                              arguments: recipe);
                        },
                        title: Text(
                          recipe.recipe?.name ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          recipe.recipe?.description == null
                              ? ""
                              : recipe.recipe!.description!.length > 45
                                  ? '${recipe.recipe?.description?.substring(0, 45)}...'
                                  : recipe.recipe?.description ?? '',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              margin: const EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 190, 216, 191),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                  "${recipe.recipe?.price!.toStringAsFixed(0).replaceAllMapped(
                                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                        (Match m) => '${m[1]}.',
                                      )}đ"),
                            ),
                            widget.isShowAddButton
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.add_sharp,
                                      size: 33,
                                    ),
                                    onPressed: () async {
                                      context.read<CustomPlanBloc>().add(
                                          AddRecipePlanEvent(recipe,
                                              systemBloc.numberPersonInHouse));
                                      context
                                          .read<TriggerBloc>()
                                          .add(SeachTriggerEvent());

                                      Navigator.pop(context);
                                    },
                                  )
                                : Container(),
                          ],
                        )
                        //add to cart

                        ),
                    onTap: () async {
                      // context.read<WeeklyBloc>().add(AddRecipePlanEvent(
                      //     recipe, systemBloc.numberPersonInHouse));
                    },
                  ))
          ],
        );
      },
    );
  }
}
