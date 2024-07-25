part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

//get history order
class GetHistoryOrderEvent extends OrderEvent {
  final String userId;

  GetHistoryOrderEvent(this.userId);
}
