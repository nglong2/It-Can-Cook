part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

//event login
class FetchAccountEvent extends AccountEvent {
  FetchAccountEvent();
}

class LoginEvent extends AccountEvent {
  final AccountModel accountModel;

  LoginEvent(this.accountModel);
}

class LogOutEvent extends AccountEvent {
  LogOutEvent();
}
