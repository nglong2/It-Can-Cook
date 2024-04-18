import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/system_bloc.dart';
import 'package:it_can_cook/src/models/system/system.dart';
import 'package:it_can_cook/src/screens/login/welcome/welcome.dart';
import 'package:it_can_cook/src/screens/onboarding/onboarding.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SystemBloc(),
      child: BlocBuilder<SystemBloc, SystemModel>(
        builder: (context, state) {
          return MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            locale: state.language == 'en'
                ? const Locale('en')
                : const Locale('vi'),
            onGenerateTitle: (BuildContext context) => S.of(context).appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode:
                state.themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case "welcome":
                      return const Welcome();
                    default:
                      return Onboarding();
                  }
                },
              );
            },
          );
          ;
        },
      ),
    );
  }
}
