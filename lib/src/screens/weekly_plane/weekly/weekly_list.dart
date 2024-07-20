import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:uuid/uuid.dart';

class WeeklyList extends StatefulWidget {
  @override
  _WeeklyListState createState() => _WeeklyListState();
}

class _WeeklyListState extends State<WeeklyList> {
  @override
  Widget build(BuildContext context) {
    final weeklystate = context.watch<WeeklyBloc>().state;
    var listPlan = weeklystate;
    return Column(
      children: [
        ListView.builder(
          itemCount: listPlan!.length,
          shrinkWrap:
              true, // Important to prevent inner ListView from expanding infinitely
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'weekly_detail',
                      arguments: listPlan[index]);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      //center
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        listPlan[index].id == Uuid.NAMESPACE_NIL
                            ? const Text("")
                            : CachedNetworkImage(
                                imageUrl: listPlan[index].urlImage ?? "",
                                width: MediaQuery.of(context).size.width - 48,
                                height: listPlan[index].id == Uuid.NAMESPACE_NIL
                                    ? 80
                                    : 250,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SizedBox(
                                  height: 250,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listPlan[index].id == Uuid.NAMESPACE_NIL
                                ? S.current.custom_plan_title
                                : listPlan![index].title ?? "",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          // auto break line description
                          SizedBox(
                            height: 40,
                            child: Text(
                              listPlan[index].id == Uuid.NAMESPACE_NIL
                                  ? S.current.custom_plan_description
                                  : listPlan[index].description ?? "",
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
      ],
    );
  }
}
