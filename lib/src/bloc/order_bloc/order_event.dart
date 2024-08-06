part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

//get history order
class GetHistoryOrderEvent extends OrderEvent {
  final String userId;

  GetHistoryOrderEvent(this.userId);
}

//get history order by order id
class GetHistoryOrderByOrderIdEvent extends OrderEvent {
  final String orderId;

  GetHistoryOrderByOrderIdEvent(this.orderId);
}
