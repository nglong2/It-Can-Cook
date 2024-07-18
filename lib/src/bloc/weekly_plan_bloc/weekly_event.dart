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
