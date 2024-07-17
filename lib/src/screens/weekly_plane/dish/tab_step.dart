import 'package:flutter/material.dart';

class StepTabWidget extends StatefulWidget {
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
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index];
          return ListTile(
            title: Text("Step ${index + 1}: " + step.title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  step.description.map((desc) => Text("- $desc")).toList(),
            ),
            leading: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                step.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

//class step
class Step {
  final String title;
  final List<String> description;
  final String imageUrl;

  Step(
      {required this.title, required this.description, required this.imageUrl});
}

final List<Step> steps = [
  Step(
    title: "Prepare Ingredients",
    description: [
      "Slice beef thinly.",
      "Slice lemongrass, shallots, and onions.",
      "Wash vegetables."
    ],
    imageUrl: "assets/images/stepsdemo/1.png",
  ),
  Step(
    title: "Make Broth",
    description: [
      "Boil beef bones with lemongrass, shallots, and onions.",
      "Skim off impurities.",
      "Simmer for 2-3 hours until flavorful."
    ],
    imageUrl: "assets/images/stepsdemo/2.png",
  ),
  Step(
    title: "Prepare Noodles and Toppings",
    description: [
      "Soak rice noodles in hot water until soft.",
      "Slice banana blossom, herbs, and lime.",
      "Boil pork blood and slice it."
    ],
    imageUrl: "assets/images/stepsdemo/3.png",
  ),
  Step(
    title: "Cook Beef",
    description: [
      "Marinate beef slices with lemongrass, garlic, and chili.",
      "Grill or pan-fry until cooked.",
      "Slice cooked beef thinly."
    ],
    imageUrl: "assets/images/stepsdemo/4.png",
  ),
  Step(
    title: "Assemble Bowl",
    description: [
      "Place cooked noodles in a bowl.",
      "Add sliced beef, pork blood, and pork hock.",
      "Pour hot broth over the ingredients."
    ],
    imageUrl: "assets/images/stepsdemo/5.png",
  ),
  Step(
    title: "Add Toppings",
    description: [
      "Sprinkle with chopped green onions and cilantro.",
      "Add bean sprouts, banana blossom, and sliced lime.",
      "Season with fish sauce and chili oil to taste."
    ],
    imageUrl: "assets/images/stepsdemo/6.png",
  ),
  Step(
    title: "Serve",
    description: [
      "Serve hot with a side of fresh herbs and vegetables.",
      "Enjoy your delicious Bun Bo Hue!"
    ],
    imageUrl: "assets/images/stepsdemo/7.png",
  ),
  Step(
    title: "Enjoy!",
    description: [
      "Savor the flavors of Bun Bo Hue.",
      "Share with friends and family!"
    ],
    imageUrl: "assets/images/stepsdemo/8.png",
  ),
  // Add more steps as needed
];
