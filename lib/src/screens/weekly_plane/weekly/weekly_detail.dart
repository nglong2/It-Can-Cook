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
import 'package:it_can_cook/src/screens/weekly_plane/weekly/part.dart';
import 'package:loader_overlay/loader_overlay.dart';

class WeeklyDetailPage extends StatefulWidget {
  final WeeklyPlan weeklyPlan;
  const WeeklyDetailPage({super.key, required this.weeklyPlan});

  @override
  WeeklyDetailPageState createState() => WeeklyDetailPageState();
}

class WeeklyDetailPageState extends State<WeeklyDetailPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  //state //selected date

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 7,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    var systemBloc = context.watch<SystemBloc>().state;
    var accountBloc = context.watch<AccountBloc>().state;
    double pice = 0;

    for (var recipe in widget.weeklyPlan.recipePlans) {
      var numberPerson = recipe.numberPerson ?? systemBloc.numberPersonInHouse;
      pice += recipe.recipe!.price! * numberPerson;
    }

    return BlocListener<TriggerBloc, Trigger>(
        listener: (context, state) {},
        child: LoaderOverlay(
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.weeklyPlan.title ?? ""),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Visibility(
                  //       visible: true,
                  //       maintainSize: true,
                  //       maintainAnimation: true,
                  //       maintainState: true,
                  //       child: Text(
                  //         "${S.current.total} ${pice.toStringAsFixed(0).replaceAllMapped(
                  //               RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  //               (Match m) => '${m[1]}.',
                  //             )} vnđ",
                  //         style: const TextStyle(
                  //             fontSize: 18, fontWeight: FontWeight.bold),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 10),
                  accountBloc?.id != null
                      ? TextButton(
                          style: ButtonStyle(
                            //borderadius
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Color(0xFF02335A)))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF02335A)),
                          ),
                          onPressed: () async {
                            try {
                              context.loaderOverlay.show();
                              // var mess = await WeeklyPlanController()
                              //     .getWeeklyByCustomerId(accountBloc!.id!);
                              var mess = await WeeklyPlanController()
                                  .createWeeklyForCustom(
                                      accountBloc!.id!, widget.weeklyPlan);
                              context.loaderOverlay.hide();
                              //mess!=empty show popup
                              if (mess.isNotEmpty) {
                                if (mess == "OK") {
                                  context.read<CustomPlanBloc>().add(
                                      FetchCustomPlanEvent(accountBloc.id!));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(S.current.success),
                                        content: Text(S.current
                                            .add_to_custom_plan_success),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(S.current.back),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context)
                                                  .pushNamed("custom_plan");
                                            },
                                            child: Text(S.current
                                                .send_me_to_custom_plan),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: Text(mess),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                              context.loaderOverlay.hide();
                            } catch (e) {
                              //show popup error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          },
                          child: SizedBox(
                            height: 34,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                Text(
                                  S.of(context).add_to_quickly_plan,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ))

                      // TextButton(
                      //     style: ButtonStyle(
                      //       //borderadius
                      //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //           RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(10.0),
                      //               side: const BorderSide(color: Color(0xFF02335A)))),
                      //       backgroundColor: MaterialStateProperty.all<Color>(
                      //           const Color(0xFF02335A)),
                      //     ),
                      //     onPressed: () {
                      //       //go to "checkout"
                      //       Navigator.pushNamed(context, "checkout",
                      //           arguments: widget.weeklyPlan);
                      //       // Navigator.pop(context);
                      //     },
                      //     child: SizedBox(
                      //       height: 34,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const Icon(
                      //             Icons.shopping_cart_checkout_sharp,
                      //             color: Colors.white,
                      //           ),
                      //           Text(
                      //             S.of(context).add_to_cart,
                      //             style: const TextStyle(
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.white),
                      //           ),
                      //         ],
                      //       ),
                      //     ))
                      : Container()
                ],
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  controller: tabController,
                  isScrollable: true,
                  automaticIndicatorColorAdjustment: true,
                  tabs: [
                    Tab(text: S.current.monday),
                    Tab(text: S.current.tuesday),
                    Tab(text: S.current.wednesday),
                    Tab(text: S.current.thursday),
                    Tab(text: S.current.friday),
                    Tab(text: S.current.saturday),
                    Tab(text: S.current.sunday),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Part(
                        dayInWeek: 1,
                        weeklyPlanId: widget.weeklyPlan.id!,
                        recipes: widget.weeklyPlan.recipePlans
                            .where((element) => element.dayInWeek == 1)
                            .toList(),
                      ),
                      Part(
                        dayInWeek: 2,
                        weeklyPlanId: widget.weeklyPlan.id!,
                        recipes: widget.weeklyPlan.recipePlans
                            .where((element) => element.dayInWeek == 2)
                            .toList(),
                      ),
                      Part(
                        dayInWeek: 3,
                        weeklyPlanId: widget.weeklyPlan.id!,
                        recipes: widget.weeklyPlan.recipePlans
                            .where((element) => element.dayInWeek == 3)
                            .toList(),
                      ),
                      Part(
                        dayInWeek: 4,
                        weeklyPlanId: widget.weeklyPlan.id!,
                        recipes: widget.weeklyPlan.recipePlans
                            .where((element) => element.dayInWeek == 4)
                            .toList(),
                      ),
                      Part(
                        dayInWeek: 5,
                        weeklyPlanId: widget.weeklyPlan.id!,
                        recipes: widget.weeklyPlan.recipePlans
                            .where((element) => element.dayInWeek == 5)
                            .toList(),
                      ),
                      Part(
                        dayInWeek: 6,
                        weeklyPlanId: widget.weeklyPlan.id!,
                        recipes: widget.weeklyPlan.recipePlans
                            .where((element) => element.dayInWeek == 6)
                            .toList(),
                      ),
                      Part(
                        dayInWeek: 7,
                        weeklyPlanId: widget.weeklyPlan.id!,
                        recipes: widget.weeklyPlan.recipePlans
                            .where((element) => element.dayInWeek == 7)
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

int getCurrentWeekInMonth(DateTime time) {
  int firstDayOfMonth = DateTime(time.year, time.month, 1).weekday;
  int weekOfMonth = ((time.day + firstDayOfMonth - 1) / 7).ceil();
  return weekOfMonth;
}
