import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trigger_event.dart';
part 'trigger_state.dart';

class TriggerBloc extends Bloc<TriggerEvent, int> {
  TriggerBloc() : super(0) {
    on<TriggerEvent>((event, emit) {});
    on<ChangeUserInHouseTriggerEvent>((event, emit) {
      emit(state + 1);
    });
  }
}
