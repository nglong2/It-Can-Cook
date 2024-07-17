part of 'weekly_bloc.dart';

@immutable
sealed class WeeklyEvent {}

class FetchWeeklyEvent extends WeeklyEvent {}
