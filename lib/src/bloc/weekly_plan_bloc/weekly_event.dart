part of 'weekly_bloc.dart';

@immutable
sealed class WeeklyEvent {}

class FetchWeeklyEvent extends WeeklyEvent {}

class AddRecipeEvent extends WeeklyEvent {
  final Recipe recipe;
  AddRecipeEvent(this.recipe);
}
