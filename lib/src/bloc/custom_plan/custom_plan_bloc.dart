import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/controller/weekly.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:meta/meta.dart';

part 'custom_plan_event.dart';
part 'custom_plan_state.dart';

class CustomPlanBloc extends Bloc<CustomPlanEvent, List<WeeklyPlan>> {
  CustomPlanBloc() : super([]) {
    on<FetchCustomPlanEvent>((event, emit) async {
      //fetch all custom plan with userid
      var userId = event.userId;
      var listWeeklyPlan =
          await WeeklyPlanController().getWeeklyByCustomerId(userId);
      //check curent language

      for (var weeklyPlan in listWeeklyPlan) {
        for (var recipePlan in weeklyPlan.recipePlans) {
          recipePlan.weeklyPlanId = weeklyPlan.id;
        }
      }
      emit(listWeeklyPlan);
    });
  }
}
