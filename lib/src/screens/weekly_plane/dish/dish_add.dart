import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/recipe_plan/recipe_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/models/system/trigger.dart';
import 'package:it_can_cook/src/models/weekly/dish.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/dish_add_list.dart';

class DishAdd extends StatefulWidget {
  final DishArguments args;

  const DishAdd({super.key, required this.args});
  @override
  _DishAddState createState() => _DishAddState();
}

Timer? _debounce;
_onSearchChanged(String query, BuildContext context, DishAdd widget) {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    context.read<RecipePlanBloc>().add(FetchRecipePlanEvent(
        query,
        false,
        widget.args.dayInWeek,
        widget.args.mealInDay,
        widget.args.weeklyPlanId));
    context.read<TriggerBloc>().add(SeachTriggerEvent());
  });
}

@override
void initState() {}
@override
void dispose() {
  _debounce?.cancel();
}

class _DishAddState extends State<DishAdd> {
  String dishName = '';
  String dishDescription = '';
  double dishPrice = 0.0;
  var recipePlanState = List<RecipePlan>.empty();
  @override
  Widget build(BuildContext context) {
    //renderlist recipePlanState
    recipePlanState = context.watch<RecipePlanBloc>().state;
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Add Dish for weeekid ${widget.args.weeklyPlanId} ${widget.args.dayInWeek} part ${widget.args.mealInDay}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [renderSearch(), DishAddList()],
          ),
        ));
  }

  Widget renderSearch() {
    //textfield seach input have iconseach and can debounce search

    return Container(
      padding: const EdgeInsets.only(right: 0, bottom: 10),
      child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: S.current.search,
            prefixIcon: IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.search),
            ),
          ),
          onChanged: (query) => _onSearchChanged(query, context, widget)),
    );
  }

  // var recipePlanState = context.watch<RecipePlanBloc>().state;
  //   //renderlist recipePlanState
}
