import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/bloc/account_bloc.dart';
import 'package:it_can_cook/src/controller/recipe.dart';
import 'package:it_can_cook/src/models/account.dart';
import 'package:it_can_cook/src/models/recipe.dart';

class WeeklyScreen extends StatefulWidget {
  @override
  WeeklyScreenState createState() => WeeklyScreenState();
}

class WeeklyScreenState extends State<WeeklyScreen> {
  late Future<List<RecipeModel>> recipe;
  @override
  void initState() {
    //get Recipe from API
    recipe = RecipeController().getRecipes();
    super.initState();
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
    return FutureBuilder<List<RecipeModel>>(
      future: recipe,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap:
                    true, // Important to prevent inner ListView from expanding infinitely
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'weekly_detail',
                            arguments: snapshot.data![index].name);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/weekly-demo/${index + 1}.png",
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
                                  snapshot.data![index].name ?? "",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                // auto break line description
                                SizedBox(
                                  height: 40,
                                  child: Text(
                                    snapshot.data![index].description ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Card(
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
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );

    // add 1 box have icon add
    // listCard.add();
    // return Column(
    //   children: listCard,
    // );
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

