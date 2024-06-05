import 'package:flutter/material.dart';

class TemplateDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuPart(title: 'Breakfast'),
        MenuPart(title: 'Lunch'),
        MenuPart(title: 'Dinner'),
      ],
    );
  }
}

class MenuPart extends StatelessWidget {
  final String title;

  const MenuPart({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1551024601-bec78aea704b?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZGVsaWNpb3VzJTIwZm9vZHxlbnwwfHwwfHx8MA%3D%3D',
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
                        "   Hamburger",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        "    60 minutes",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 6, right: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "4 person",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(onPressed: () => {}, icon: Icon(Icons.delete))
                  ],
                )),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.network(
                  'https://img.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg?size=626&ext=jpg&ga=GA1.1.672697106.1717459200&semt=sph',
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
                        "   Chiken Pho",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        "    120 minutes",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 6, right: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "4 person",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(onPressed: () => {}, icon: Icon(Icons.delete))
                  ],
                )),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.network(
                  'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2017/3/21/0/fnd_pasta-istock.jpg.rend.hgtvcom.1280.720.suffix/1490188710731.jpeg',
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
                        "   Fresh Fruit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        "    60 minutes",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 6, right: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "2 person",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(onPressed: () => {}, icon: Icon(Icons.delete))
                  ],
                )),
              ],
            ),
          ),
          SizedBox(height: 8),
          //add 1 box have icon add
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, 'weekly_detail',
                        arguments: "Custom Package")
                  },
                  icon: Icon(Icons.add_rounded),
                  iconSize: 40,
                ),
                Text("Add ")
              ],
            ),
          )
          //devide line
        ],
      ),
    );
  }
}
