import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/bloc/account_bloc.dart';
import 'package:it_can_cook/src/models/account.dart';

class WeeklyScreen extends StatefulWidget {
  @override
  WeeklyScreenState createState() => WeeklyScreenState();
}

class WeeklyScreenState extends State<WeeklyScreen> {
  @override
  void initState() {
    super.initState();
    // Make the screen full screen
  }

  @override
  void dispose() {
    // Restore the system overlays when the screen is disposed

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountModel?>(
      builder: (context, state) {
        return Scaffold(
            body: Container(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: SingleChildScrollView(
            key: UniqueKey(),
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(context).hello} ${state?.lastName} ${state?.firstName}!",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Have a nice day 👋",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  renderSearch(),
                  renderCardDemo()
                ]),
          ),
        ));
      },
    );
  }

  Widget renderCardDemo() {
    var listTitle = [
      "Combo 7 days for diet",
      "Packge for heathly family",
      "Title 3",
      "Title 4",
      "Title 5"
    ];
    var listDescription = [
      "Include 7 meals for 7 days, help you keep fit and healthy",
      "Healthy food for your family, help you keep fit and healthy",
      "Normal Package for you and your family",
      "Description 4",
      "Description 5"
    ];
    List<Widget> listCard = [];
    for (int i = 1; i <= 5; i++) {
      listCard.add(Card(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'weekly_detail',
                arguments: listTitle[i - 1]);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/weekly-demo/$i.png",
                width: MediaQuery.of(context).size.width,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listTitle[i - 1],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    // auto break line description
                    SizedBox(
                      height: 40,
                      child: Text(
                        listDescription[i - 1],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
    // add 1 box have icon add
    listCard.add(Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => {
              Navigator.pushNamed(context, 'weekly_detail',
                  arguments: "Custom Package")
            },
            icon: const Icon(Icons.add_rounded),
            iconSize: 50,
          ),
          Text(S.current.custom_package)
        ],
      ),
    ));
    return Column(
      children: listCard,
    );
  }

//input search widget
  Widget renderSearch() {
    return Container(
      padding: const EdgeInsets.only(right: 0, bottom: 10),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: S.current.search,
            prefixIcon: IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.search),
            )),
      ),
    );
  }
}

//function render Card demo for  5 items have image save at assets\images\weekly-demo\1.png ...
// return List Card() widget

