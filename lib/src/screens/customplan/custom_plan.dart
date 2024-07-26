import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/custom_plan/custom_plan_bloc.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CustomPlanScreen extends StatefulWidget {
  const CustomPlanScreen({super.key});
  @override
  _CustomPlanScreenState createState() => _CustomPlanScreenState();
}

class _CustomPlanScreenState extends State<CustomPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.list_custom_personal_weekly_plan),
        ),
        body: BlocListener<CustomPlanBloc, CustomPlanState>(
            listener: (context, state) {},
            child: BlocBuilder<CustomPlanBloc, CustomPlanState>(
              builder: (context, state) {
                if (state is CustomPlanLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CustomPlanLoaded) {
                  return LoaderOverlay(
                      child: ListView.builder(
                    itemCount: state.weeklyPlans.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Row(
                            children: [
                              Text(state.weeklyPlans[index].title ?? ''),
                              IconButton(
                                icon: //rename icon to delete
                                    const Icon(
                                  Icons.border_color,
                                  size: 18,
                                ),
                                onPressed: () {
                                  //show poup for rename state[index].title
                                },
                              ),
                            ],
                          ),
                          leading: CachedNetworkImage(
                            imageUrl: state.weeklyPlans[index].urlImage ?? '',
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                          subtitle: Row(
                            children: [
                              Text(state.weeklyPlans[index].description ?? ''),
                            ],
                          ),
                          onTap: () => {
                                //navigate to detail
                                Navigator.pushNamed(
                                    context, 'weekly_custom_detail',
                                    arguments: state.weeklyPlans[index])
                              },
                          trailing: Container(
                            margin: const EdgeInsets.only(bottom: 22),
                            child: IconButton(
                              icon: //rename icon to delete
                                  const Icon(
                                Icons.delete,
                                size: 18,
                              ),
                              onPressed: () {
                                //show poup for rename state[index].title
                              },
                            ),
                          )
                          //iwamt add button delete at last

                          );
                    },
                  ));
                }
                return const SizedBox();
              },
            )));
  }
}
