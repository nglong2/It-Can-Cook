import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/controller/recipe.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:meta/meta.dart';

part 'recipe_plan_event.dart';
part 'recipe_plan_state.dart';

class RecipePlanBloc extends Bloc<RecipePlanEvent, List<RecipePlan>> {
  RecipePlanBloc() : super([]) {
    on<RecipePlanEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchRecipePlanEvent>((event, emit) async {
      // Future<List<RecipePlan>> getRecipePlansByName(
      String name = event.name;
      bool status = event.status;
      int mealInDay = event.mealInDay;
      int dayInWeek = event.dayInWeek;
      String weeklyPlanId = event.weeklyPlanId;

      RecipeController recipeController = RecipeController();
      var recipes = await recipeController.getRecipePlansByName(name, status);
      for (var item in recipes) {
        item.dayInWeek = dayInWeek;
        item.mealInDay = mealInDay;
        item.weeklyPlanId = weeklyPlanId;
      }
      emit(recipes);
    });
  }
}
