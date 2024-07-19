part of 'recipe_plan_bloc.dart';

@immutable
sealed class RecipePlanEvent {}

class FetchRecipePlanEvent extends RecipePlanEvent {
  final String name;
  final bool status;
  int mealInDay;
  int dayInWeek;
  String weeklyPlanId;
  FetchRecipePlanEvent(this.name, this.status, this.mealInDay, this.dayInWeek,
      this.weeklyPlanId);
}
