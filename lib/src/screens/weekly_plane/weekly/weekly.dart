import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/categry/category_bloc.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/weekly_list.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

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

  var _selectedCates = <Cates?>[];

  @override
  Widget build(BuildContext context) {
    final accountstate = context.watch<AccountBloc>().state;
    var category = context.watch<CategoryBloc>().state;

    List<Cates> cates = category!
        .map((e) => Cates(id: Random().nextInt(2222), name: e.name ?? "tét"))
        .toList();

    final _items = cates
        .map((animal) => MultiSelectItem<Cates?>(animal, "#${animal.name}"))
        .toList();

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
                renderSearch(_items),
                const WeeklyList()
              ]),
        ),
      ),
    ));
  }

//input search widget

  Widget renderSearch(List<MultiSelectItem<Cates?>> _items) {
    //textfield seach input have iconseach and can debounce search
    return MultiSelectChipField<Cates?>(
      items: _items,
      scroll: true,
      icon: const Icon(Icons.check),
      title: Text(S.current.category,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white70)),
      headerColor: Colors.black38,
      onTap: (values) {
        _selectedCates = values;
        var listSearch = [];
        for (var item in _selectedCates) {
          listSearch.add(item!.name.replaceAll("#", ""));
        }
        _onSearchChanged(listSearch.join(","), context);
      },
    );
  }
}

class Cates {
  final int id;
  final String name;

  Cates({
    required this.id,
    required this.name,
  });
}
//function render Card demo for  5 items have image save at assets\images\weekly-demo\1.png ...
// return List Card() widget

