part of 'custom_plan_bloc.dart';

@immutable
sealed class CustomPlanState {}

final class CustomPlanInitial extends CustomPlanState {}

final class CustomPlanLoading extends CustomPlanState {}

final class CustomPlanLoaded extends CustomPlanState {
  final List<WeeklyPlan> weeklyPlans;
  CustomPlanLoaded(this.weeklyPlans);
}
