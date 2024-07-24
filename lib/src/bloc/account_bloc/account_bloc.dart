import 'dart:math';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:it_can_cook/src/models/account/account.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends HydratedBloc<AccountEvent, AccountModel?> {
  AccountBloc() : super(null) {
    on<AccountEvent>((event, emit) {});
    on<LoginEvent>((event, emit) {
      login(event.accountModel, emit);
    });
    on<LogOutEvent>((event, emit) {
      emit(AccountModel());
    });
    on<FetchAccountEvent>((event, emit) {
      emit(state);
    });
  }

  void login(AccountModel accountModel, Emitter<AccountModel?> emit) {
    emit(accountModel);
  }

  @override
  AccountModel? fromJson(Map<String, dynamic> json) {
    return json.isEmpty ? null : AccountModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AccountModel? state) {
    return state == null ? AccountModel().toJson() : state.toJson();
  }
}
