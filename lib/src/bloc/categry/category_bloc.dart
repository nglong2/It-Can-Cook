import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/controller/recipe.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, List<Category>> {
  CategoryBloc() : super([]) {
    on<FetchCategoryEvent>((event, emit) async {
      var value = await RecipeController().getCategories();
      emit(value);
    });
  }
}
