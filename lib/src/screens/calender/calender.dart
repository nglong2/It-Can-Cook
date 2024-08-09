import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/order_bloc/order_bloc.dart';
import 'package:it_can_cook/src/bloc/recipe_all/recipes_all_bloc.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/home/home_page.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/part.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Add your calendar state variables here

  @override
  void initState() {
    super.initState();
    // Initialize your calendar state here
  }

  var selectedValue = OrderHistory();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<OrderBloc, List<OrderHistory>>(
      builder: (context, state) {
        var list =
            state.where((element) => element.status == "Processing").toList();
        var listAllRecipe = context.watch<RecipesAllBloc>().state ?? [];
        var listToday = list.where((element) {
          return checkDayInCurrentWeek(
              DateTime.parse(element.shipDate!).add(const Duration(days: 5)));
        }).toList();
        if (selectedValue.id == null && listToday.isNotEmpty) {
          selectedValue = listToday[0];
        }
        return listToday.isEmpty
            ? const HomePage()
            : Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            S.current.your_plan,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 124, 37, 223)),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //redirect to home screen
                            Navigator.pushNamedAndRemoveUntil(
                                context, "home", (route) => false);
                          },
                          child: Text(S.current.passed),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.menu_today,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        //selected
                        DropdownButton<OrderHistory>(
                          value: selectedValue,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: listToday.map((item) {
                            return DropdownMenuItem<OrderHistory>(
                              value: item,
                              child: Text(item.weeklyPlan?.title ?? ""),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (selectedValue.orderDetails.isNotEmpty)
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: SingleChildScrollView(
                              child: Part(
                                weeklyPlanId: selectedValue
                                        .orderDetails[0].standardWeeklyPlanId ??
                                    "",
                                dayInWeek: DateTime.now().weekday,
                                recipes: selectedValue.orderDetails
                                    .map((e) => RecipePlan(
                                          recipe: listAllRecipe
                                              .firstWhere((element) =>
                                                  element.recipeId ==
                                                  e.recipeId)
                                              .recipe,
                                          mealInDay: e.mealInDay,
                                          dayInWeek: e.dayInWeek,
                                          id: e.id,
                                          numberPerson: e.quantity,
                                          price: e.price,
                                          quantity: e.quantity,
                                          weeklyPlanId: e.standardWeeklyPlanId,
                                          standardWeeklyPlanId:
                                              e.standardWeeklyPlanId,
                                        ))
                                    .toList()
                                    .where((element) =>
                                        element.dayInWeek ==
                                        DateTime.now().weekday)
                                    .toList(),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
      },
    ));
  }
}

//function check datime does it in current week param is type Datetime checkday
bool checkDayInCurrentWeek(DateTime time) {
  var now = DateTime.now();
  var firstDayOfCurrentWeek = now.subtract(Duration(days: now.weekday - 1));
  var lastDayOfCurrentWeek =
      now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  return time.isAfter(firstDayOfCurrentWeek) &&
      time.isBefore(lastDayOfCurrentWeek);
}
