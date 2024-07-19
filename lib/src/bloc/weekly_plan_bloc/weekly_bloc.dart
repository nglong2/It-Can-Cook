import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:it_can_cook/src/controller/weekly.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart'; // Add this line to import the 'Uuid' class

part 'weekly_event.dart';
part 'weekly_state.dart';

class WeeklyBloc extends Bloc<WeeklyEvent, List<WeeklyPlan>> {
  WeeklyBloc() : super([]) {
    on<WeeklyEvent>((event, emit) {});

    on<FetchWeeklyEvent>((event, emit) async {
      var listWeeklyPlan = await WeeklyPlanController().getWeeklys();
      //check curent language
      var emplyPlan = WeeklyPlan(
          id: Uuid.NAMESPACE_NIL,
          title: "Custom Plan +",
          urlImage:
              'https://wemealkit.s3.amazonaws.com/369Plus_icon-icons.com_71848.png',
          description:
              "If you cant find any plan, you can create your own, we can provide you the recipe, it's easy",
          recipePlans: []);

      listWeeklyPlan.add(emplyPlan);

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
      final numberPerson = event.numberPerson;
      for (var weekly in state) {
        if (weekly.id == recipePlan.weeklyPlanId) {
          for (var recipe in weekly.recipePlans) {
            if (recipe.id == recipePlan.id &&
                recipe.dayInWeek == recipePlan.dayInWeek &&
                recipe.mealInDay == recipePlan.mealInDay) {
              recipe.numberPerson = numberPerson;
              emit(state);
            }
          }
        }
      }
      //
    });
    //UpdateTotalPriceEvent
    on<UpdateTotalPriceEvent>((event, emit) async {
      final weeklyPlanId = event.weeklyPlanId;
      final totalPrice = event.totalPrice;
      for (var weekly in state) {
        if (weekly.id == weeklyPlanId) {
          weekly.totalPrice = totalPrice;
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
