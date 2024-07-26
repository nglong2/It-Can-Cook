part of 'weekly_bloc.dart';

@immutable
sealed class WeeklyState {}

final class WeeklyInitial extends WeeklyState {}

//loading state and data state
final class WeeklyLoading extends WeeklyState {}

final class WeeklyLoaded extends WeeklyState {
  final List<WeeklyPlan> weeklyPlans;
  WeeklyLoaded(this.weeklyPlans);
}
