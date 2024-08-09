import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:uuid/v5.dart';

class CheckoutScreen extends StatefulWidget {
  final WeeklyPlan weeklyPlan;

  const CheckoutScreen({super.key, required this.weeklyPlan});
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    var listDayinweek =
        widget.weeklyPlan.recipePlans.map((e) => e.dayInWeek).toSet().toList();

    //distinct
    var systemBloc = context.watch<SystemBloc>().state;
    var currentNumberPerson = systemBloc.numberPersonInHouse;

    double pice = 0;

    for (var recipe in widget.weeklyPlan.recipePlans) {
      var numberPerson = recipe.numberPerson ?? systemBloc.numberPersonInHouse;
      pice += recipe.price! * numberPerson;
    }

    return Scaffold(
        appBar: AppBar(
          title: widget.weeklyPlan.id == UuidV5.NAMESPACE_NIL
              ? const Text("Custom Plan + ")
              : Text(
                  'Checkout ${widget.weeklyPlan.description ?? "Custom Plan"}'),
        ),
        body: Container(
          padding:
              const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 80),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                //center
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.weeklyPlan.urlImage ?? "",
                    width: 100,
                    height: 100,
                    //circle image
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Text(
                    '${widget.weeklyPlan.title}',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: listDayinweek
                    .map(
                      (e) => ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          getDayInWeek(e!).toString(),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        children: widget.weeklyPlan.recipePlans
                            .where((element) => element.dayInWeek == e)
                            .map(
                              (item) => Container(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: item.recipe?.img ?? "",
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${item.recipe?.name}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                              ExpansionTile(
                                                title:
                                                    Text(S.current.ingredients),
                                                children: item
                                                    .recipe!.recipeIngredients
                                                    .map((e) => Text(
                                                        "${e.ingredient?.name} x ${e.amount} ${e.ingredient?.unit}"))
                                                    .toList(),
                                              )
                                              //price
                                              // Text(
                                              //   "${item.recipe?.price?.toStringAsFixed(0).replaceAllMapped(
                                              //         RegExp(
                                              //             r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              //         (Match m) => '${m[1]},',
                                              //       )} vnđ /1 ${S.current.person} x ${item.numberPerson ?? currentNumberPerson}",
                                              //   style: TextStyle(
                                              //     fontWeight: FontWeight.normal,
                                              //     fontSize: 14,
                                              //     color: Colors.grey[600],
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        child: Text(
                                      "${item.recipe?.price?.toStringAsFixed(0).replaceAllMapped(
                                            RegExp(
                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                            (Match m) => '${m[1]},',
                                          )} vnđ x ${item.numberPerson ?? currentNumberPerson} ${S.current.person} ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                    .toList(),
              )
            ],
          )),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 30),
          color: Colors.white,
          child: Text(
            "Total price: ${pice.toStringAsFixed(0).replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]}.',
                )} vnđ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        bottomSheet: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 6, 73, 127)),
            ),
            onPressed: () {
              //go to "checkout"
              Navigator.pushNamed(context, "checkout1",
                  arguments: widget.weeklyPlan);
              // Navigator.pop(context);
            },
            child: const Center(
              child: Text("Continue"),
            ),
          ),
        ));
  }

  String getDayInWeek(int dayInWeek) {
    switch (dayInWeek) {
      case 1:
        return S.current.monday;
      case 2:
        return S.current.tuesday;
      case 3:
        return S.current.wednesday;
      case 4:
        return S.current.thursday;
      case 5:
        return S.current.friday;
      case 6:
        return S.current.saturday;
      case 7:
        return S.current.sunday;
      default:
        return '';
    }
  }

  String getMealInDay(int mealInDay) {
    switch (mealInDay) {
      case 1:
        return S.current.breakfast;
      case 2:
        return S.current.lunch;
      case 3:
        return S.current.dinner;
      default:
        return '';
    }
  }
}
