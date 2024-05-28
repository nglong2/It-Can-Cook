part of 'system_bloc.dart';

@immutable
sealed class SystemEvent {}

//class init
class InitSystemEvent extends SystemEvent {
  InitSystemEvent();
}

class ChangeThemeEvent extends SystemEvent {
  final String themeMode;

  ChangeThemeEvent(this.themeMode);
}

class ChangeLanguageEvent extends SystemEvent {
  final String language;

  ChangeLanguageEvent(this.language);
}
