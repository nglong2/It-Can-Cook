import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/recipe_all/recipes_all_bloc.dart';
import 'package:it_can_cook/src/bloc/recipe_plan/recipe_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/models/system/trigger.dart';
import 'package:it_can_cook/src/models/weekly/dish.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/recipes/dish_recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/dish_add_list.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});
  @override
  _RecipeListState createState() => _RecipeListState();
}

Timer? _debounce;
_onSearchChanged(String query, BuildContext context, RecipeList widget) {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    context.read<RecipesAllBloc>().add(SearchRecipesAllEvent(query));
  });
}

@override
void initState() {}
@override
void dispose() {
  _debounce?.cancel();
}

class _RecipeListState extends State<RecipeList> {
  String dishName = '';
  String dishDescription = '';
  double dishPrice = 0.0;
  var recipePlanState = List<RecipePlan>.empty();
  @override
  Widget build(BuildContext context) {
    //renderlist recipePlanState
    recipePlanState = context.watch<RecipesAllBloc>().state;
    return Scaffold(
        appBar: AppBar(title: Text(S.current.list)),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  renderSearch(),
                  const DishAddRecipeAllList(
                    isShowAddButton: false,
                  )
                ],
              ),
            )));
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
}
