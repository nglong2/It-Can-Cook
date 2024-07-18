part of 'trigger_bloc.dart';

@immutable
sealed class TriggerEvent {}

class ChangeUserInHouseTriggerEvent extends TriggerEvent {
  final int numberPerson;
  ChangeUserInHouseTriggerEvent(this.numberPerson);
}
