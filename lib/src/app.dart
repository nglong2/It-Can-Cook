import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/custom_plan/custom_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/recipe_all/recipes_all_bloc.dart';
import 'package:it_can_cook/src/bloc/recipe_plan/recipe_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/bloc/trigger_bloc/trigger_bloc.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:it_can_cook/src/models/weekly/dish.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';
import 'package:it_can_cook/src/models/system/system.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:it_can_cook/src/models/zalopay/payment_argument.dart';
import 'package:it_can_cook/src/screens/checkout/checkout_screen.dart';
import 'package:it_can_cook/src/screens/checkout/checkout_step1.dart';
import 'package:it_can_cook/src/screens/customplan/custom_plan.dart';
import 'package:it_can_cook/src/screens/delivery/home.dart';
import 'package:it_can_cook/src/screens/home/home_page.dart';
import 'package:it_can_cook/src/screens/login/login/login.dart';
import 'package:it_can_cook/src/screens/login/register/register.dart';
import 'package:it_can_cook/src/screens/login/welcome/welcome.dart';
import 'package:it_can_cook/src/screens/onboarding/onboarding.dart';
import 'package:it_can_cook/src/screens/payment/payment.dart';
import 'package:it_can_cook/src/screens/weekly_plan_custom/weekly_detail.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/dish_add.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/dish_add_list.dart';
import 'package:it_can_cook/src/screens/weekly_plane/dish/dish_detail.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/template_day.dart';
import 'package:it_can_cook/src/screens/weekly_plane/weekly/weekly_detail.dart';

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
        BlocProvider<TriggerBloc>(
          create: (BuildContext context) => TriggerBloc(),
        ),
        BlocProvider<WeeklyBloc>(
          create: (BuildContext context) =>
              WeeklyBloc()..add(FetchWeeklyEvent()),
        ),
        BlocProvider<RecipePlanBloc>(
          create: (BuildContext context) => RecipePlanBloc(),
        ),
        BlocProvider<CustomPlanBloc>(
          create: (BuildContext context) => CustomPlanBloc(),
        ),
        BlocProvider<RecipesAllBloc>(
          create: (BuildContext context) =>
              RecipesAllBloc()..add(FetchRecipesAllEvent("")),
          lazy: true,
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
                        weeklyPlan: routeSettings.arguments == null
                            ? WeeklyPlan(recipePlans: [])
                            : routeSettings.arguments as WeeklyPlan,
                      );
                    case "dish_detail":
                      return DishDetail(
                        recipe: routeSettings.arguments as RecipePlan,
                      );
                    case "dish_add":
                      return DishAdd(
                        args: routeSettings.arguments as DishArguments,
                      );
                    case "dish_add_list":
                      return DishAddList(
                        isShowAddButton: routeSettings.arguments as bool,
                      );
                    case "checkout":
                      return CheckoutScreen(
                        weeklyPlan: routeSettings.arguments as WeeklyPlan,
                      );
                    case "checkout1":
                      return CheckoutStep1(
                        weeklyPlan: routeSettings.arguments as WeeklyPlan,
                      );
                    case "payment":
                      return Payment(
                          routeSettings.arguments as PaymentArguemnt);
                    case "delivery":
                      return DeliveryHome();
                    case "onboarding":
                      return Onboarding();
                    case "custom_plan":
                      return const CustomPlanScreen();
                    case "weekly_custom_detail":
                      return WeeklyCustomDetailPage(
                          weeklyPlan: routeSettings.arguments as WeeklyPlan);
                    default:
                      // return Payment("hello");
                      return accountState != null
                          ? accountState.role?.toLowerCase() == 'shipper'
                              ? DeliveryHome()
                              : const HomePage()
                          : Onboarding();
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
