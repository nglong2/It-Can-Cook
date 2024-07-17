part of 'weekly_bloc.dart';

@immutable
sealed class WeeklyEvent {}

class FetchWeeklyEvent extends WeeklyEvent {}

class AddRecipeEvent extends WeeklyEvent {
  final Recipe recipe;
  AddRecipeEvent(this.recipe);
}

//class change userinhouse of RecipePlan

class ChangeUserInHouseEvent extends WeeklyEvent {
  final RecipePlan recipePlan;
  ChangeUserInHouseEvent(this.recipePlan);
}
