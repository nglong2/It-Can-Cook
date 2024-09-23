import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/custom_plan/custom_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:intl/intl.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/controller/weekly.dart';
import 'package:it_can_cook/src/models/system/trigger.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:it_can_cook/src/screens/weekly_plan_custom/part.dart';
import 'package:loader_overlay/loader_overlay.dart';

class WeeklyCustomDetailPage extends StatefulWidget {
  final WeeklyPlan weeklyPlan;
  const WeeklyCustomDetailPage({super.key, required this.weeklyPlan});

  @override
  WeeklyCustomDetailPageState createState() => WeeklyCustomDetailPageState();
}

class WeeklyCustomDetailPageState extends State<WeeklyCustomDetailPage> {
  //state //selected date
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    var systemBloc = context.watch<SystemBloc>().state;
    var accountBloc = context.watch<AccountBloc>().state;
    double pice = 0;

    for (var recipe in widget.weeklyPlan.recipePlans) {
      var numberPerson = recipe.numberPerson ?? systemBloc.numberPersonInHouse;
      pice += recipe.recipe!.price! * numberPerson;
    }
    DateTime today = DateTime.now();
    DateTime nextWeek = getNextWeek(today.add(const Duration(days: 1)));

    print("Next week: ${nextWeek.day} of ${nextWeek.month}");
    return BlocListener<TriggerBloc, Trigger>(listener: (context, state) {
      setState(() {
        _selectedValue = _selectedValue;
      });
    }, child: BlocBuilder<CustomPlanBloc, CustomPlanState>(
      builder: (context, state) {
        if (state is CustomPlanLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CustomPlanLoaded) {
          var weeklyPlan = state.weeklyPlans
              .firstWhere((element) => element.id == widget.weeklyPlan.id);
          return LoaderOverlay(
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.weeklyPlan.title ?? ""),
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                              //borderadius
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      side: const BorderSide())),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 182, 208, 230)),
                            ),
                            onPressed: () => {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(S.current.update_plan),
                                        content: Text(
                                            S.current.update_plan_confirmation),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(S.current.cancel)),
                                          TextButton(
                                              onPressed: () async {
                                                context.loaderOverlay.show();
                                                for (var recipePlan
                                                    in weeklyPlan.recipePlans) {
                                                  var numberPerson = recipePlan
                                                          .numberPerson ??
                                                      systemBloc
                                                          .numberPersonInHouse;
                                                  recipePlan.numberPerson =
                                                      numberPerson;
                                                  recipePlan.quantity = 1;
                                                }
                                                var data =
                                                    await WeeklyPlanController()
                                                        .updateWeeklyPlan(
                                                            weeklyPlan);
                                                if (context.mounted) {
                                                  context.loaderOverlay.hide();
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(data)));
                                                }
                                              },
                                              child:
                                                  Text(S.current.update_plan))
                                        ],
                                      );
                                    },
                                  )
                                },
                            child: Text(S.current.update_plan))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [],
                        ),
                        Visibility(
                          visible: true,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Text(
                            "${S.current.total} ${pice.toStringAsFixed(0).replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]}.',
                                )} vnđ",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                        style: ButtonStyle(
                          //borderadius
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Color(0xFF02335A)))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF02335A)),
                        ),
                        onPressed: () {
                          //go to "checkout"
                          Navigator.pushNamed(context, "checkout",
                              arguments: widget.weeklyPlan);
                          // Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 34,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_cart_checkout_sharp,
                                color: Colors.white,
                              ),
                              Text(
                                S.of(context).add_to_cart,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          // get moth name
                          S.current.week + " 1" + " 10/2024",

                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 1.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          height: 100,
                          width: 75,
                          daysCount: 7,
                          locale: //get current locale
                              Localizations.localeOf(context).languageCode,
                          DateTime.now().add(Duration(
                              days: DateTime.monday -
                                  DateTime.now().weekday +
                                  7)),
                          initialSelectedDate: DateTime.now().add(Duration(
                              days: DateTime.monday -
                                  DateTime.now().weekday +
                                  7)),
                          selectionColor:
                              const Color(0xFF02335A).withOpacity(0.8),
                          selectedTextColor: Colors.white,
                          dayTextStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                          monthTextStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                          dateTextStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                          onDateChange: (date) {
                            setState(() {
                              _selectedValue = date.weekday;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 422,
                    child: SingleChildScrollView(
                      child: PartCustom(
                        dayInWeek: _selectedValue,
                        weeklyPlanId: widget.weeklyPlan.id!,
                        recipes: weeklyPlan.recipePlans
                            .where((element) =>
                                element.dayInWeek == _selectedValue)
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    ));
  }
}

int getCurrentWeekInMonth(DateTime time) {
  // Get the first day of the month
  DateTime firstDayOfMonth = DateTime(time.year, time.month, 1);

  // Get the weekday of the first day of the month (1 = Monday, ..., 7 = Sunday)
  int firstDayWeekday = firstDayOfMonth.weekday;

  // Calculate the offset to the first Monday (or first day of the week)
  int offset = firstDayWeekday - 1;

  // Calculate the week number
  int weekOfMonth = ((time.day + offset) / 7).ceil();

  return weekOfMonth;
}

DateTime getNextWeek(DateTime date) {
  // Get the first day of the current month
  DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);

  // Get the day of the week for the first day of the month (1 = Monday, 7 = Sunday)
  int firstDayWeekday = firstDayOfMonth.weekday;

  // Calculate the current week of the month
  int currentWeek = ((date.day + firstDayWeekday - 1) / 7).ceil();

  // Get the total number of days in the current month
  DateTime nextMonth = DateTime(date.year, date.month + 1, 1);
  int totalDaysInMonth = nextMonth.subtract(Duration(days: 1)).day;

  // Calculate total weeks in the current month
  int totalWeeksInMonth = ((totalDaysInMonth + firstDayWeekday - 1) / 7).ceil();

  // Calculate the next week
  int nextWeek = currentWeek + 1;

  // If the next week exceeds the total weeks in the current month, move to the first week of the next month
  if (nextWeek > totalWeeksInMonth) {
    nextWeek = 1; // First week of the next month
    date = DateTime(date.year, date.month + 1, 1); // Move to the next month
  }

  // Return the week and the corresponding month
  return DateTime(date.year, date.month, nextWeek);
}
