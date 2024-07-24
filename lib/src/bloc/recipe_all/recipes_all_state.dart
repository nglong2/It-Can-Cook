part of 'recipes_all_bloc.dart';

@immutable
sealed class RecipesAllState {}

final class RecipesAllInitial extends RecipesAllState {}

final class RecipesAllLoading extends RecipesAllState {}
