import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class StepTabWidget extends StatefulWidget {
  final List<RecipeStep> steps;

  const StepTabWidget({super.key, required this.steps});
  @override
  _StepTabWidgetState createState() => _StepTabWidgetState();
}

class _StepTabWidgetState extends State<StepTabWidget> {
  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.steps.length,
        itemBuilder: (context, index) {
          final step = widget.steps[index];
          return ListTile(
            title: Text("Step ${index + 1}: ", //+ step.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: step.description == null
                  ? []
                  : step.description!
                      .split(';')
                      .map((e) => Text("- " + e))
                      .toList(),
            ),
            leading: SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: step.imageLink ?? "",
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
