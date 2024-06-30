import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/system_bloc.dart';
import 'package:it_can_cook/src/models/system/system.dart';
import 'package:it_can_cook/src/screens/delivery/home.dart';
import 'package:it_can_cook/src/screens/home/home_page.dart';
import 'package:it_can_cook/src/screens/login/login/login.dart';
import 'package:it_can_cook/src/screens/login/register/register.dart';
import 'package:it_can_cook/src/screens/login/welcome/welcome.dart';
import 'package:it_can_cook/src/screens/onboarding/onboarding.dart';
import 'package:it_can_cook/src/screens/payment/payment.dart';
import 'package:it_can_cook/src/screens/weekly_plane.dart/dish/dish_detail.dart';
import 'package:it_can_cook/src/screens/weekly_plane.dart/weekly/template_day.dart';
import 'package:it_can_cook/src/screens/weekly_plane.dart/weekly/weekly_detail.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SystemBloc>(
          create: (BuildContext context) => SystemBloc(),
        ),
        BlocProvider<AccountBloc>(
          create: (BuildContext context) => AccountBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final systemState = context.watch<SystemBloc>().state;
          final accountState = context.watch<AccountBloc>()?.state;
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
            locale: systemState.language == 'en'
                ? const Locale('en')
                : const Locale('vi'),
            onGenerateTitle: (BuildContext context) => S.of(context).appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: systemState.themeMode == 'dark'
                ? ThemeMode.dark
                : ThemeMode.light,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case "welcome":
                      return const Welcome();
                    case "login":
                      return const LoginPage();
                    case "register":
                      return const RegisterPage();
                    case "home":
                      return const HomePage();
                    case "weekly_detail":
                      return WeeklyDetailPage(
                        title: routeSettings.arguments.toString(),
                      );
                    case "dish_detail":
                      return DishDetail(
                        menuItem: routeSettings.arguments as MenuItem,
                      );

                    case "delivery":
                      return DeliveryHome();
                    default:
                      return Payment("hello");
                    // return accountState != null
                    //     ? accountState.role?.toLowerCase() == 'shiper'
                    //         ? DeliveryHome()
                    //         : const HomePage()
                    //     : Onboarding();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
