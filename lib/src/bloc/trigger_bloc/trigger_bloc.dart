import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/models/system/trigger.dart';
import 'package:meta/meta.dart';

part 'trigger_event.dart';
part 'trigger_state.dart';

class TriggerBloc extends Bloc<TriggerEvent, Trigger> {
  TriggerBloc() : super(Trigger(changeUserInHouseNum: 0, seachNum: 0)) {
    on<TriggerEvent>((event, emit) {});
    on<ChangeUserInHouseTriggerEvent>((event, emit) {
      emit(
          state.copyWith(changeUserInHouseNum: state.changeUserInHouseNum + 1));
    });

    on<SeachTriggerEvent>((event, emit) {
      emit(state.copyWith(seachNum: state.seachNum + 1));
    });
  }
}
