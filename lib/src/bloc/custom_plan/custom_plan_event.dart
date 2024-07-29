part of 'custom_plan_bloc.dart';

@immutable
sealed class CustomPlanEvent {}

//fetch all custom plan with userid

class FetchCustomPlanEvent extends CustomPlanEvent {
  final String userId;

  FetchCustomPlanEvent(this.userId);
}

//add recipe to weekly plan
class AddRecipePlanEvent extends CustomPlanEvent {
  final RecipePlan recipePlan;
  final int systemNumberPerson;
  AddRecipePlanEvent(this.recipePlan, this.systemNumberPerson);
}

//delete recipe from weekly plan
class DeleteRecipePlanEvent extends CustomPlanEvent {
  final RecipePlan recipePlan;
  DeleteRecipePlanEvent(this.recipePlan);
}

class ChangeUserInHouseEvent extends CustomPlanEvent {
  final RecipePlan recipePlan;
  final int numberPerson;
  ChangeUserInHouseEvent(this.recipePlan, this.numberPerson);
}

//UpdateRecipePlanEvent
class UpdateWeeklyPlanEvent extends CustomPlanEvent {
  final WeeklyPlan weeklyPlan;
  UpdateWeeklyPlanEvent(this.weeklyPlan);
}
