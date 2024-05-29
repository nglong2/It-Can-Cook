import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:it_can_cook/src/models/account.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends HydratedBloc<AccountEvent, AccountModel?> {
  AccountBloc() : super(null) {
    on<AccountEvent>((event, emit) {
      if (event is LoginEvent) {
        login(event.accountModel, emit);
      }
    });
  }

  void login(AccountModel accountModel, Emitter<AccountModel?> emit) {
    emit(accountModel);
  }

  @override
  AccountModel? fromJson(Map<String, dynamic> json) {
    return AccountModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AccountModel? state) {
    return state?.toJson();
  }
}
