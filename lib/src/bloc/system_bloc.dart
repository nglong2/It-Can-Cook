import 'package:bloc/bloc.dart';
import 'package:it_can_cook/src/models/system/system.dart';
import 'package:meta/meta.dart';

part 'system_event.dart';
part 'system_state.dart';

class SystemBloc extends Bloc<SystemEvent, SystemModel> {
  SystemBloc()
      : super(SystemModel(
            language: 'vi',
            country: 'US',
            timezone: 'UTC',
            themeMode: 'light')) {
    on<SystemEvent>((event, emit) {
      if (event is ChangeThemeEvent) {
        changeTheme(event.themeMode, emit);
      } else if (event is ChangeLanguageEvent) {
        changeLanguage(event.language, emit);
      }
    });
  }

  void changeTheme(String themeMode, Emitter<SystemModel> emit) {
    final updatedSystemModel = state.copyWith(themeMode: themeMode);
    emit(updatedSystemModel);
  }

  void changeLanguage(String language, Emitter<SystemModel> emit) {
    final updatedSystemModel = state.copyWith(language: language);
    emit(updatedSystemModel);
  }
}
