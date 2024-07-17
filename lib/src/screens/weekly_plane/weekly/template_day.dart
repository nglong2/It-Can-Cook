import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
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
    var systemStateBloc = BlocProvider.of<SystemBloc>(context).state;

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
            height: 82,
            margin: const EdgeInsets.only(bottom: 4),
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
                  width: 100,
                  height: 100,
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
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        "    ${60} minutes",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Row(
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
                              itemHeight: 28,
                              selectedTextStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              itemCount: 1,
                              haptics: true,
                              maxValue: 16,
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  menuItem.numberPerson = value;
                                });
                                BlocProvider.of<WeeklyBloc>(context).add(
                                  ChangeUserInHouseEvent(menuItem),
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
