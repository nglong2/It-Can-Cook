part of 'trigger_bloc.dart';

@immutable
sealed class TriggerEvent {}

class ChangeUserInHouseTriggerEvent extends TriggerEvent {
  ChangeUserInHouseTriggerEvent();
}

class SeachTriggerEvent extends TriggerEvent {
  SeachTriggerEvent();
}
