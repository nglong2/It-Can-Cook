part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

//event login
class LoginEvent extends AccountEvent {
  final AccountModel accountModel;

  LoginEvent(this.accountModel);
}
