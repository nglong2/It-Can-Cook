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
  final int numberPerson;
  ChangeUserInHouseEvent(this.recipePlan, this.numberPerson);
}

//update total price of weekly plan
class UpdateTotalPriceEvent extends WeeklyEvent {
  final String weeklyPlanId;
  final double totalPrice;
  UpdateTotalPriceEvent(this.weeklyPlanId, this.totalPrice);
}

// search weekly plan text
class SearchWeeklyPlanEvent extends WeeklyEvent {
  final String text;
  SearchWeeklyPlanEvent(this.text);
}

//add recipe to weekly plan
class AddRecipePlanEvent extends WeeklyEvent {
  final RecipePlan recipePlan;
  final int systemNumberPerson;
  AddRecipePlanEvent(this.recipePlan, this.systemNumberPerson);
}

//delete recipe from weekly plan
class DeleteRecipePlanEvent extends WeeklyEvent {
  final RecipePlan recipePlan;
  DeleteRecipePlanEvent(this.recipePlan);
}

//update list weekly plan
class UpdateListWeeklyPlanEvent extends WeeklyEvent {
  final List<WeeklyPlan> weeklyPlans;
  UpdateListWeeklyPlanEvent(this.weeklyPlans);
}
