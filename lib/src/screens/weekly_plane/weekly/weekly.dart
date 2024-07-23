import 'dart:async';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:it_can_cook/src/controller/weekly.dart';
import 'package:it_can_cook/src/models/account/account.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/weekly_list.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:uuid/uuid.dart';

class WeeklyScreen extends StatefulWidget {
  @override
  WeeklyScreenState createState() => WeeklyScreenState();
}

class WeeklyScreenState extends State<WeeklyScreen> {
  late Future<List<Recipe>> recipe;
  @override
  void initState() {
    //get Recipe from API
    super.initState();
  }

  @override
  void dispose() {
    // Restore the system overlays when the screen is disposed

    super.dispose();
  }

  Timer? _debounce;
  _onSearchChanged(String query, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<WeeklyBloc>().add(SearchWeeklyPlanEvent(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final accountstate = context.watch<AccountBloc>().state;

    return Scaffold(
        body: LoaderOverlay(
      child: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: SingleChildScrollView(
          key: UniqueKey(),
          scrollDirection: Axis.vertical,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${S.of(context).hello} ${accountstate?.lastName ?? ""} ${accountstate?.firstName ?? ""}!",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Have a nice day 👋",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                renderSearch(),
                WeeklyList()
              ]),
        ),
      ),
    ));
  }

//input search widget

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
          onChanged: (query) => _onSearchChanged(query, context)),
    );
  }
}

//function render Card demo for  5 items have image save at assets\images\weekly-demo\1.png ...
// return List Card() widget

