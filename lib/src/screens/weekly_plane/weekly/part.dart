import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/template_day.dart';

class Part extends StatefulWidget {
  final int dayInWeek;
  final String weeklyPlanId;
  final List<RecipePlan> recipes;

  const Part(
      {super.key,
      required this.recipes,
      required this.dayInWeek,
      required this.weeklyPlanId});
  @override
  _PartState createState() => _PartState();
}

class _PartState extends State<Part> {
  @override
  Widget build(BuildContext context) {
    var beakfast =
        widget.recipes.where((element) => element.mealInDay == 1).toList();
    var lunch =
        widget.recipes.where((element) => element.mealInDay == 2).toList();
    var dinner =
        widget.recipes.where((element) => element.mealInDay == 3).toList();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MenuPart(
              title: S.current.breakfast,
              recipesPart: beakfast,
              dayInWeek: widget.dayInWeek,
              weeklyPlanId: widget.weeklyPlanId,
              mealInDay: 1),
          MenuPart(
              title: S.current.lunch,
              recipesPart: lunch,
              weeklyPlanId: widget.weeklyPlanId,
              dayInWeek: widget.dayInWeek,
              mealInDay: 2),
          MenuPart(
              title: S.current.dinner,
              weeklyPlanId: widget.weeklyPlanId,
              recipesPart: dinner,
              dayInWeek: widget.dayInWeek,
              mealInDay: 3),
        ]);
  }
}

class MenuPart extends StatelessWidget {
  final String title;
  final List<RecipePlan> recipesPart;
  final int dayInWeek;
  final int mealInDay;
  final String weeklyPlanId;
  const MenuPart(
      {super.key,
      required this.title,
      required this.recipesPart,
      required this.dayInWeek,
      required this.mealInDay,
      required this.weeklyPlanId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              //uppercase
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: TemplateDay(recipesPlanParts: recipesPart)),
          const SizedBox(height: 4),
          // Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.grey[400]!),
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: GestureDetector(
          //       onTap: () async {
          //         context.read<RecipePlanBloc>().add(FetchRecipePlanEvent(
          //             '', false, mealInDay, dayInWeek, weeklyPlanId));
          //         await showModalBottomSheet(
          //           isScrollControlled: true,
          //           scrollControlDisabledMaxHeightRatio: 0.5,
          //           showDragHandle: true,
          //           context: context,
          //           builder: (context) {
          //             return SizedBox(
          //                 height: MediaQuery.of(context).size.height * 0.8,
          //                 child: DishAdd(
          //                     args: DishArguments(
          //                         dayInWeek: dayInWeek,
          //                         mealInDay: mealInDay,
          //                         weeklyPlanId: weeklyPlanId)));
          //           },
          //         );
          //       },
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Icon(
          //             Icons.add_rounded,
          //             size: 35,
          //           ),
          //           Text(S.current.add_dish)
          //         ],
          //       ),
          //     ))
          // //devide line
        ],
      ),
    );
  }
}
//convert 