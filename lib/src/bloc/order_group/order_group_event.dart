part of 'order_group_bloc.dart';

@immutable
sealed class OrderGroupEvent {}

class GetOrderGroup extends OrderGroupEvent {
  final String userId;

  GetOrderGroup(this.userId);
}
