import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:it_can_cook/src/models/account/account.dart';
import 'package:it_can_cook/src/screens/onboarding/onboarding.dart';
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
    Onboarding(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final accountState = context.watch<AccountBloc>()?.state;

    return LoaderOverlay(
        child: Scaffold(
      appBar: AppBar(
          title: const Text('WeMealKit',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            _currentIndex == 0
                ? GestureDetector(
                    onTap: () {
                      context.loaderOverlay.show();
                      context.read<WeeklyBloc>().add(FetchWeeklyEvent());
                      //delay 1s to show loading
                      Future.delayed(const Duration(seconds: 1), () {
                        context.loaderOverlay.hide();
                      });
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 123, 181, 210),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).get_newest_menu,
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ))
                : Text("")
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 6),
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
          )),
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
            icon: const Icon(Icons.history_rounded),
            label: S.of(context).history,
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
