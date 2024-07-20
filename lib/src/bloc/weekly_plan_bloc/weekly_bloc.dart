import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:it_can_cook/src/controller/weekly.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart'; // Add this line to import the 'Uuid' class
import 'package:diacritic/diacritic.dart';

part 'weekly_event.dart';
part 'weekly_state.dart';

class WeeklyBloc extends Bloc<WeeklyEvent, List<WeeklyPlan>> {
  WeeklyBloc() : super([]) {
    on<WeeklyEvent>((event, emit) {});

    on<FetchWeeklyEvent>((event, emit) async {
      var listWeeklyPlan = await WeeklyPlanController().getWeeklys();
      //check curent language

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

    //SearchWeeklyPlanEvent
    on<SearchWeeklyPlanEvent>((event, emit) async {
      final text = event.text;

      var listWeeklyPlan = await WeeklyPlanController().getWeeklys();
      var listSearch = listWeeklyPlan.where((element) {
        // Remove diacritics and convert to lowercase for comparison
        String cleanedTitle = removeDiacritics(element.title!.toLowerCase());
        String cleanedText = removeDiacritics(text.toLowerCase());
        // Check if the cleaned title contains the cleaned search text
        return element.id == Uuid.NAMESPACE_NIL ||
            cleanedTitle.contains(cleanedText);
      }).toList();
      emit(listSearch);
    });

    //AddRecipePlanEvent
    on<AddRecipePlanEvent>((event, emit) async {
      final recipePlan = event.recipePlan;
      final systemNumberPerson = event.systemNumberPerson;
      for (var weekly in state) {
        if (weekly.id == recipePlan.weeklyPlanId) {
          //check if dayInWeek and mealInDay is exit then + 1 to person
          bool isExist = false;
          for (var recipe in weekly.recipePlans) {
            if (recipe.id == recipePlan.id &&
                recipe.dayInWeek == recipePlan.dayInWeek &&
                recipe.mealInDay == recipePlan.mealInDay) {
              var numberPerson = recipe.numberPerson ?? systemNumberPerson;
              recipe.numberPerson = (numberPerson + 1);
              if (recipe.numberPerson! > 10) {
                recipe.numberPerson = 10;
              }
              emit(state);
              isExist = true;
            }
          }
          if (!isExist) {
            weekly.recipePlans.add(recipePlan);
          }
        }
      }
      emit(state);
    });

    //DeleteRecipePlanEvent
    on<DeleteRecipePlanEvent>((event, emit) async {
      final recipePlan = event.recipePlan;
      for (var weekly in state) {
        if (weekly.id == recipePlan.weeklyPlanId) {
          weekly.recipePlans.removeWhere((element) =>
              element.id == recipePlan.id &&
              element.dayInWeek == recipePlan.dayInWeek &&
              element.mealInDay == recipePlan.mealInDay);
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
