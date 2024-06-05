import 'package:flutter/material.dart';

class TemplateDay extends StatelessWidget {
  final List<MenuItem> menuItems;

  const TemplateDay({super.key, required this.menuItems});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menuItems.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        MenuItem menuItem = menuItems[index];
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
                Image.asset(
                  'assets/images/dishesdemo/' + menuItem.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "   ${menuItem.title}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        "    ${menuItem.minutes} minutes",
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
                          "${menuItem.persons} person",
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
