part of 'recipes_all_bloc.dart';

@immutable
sealed class RecipesAllEvent {}

final class FetchRecipesAllEvent extends RecipesAllEvent {
  final String name;

  FetchRecipesAllEvent(this.name);
}

//search
final class SearchRecipesAllEvent extends RecipesAllEvent {
  final String name;

  SearchRecipesAllEvent(this.name);
}
