part of 'trigger_bloc.dart';

@immutable
sealed class TriggerEvent {}

class ChangeUserInHouseTriggerEvent extends TriggerEvent {
  ChangeUserInHouseTriggerEvent();
}

class SeachTriggerEvent extends TriggerEvent {
  SeachTriggerEvent();
}

//tringger even with number
class TriggerShipEvent extends TriggerEvent {
  final int number;

  TriggerShipEvent(this.number);
}
