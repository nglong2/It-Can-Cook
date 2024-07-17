import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:it_can_cook/src/controller/weekly.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:meta/meta.dart';

part 'weekly_event.dart';
part 'weekly_state.dart';

class WeeklyBloc extends Bloc<WeeklyEvent, List<WeeklyPlan>> {
  WeeklyBloc() : super([]) {
    on<WeeklyEvent>((event, emit) {});

    on<FetchWeeklyEvent>((event, emit) async {
      var listWeeklyPlan = await WeeklyPlanController().getWeeklys();
      for (var weeklyPlan in listWeeklyPlan) {
        for (var recipePlan in weeklyPlan.recipePlans) {
          recipePlan.weeklyPlanId = weeklyPlan.id;
        }
      }
      emit(listWeeklyPlan);
    });

    //ChangeUserInHouseEvent
    on<ChangeUserInHouseEvent>((event, emit) async {
      final recipePlan = event.recipePlan;
      for (var weekly in state) {
        if (weekly.id == recipePlan.weeklyPlanId) {
          for (var recipe in weekly.recipePlans) {
            if (recipe.id == recipePlan.id &&
                recipe.dayInWeek == recipePlan.dayInWeek &&
                recipe.mealInDay == recipePlan.mealInDay) {
              recipe = recipePlan;
            }
          }
        }
      }
      emit(state);
    });
  }

  // @override
  // List<WeeklyPlan>? fromJson(Map<String, dynamic> json) {
  //   return json.isEmpty
  //       ? []
  //       : (json['weeklyPlans'] as List)
  //           .map((e) => WeeklyPlan.fromJson(e))
  //           .toList();
  // }

  // @override
  // Map<String, dynamic>? toJson(List<WeeklyPlan> state) {
  //   return {
  //     'weeklyPlans': state.map((e) => e.toJson()).toList(),
  //   };
  // }
}
