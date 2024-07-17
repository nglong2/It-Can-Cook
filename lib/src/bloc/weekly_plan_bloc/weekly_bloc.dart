import 'package:bloc/bloc.dart';
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
      await WeeklyPlanController().getWeeklys().then((data) => emit(data));
    });
  }
}
