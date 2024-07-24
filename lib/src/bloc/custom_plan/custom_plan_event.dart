part of 'custom_plan_bloc.dart';

@immutable
sealed class CustomPlanEvent {}

//fetch all custom plan with userid

class FetchCustomPlanEvent extends CustomPlanEvent {
  final String userId;

  FetchCustomPlanEvent(this.userId);
}
