import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/controller/recipe.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:meta/meta.dart';

part 'recipes_all_event.dart';
part 'recipes_all_state.dart';

class RecipesAllBloc extends Bloc<RecipesAllEvent, List<RecipePlan>> {
  RecipesAllBloc() : super([]) {
    on<FetchRecipesAllEvent>((event, emit) async {
      //getRecipePlansByName
      var name = event.name;
      var status = true;
      var listRecipePlan =
          await RecipeController().getRecipePlansByName(name, status);
      emit(listRecipePlan);
    });
    //search
    on<SearchRecipesAllEvent>((event, emit) async {
      //getRecipePlansByName
      var name = event.name;
      var status = true;
      var listRecipePlan =
          await RecipeController().getRecipePlansByName(name, status);
      emit(listRecipePlan);
    });
  }
}
