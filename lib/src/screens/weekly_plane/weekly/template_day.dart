import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class TemplateDay extends StatelessWidget {
  final List<Recipe> recipesParts;

  const TemplateDay({super.key, required this.recipesParts});
  @override
  Widget build(BuildContext context) {
    var systemStateBloc = context.watch<SystemBloc>().state;
    return ListView.builder(
      itemCount: recipesParts.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Recipe menuItem = recipesParts[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'dish_detail', arguments: menuItem);
          },
          child: Container(
            height: 82,
            margin: EdgeInsets.only(bottom: 4),
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
                  imageUrl: menuItem.img ?? "",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "   ${menuItem.name}",
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
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(top: 6, right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${systemStateBloc.numberPersonInHouse} person",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(onPressed: () => {}, icon: Icon(Icons.delete))
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

class MenuItem {
  final String title;
  final String imageUrl;
  final int minutes;
  final int persons;

  MenuItem({
    required this.title,
    required this.imageUrl,
    required this.minutes,
    required this.persons,
  });
}
