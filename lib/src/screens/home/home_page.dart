import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/custom_plan/custom_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/order_bloc/order_bloc.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:it_can_cook/src/screens/recipes/recipe_list.dart';
import 'package:it_can_cook/src/screens/setting/setting.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/weekly.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WeeklyScreen(),
    const RecipeList(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final accountState = context.watch<AccountBloc>()?.state;
    if (accountState != null &&
        accountState.id != null &&
        accountState.id != "") {
      context
          .read<CustomPlanBloc>()
          .add(FetchCustomPlanEvent(accountState.id!));

      context.read<OrderBloc>().add(GetHistoryOrderEvent(accountState.id!));
    }

    return LoaderOverlay(
        child: Scaffold(
      appBar: AppBar(
          title: const Text('WeMealKit',
              style: TextStyle(fontWeight: FontWeight.bold)),
          leading: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration:
                      //color #02335a
                      const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF02335A)),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                onTap: () => () {
                  context.loaderOverlay.show();
                  context.read<WeeklyBloc>().add(FetchWeeklyEvent());
                  //delay 1s to show loading
                  Future.delayed(const Duration(seconds: 1), () {
                    context.loaderOverlay.hide();
                  });
                },
              ))),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.format_list_numbered_outlined),
            label: S.of(context).list,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).settings,
          ),
        ],
      ),
    ));
  }
}
