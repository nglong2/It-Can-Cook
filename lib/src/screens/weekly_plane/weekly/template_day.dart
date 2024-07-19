import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:numberpicker/numberpicker.dart';

class TemplateDay extends StatefulWidget {
  final List<RecipePlan> recipesPlanParts;

  TemplateDay({Key? key, required this.recipesPlanParts}) : super(key: key);

  @override
  _TemplateDayState createState() => _TemplateDayState();
}

class _TemplateDayState extends State<TemplateDay> {
  @override
  Widget build(BuildContext context) {
    var systemStateBloc = context.watch<SystemBloc>().state;

    return ListView.builder(
      itemCount: widget.recipesPlanParts.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        RecipePlan? menuItem = widget.recipesPlanParts[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'dish_detail', arguments: menuItem);
          },
          child: Container(
            height: 86,
            margin: const EdgeInsets.only(bottom: 2),
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[400]!
                    : Colors.grey[800]!,
              ),
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: menuItem.recipe?.img ?? "",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "   ${menuItem.recipe?.name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "    ${menuItem.recipe?.cookingTime ?? 60} minutes",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.grey[600]),
                      ),
                      //price
                      Text(
                        "    ${menuItem.recipe?.price?.toStringAsFixed(0).replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},',
                            )} vnđ /1 ${S.current.person}",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.only(top: 6, right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NumberPicker(
                              textMapper: (numberText) {
                                return "$numberText ${S.current.person}";
                              },
                              value: menuItem.numberPerson ??
                                  systemStateBloc.numberPersonInHouse,
                              minValue: 1,
                              itemHeight: 18,
                              selectedTextStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              itemCount: 1,
                              itemWidth: 60,
                              haptics: true,
                              step: 1,
                              zeroPad: false,
                              infiniteLoop: false,
                              maxValue: 10,
                              textStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  menuItem.numberPerson = value;
                                });
                                context.read<WeeklyBloc>().add(
                                      ChangeUserInHouseEvent(menuItem, value),
                                    );
                                context.read<TriggerBloc>().add(
                                      ChangeUserInHouseTriggerEvent(),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () => {}, icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
