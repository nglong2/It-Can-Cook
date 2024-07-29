import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/controller/weekly.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:meta/meta.dart';

part 'custom_plan_event.dart';
part 'custom_plan_state.dart';

// //final class CustomPlanLoading extends CustomPlanState {}

// final class CustomPlanLoaded extends CustomPlanState {
//   final List<WeeklyPlan> weeklyPlans;
//   CustomPlanLoaded(this.weeklyPlans);
// }

class CustomPlanBloc extends Bloc<CustomPlanEvent, CustomPlanState> {
  CustomPlanBloc() : super(CustomPlanLoading()) {
    on<FetchCustomPlanEvent>((event, emit) async {
      emit(CustomPlanLoading());
      // fetch all custom plans with userid
      var userId = event.userId;
      var listWeeklyPlan =
          await WeeklyPlanController().getWeeklyByCustomerId(userId);

      // set weeklyPlanId for recipePlans
      for (var weeklyPlan in listWeeklyPlan) {
        for (var recipePlan in weeklyPlan.recipePlans) {
          recipePlan.weeklyPlanId = weeklyPlan.id;
        }
      }
      emit(CustomPlanLoaded(listWeeklyPlan));
    });

    on<AddRecipePlanEvent>((event, emit) async {
      if (state is CustomPlanLoaded) {
        final currentState = state as CustomPlanLoaded;
        final recipePlan = event.recipePlan;
        final systemNumberPerson = event.systemNumberPerson;
        bool updated = false;

        for (var weekly in currentState.weeklyPlans) {
          if (weekly.id == recipePlan.weeklyPlanId) {
            // check if dayInWeek and mealInDay exist then + 1 to person
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
                isExist = true;
                updated = true;
                break;
              }
            }
            if (!isExist) {
              weekly.recipePlans.add(recipePlan);
              updated = true;
            }
          }
        }

        if (updated) {
          emit(CustomPlanLoaded(currentState.weeklyPlans));
        }
      }
    });

    on<DeleteRecipePlanEvent>((event, emit) async {
      if (state is CustomPlanLoaded) {
        final currentState = state as CustomPlanLoaded;
        final recipePlan = event.recipePlan;
        bool updated = false;

        for (var weekly in currentState.weeklyPlans) {
          if (weekly.id == recipePlan.weeklyPlanId) {
            weekly.recipePlans.removeWhere((element) =>
                element.id == recipePlan.id &&
                element.dayInWeek == recipePlan.dayInWeek &&
                element.mealInDay == recipePlan.mealInDay);
            updated = true;
          }
        }

        if (updated) {
          emit(CustomPlanLoaded(currentState.weeklyPlans));
        }
      }
    });

    on<ChangeUserInHouseEvent>((event, emit) async {
      if (state is CustomPlanLoaded) {
        final currentState = state as CustomPlanLoaded;
        final recipePlan = event.recipePlan;
        final numberPerson = event.numberPerson;
        bool updated = false;

        for (var weekly in currentState.weeklyPlans) {
          if (weekly.id == recipePlan.weeklyPlanId) {
            for (var recipe in weekly.recipePlans) {
              if (recipe.id == recipePlan.id &&
                  recipe.dayInWeek == recipePlan.dayInWeek &&
                  recipe.mealInDay == recipePlan.mealInDay) {
                recipe.numberPerson = numberPerson;
                updated = true;
                break;
              }
            }
          }
        }

        if (updated) {
          emit(CustomPlanLoaded(currentState.weeklyPlans));
        }
      }
    });

    //updateweeklyplanevent

    on<UpdateWeeklyPlanEvent>((event, emit) async {
      if (state is CustomPlanLoaded) {
        final currentState = state as CustomPlanLoaded;
        final weeklyPlan = event.weeklyPlan;
        await WeeklyPlanController().updateWeeklyPlan(weeklyPlan);
        emit(CustomPlanLoaded(currentState.weeklyPlans));
      }
    });
  }
}
