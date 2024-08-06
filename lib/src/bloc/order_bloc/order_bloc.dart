import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/controller/order.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, List<OrderHistory>> {
  OrderBloc() : super([]) {
    on<OrderEvent>((event, emit) {});

    on<GetHistoryOrderEvent>((event, emit) async {
      var userID = event.userId;

      var listWeeklyPlan = await OrderController().GetOrderHistory(userID);

      emit(listWeeklyPlan);
    });

    on<GetHistoryOrderByOrderIdEvent>((event, emit) async {
      var orderId = event.orderId;

      var listWeeklyPlan = await OrderController().GetOrder(orderId);

      emit([listWeeklyPlan]);
    });
  }
}
