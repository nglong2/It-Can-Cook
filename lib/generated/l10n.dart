// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `it_can_cook`
  String get appTitle {
    return Intl.message(
      'it_can_cook',
      name: 'appTitle',
      desc: 'The title of the application',
      args: [],
    );
  }

  /// `A simple recipe app`
  String get appDescription {
    return Intl.message(
      'A simple recipe app',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Discover a menu that fully meets health needs!`
  String get onboardTitle1 {
    return Intl.message(
      'Discover a menu that fully meets health needs!',
      name: 'onboardTitle1',
      desc: '',
      args: [],
    );
  }

  /// `What do you need, We have it all!`
  String get onboardTitle2 {
    return Intl.message(
      'What do you need, We have it all!',
      name: 'onboardTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Connect with many experts`
  String get onboardTitle3 {
    return Intl.message(
      'Connect with many experts',
      name: 'onboardTitle3',
      desc: '',
      args: [],
    );
  }

  /// `1500+ standard meals help you get enough nutrients while still "saving money"`
  String get onboardDescription1 {
    return Intl.message(
      '1500+ standard meals help you get enough nutrients while still "saving money"',
      name: 'onboardDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Connect with delicious - nutritious - cheap supermarket partners`
  String get onboardDescription2 {
    return Intl.message(
      'Connect with delicious - nutritious - cheap supermarket partners',
      name: 'onboardDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Do you have any questions? Chat with real chefs`
  String get onboardDescription3 {
    return Intl.message(
      'Do you have any questions? Chat with real chefs',
      name: 'onboardDescription3',
      desc: '',
      args: [],
    );
  }

  /// `Passed`
  String get passed {
    return Intl.message(
      'Passed',
      name: 'passed',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Get started!`
  String get done {
    return Intl.message(
      'Get started!',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Cooking is really easy with I.T Can Cook!`
  String get login_welcome {
    return Intl.message(
      'Cooking is really easy with I.T Can Cook!',
      name: 'login_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
