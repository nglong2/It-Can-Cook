import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/controller/shipper.dart';
import 'package:it_can_cook/src/models/shipper/ordergroup.dart';
import 'package:meta/meta.dart';

part 'order_group_event.dart';
part 'order_group_state.dart';

class OrderGroupBloc extends Bloc<OrderGroupEvent, List<OrderGroup>> {
  OrderGroupBloc() : super([]) {
    on<OrderGroupEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetOrderGroup>((event, emit) async {
      var lstOrderGroup =
          await ShipperController().getAllOrderGroup(event.userId);
      emit(lstOrderGroup);
    });
  }
}
