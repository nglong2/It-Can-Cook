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

  /// `Cooking is really easy with WeMealKit!`
  String get login_welcome {
    return Intl.message(
      'Cooking is really easy with WeMealKit!',
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

  /// `Dont have an account?`
  String get dont_have_account {
    return Intl.message(
      'Dont have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get please_enter_phone_number {
    return Intl.message(
      'Please enter phone number',
      name: 'please_enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter last name`
  String get please_enter_last_name {
    return Intl.message(
      'Please enter last name',
      name: 'please_enter_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter first name`
  String get please_enter_first_name {
    return Intl.message(
      'Please enter first name',
      name: 'please_enter_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get please_enter_password {
    return Intl.message(
      'Please enter password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password`
  String get please_enter_confirm_password {
    return Intl.message(
      'Please enter confirm password',
      name: 'please_enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get password_not_match {
    return Intl.message(
      'Password does not match',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get please_enter_valid_phone_number {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'please_enter_valid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get please_enter_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'please_enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get please_enter_email {
    return Intl.message(
      'Please enter email',
      name: 'please_enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get please_enter_valid_password {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'please_enter_valid_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email or phone number`
  String get please_enter_email_or_phone_number {
    return Intl.message(
      'Please enter email or phone number',
      name: 'please_enter_email_or_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be 10 digits long`
  String get please_enter_valid_phone_number_length {
    return Intl.message(
      'Phone number must be 10 digits long',
      name: 'please_enter_valid_phone_number_length',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must contain only digits`
  String get phone_number_must_contain_only_digits {
    return Intl.message(
      'Phone number must contain only digits',
      name: 'phone_number_must_contain_only_digits',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get enter_verification_code {
    return Intl.message(
      'Enter verification code',
      name: 'enter_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter verification code`
  String get please_enter_verification_code {
    return Intl.message(
      'Please enter verification code',
      name: 'please_enter_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Verification code must be 6 digits`
  String get verification_code_must_be_6_digits_long {
    return Intl.message(
      'Verification code must be 6 digits',
      name: 'verification_code_must_be_6_digits_long',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get add_to_cart {
    return Intl.message(
      'Checkout',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get old_password {
    return Intl.message(
      'Old password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm new password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter old password`
  String get please_enter_old_password {
    return Intl.message(
      'Please enter old password',
      name: 'please_enter_old_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get please_enter_new_password {
    return Intl.message(
      'Please enter new password',
      name: 'please_enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Change password successfully`
  String get change_password_success {
    return Intl.message(
      'Change password successfully',
      name: 'change_password_success',
      desc: '',
      args: [],
    );
  }

  /// `Custom package`
  String get custom_package {
    return Intl.message(
      'Custom package',
      name: 'custom_package',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get verification_code {
    return Intl.message(
      'Verification code',
      name: 'verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Total: `
  String get total {
    return Intl.message(
      'Total: ',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Number of people in house: `
  String get numberperoninhouse {
    return Intl.message(
      'Number of people in house: ',
      name: 'numberperoninhouse',
      desc: '',
      args: [],
    );
  }

  /// `Amount: `
  String get amount {
    return Intl.message(
      'Amount: ',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Person`
  String get person {
    return Intl.message(
      'Person',
      name: 'person',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `Steps`
  String get step {
    return Intl.message(
      'Steps',
      name: 'step',
      desc: '',
      args: [],
    );
  }

  /// `Breakfast`
  String get breakfast {
    return Intl.message(
      'Breakfast',
      name: 'breakfast',
      desc: '',
      args: [],
    );
  }

  /// `Lunch`
  String get lunch {
    return Intl.message(
      'Lunch',
      name: 'lunch',
      desc: '',
      args: [],
    );
  }

  /// `Dinner`
  String get dinner {
    return Intl.message(
      'Dinner',
      name: 'dinner',
      desc: '',
      args: [],
    );
  }

  /// `Add dish`
  String get add_dish {
    return Intl.message(
      'Add dish',
      name: 'add_dish',
      desc: '',
      args: [],
    );
  }

  /// `Get newest menu`
  String get get_newest_menu {
    return Intl.message(
      'Get newest menu',
      name: 'get_newest_menu',
      desc: '',
      args: [],
    );
  }

  /// `Custom Plan ➕`
  String get custom_plan_title {
    return Intl.message(
      'Custom Plan ➕',
      name: 'custom_plan_title',
      desc: '',
      args: [],
    );
  }

  /// `If you cant find any plan, you can create your own, we can provide you the recipe, its easy`
  String get custom_plan_description {
    return Intl.message(
      'If you cant find any plan, you can create your own, we can provide you the recipe, its easy',
      name: 'custom_plan_description',
      desc: '',
      args: [],
    );
  }

  /// `Pakaging method: `
  String get pakaging_method {
    return Intl.message(
      'Pakaging method: ',
      name: 'pakaging_method',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this dish?`
  String get delete_dish {
    return Intl.message(
      'Are you sure you want to delete this dish?',
      name: 'delete_dish',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Add dish for `
  String get add_dish_for {
    return Intl.message(
      'Add dish for ',
      name: 'add_dish_for',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `on`
  String get on {
    return Intl.message(
      'on',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Nutrion`
  String get nutrion {
    return Intl.message(
      'Nutrion',
      name: 'nutrion',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition facts`
  String get nutrition_facts {
    return Intl.message(
      'Nutrition facts',
      name: 'nutrition_facts',
      desc: '',
      args: [],
    );
  }

  /// `Serving Size: `
  String get serving_size {
    return Intl.message(
      'Serving Size: ',
      name: 'serving_size',
      desc: '',
      args: [],
    );
  }

  /// `Total Fat`
  String get total_fat {
    return Intl.message(
      'Total Fat',
      name: 'total_fat',
      desc: '',
      args: [],
    );
  }

  /// `Sodium`
  String get sodium {
    return Intl.message(
      'Sodium',
      name: 'sodium',
      desc: '',
      args: [],
    );
  }

  /// `Total Carbohydrate`
  String get total_carbohydrate {
    return Intl.message(
      'Total Carbohydrate',
      name: 'total_carbohydrate',
      desc: '',
      args: [],
    );
  }

  /// `Dietary Fiber`
  String get dietary_fiber {
    return Intl.message(
      'Dietary Fiber',
      name: 'dietary_fiber',
      desc: '',
      args: [],
    );
  }

  /// `Sugars`
  String get sugars {
    return Intl.message(
      'Sugars',
      name: 'sugars',
      desc: '',
      args: [],
    );
  }

  /// `Add to quickly plan`
  String get add_to_quickly_plan {
    return Intl.message(
      'Add to quickly plan',
      name: 'add_to_quickly_plan',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Only customer can login`
  String get only_customer_can_login {
    return Intl.message(
      'Only customer can login',
      name: 'only_customer_can_login',
      desc: '',
      args: [],
    );
  }

  /// `List of custom personal weekly plan`
  String get list_custom_personal_weekly_plan {
    return Intl.message(
      'List of custom personal weekly plan',
      name: 'list_custom_personal_weekly_plan',
      desc: '',
      args: [],
    );
  }

  /// `Add to custom plan successfully`
  String get add_to_custom_plan_success {
    return Intl.message(
      'Add to custom plan successfully',
      name: 'add_to_custom_plan_success',
      desc: '',
      args: [],
    );
  }

  /// `Send me to custom plan`
  String get send_me_to_custom_plan {
    return Intl.message(
      'Send me to custom plan',
      name: 'send_me_to_custom_plan',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Update plan`
  String get update_plan {
    return Intl.message(
      'Update plan',
      name: 'update_plan',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get list {
    return Intl.message(
      'List',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `Get current location`
  String get get_current_location {
    return Intl.message(
      'Get current location',
      name: 'get_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Order successfully`
  String get order_success {
    return Intl.message(
      'Order successfully',
      name: 'order_success',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `You dont have any plan!`
  String get you_dont_have_any_plan {
    return Intl.message(
      'You dont have any plan!',
      name: 'you_dont_have_any_plan',
      desc: '',
      args: [],
    );
  }

  /// `You dont have any order!`
  String get you_dont_have_any_order {
    return Intl.message(
      'You dont have any order!',
      name: 'you_dont_have_any_order',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to update this plan?`
  String get update_plan_confirmation {
    return Intl.message(
      'Are you sure you want to update this plan?',
      name: 'update_plan_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this plan?`
  String get delete_plan_confirmation {
    return Intl.message(
      'Are you sure you want to delete this plan?',
      name: 'delete_plan_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Preservation method: `
  String get preservationMethod {
    return Intl.message(
      'Preservation method: ',
      name: 'preservationMethod',
      desc: '',
      args: [],
    );
  }

  /// `Order information`
  String get order_information {
    return Intl.message(
      'Order information',
      name: 'order_information',
      desc: '',
      args: [],
    );
  }

  /// `Delivery to`
  String get delivery_to {
    return Intl.message(
      'Delivery to',
      name: 'delivery_to',
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
