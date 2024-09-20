import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:animate_do/animate_do.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/custom_plan/custom_plan_bloc.dart';
import 'package:it_can_cook/src/bloc/weekly_plan_bloc/weekly_bloc.dart';
import 'package:it_can_cook/src/controller/account.dart';
import 'package:it_can_cook/src/models/account/account.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController(); // Add the verification code controller
  final _formKey = GlobalKey<FormState>(); // Add the form key
  final _formKeyVerification =
      GlobalKey<FormState>(); // Add the verification form key

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> hadleLogin(String email, String pass) async {
    context.loaderOverlay.show();
    AccountController().login(email, pass).then((value) {
      if (value != null) {
        context.loaderOverlay.hide();
        context.read<AccountBloc>().add(LoginEvent(value));
        if (value.role?.toLowerCase() == 'shipper') {
          Navigator.pushNamedAndRemoveUntil(
              context, 'delivery', (route) => false);
        } else {
          //role!=customer
          if (value.role?.toLowerCase() != 'customer') {
            //show dialog
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(S.of(context).error),
                    content: Text(S.of(context).only_customer_can_login),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).yes))
                    ],
                  );
                });
          } else {
            context.read<CustomPlanBloc>().add(FetchCustomPlanEvent(value.id!));
            context.read<WeeklyBloc>().add(FetchWeeklyEvent());
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          }
        }
      }
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      print("error" + error.toString());
      if (error.toString().contains("check mail")) {
        handleVerifite(email);
        return;
      } else {
        context.loaderOverlay.hide();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(S.of(context).error),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).yes))
                ],
              );
            });
      }
    });
  }

  Future<void> handleVerifite(String email) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(S.of(context).enter_verification_code),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKeyVerification,
                    child: TextFormField(
                      controller: _verificationCodeController,
                      keyboardType: TextInputType.text,
                      maxLength: 6,
                      decoration: InputDecoration(
                        labelText: S.current.verification_code,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).please_enter_verification_code;
                        }
                        if (value.length != 6) {
                          return S
                              .of(context)
                              .verification_code_must_be_6_digits_long;
                        }
                        // Add your verification code validation logic here
                        return null;
                      },
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).cancel),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKeyVerification.currentState!.validate()) {
                      final code = _verificationCodeController.text;
                      context.loaderOverlay.show();
                      AccountController().sendEmail(email, code).then((value) {
                        context.loaderOverlay.hide();
                        if (value) {
                          // go to login page
                          Navigator.pop(context);
                        }
                      }).onError((error, stackTrace) {
                        context.loaderOverlay.hide();
                        //show dialog
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(S.of(context).error),
                                content: Text(error.toString()),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(S.of(context).yes))
                                ],
                              );
                            });
                      });
                    }
                  },
                  child: Text(S.of(context).verify),
                )
              ]);
        });
  }

//hadle forgot password
  Future<void> hadleForgotPassword(String email) async {
    context.loaderOverlay.show();
    AccountController().forgotPassword(email).then((value) {
      context.loaderOverlay.hide();
      if (value) {
        //show dialog
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(S.of(context).success),
                content: Text(S.of(context).please_check_your_email),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).yes))
                ],
              );
            });
      }
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      //show dialog
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(S.of(context).error),
              content: Text(error.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).yes))
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountModel?>(
      builder: (context, state) {
        return LoaderOverlay(
            child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    S.of(context).login,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: // theme is bright then 1 else 0.5
                            Theme.of(context).brightness == Brightness.light
                                ? 1
                                : 0.4,
                        image: const AssetImage("assets/images/login/bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Form(
                        // Wrap the form fields with a Form widget
                        key: _formKey, // Assign the form key
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: <Widget>[
                                FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: Text(
                                      S.of(context).login,
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: <Widget>[
                                  FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1200),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S
                                              .of(context)
                                              .please_enter_email;
                                        }
                                        // Add your email validation logic here
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1300),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: S.of(context).password,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S
                                              .of(context)
                                              .please_enter_password;
                                        }
                                        if (value.length < 6) {
                                          return S
                                              .of(context)
                                              .please_enter_valid_password;
                                        }
                                        // Add your password validation logic here
                                        return null;
                                      },
                                      obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1400),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right:
                                              BorderSide(color: Colors.black),
                                        )),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 60,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final email = _emailController.text;
                                          final password =
                                              _passwordController.text;
                                          var body = {
                                            'emailOrUserName': email,
                                            'password': password,
                                          };

                                          await hadleLogin(
                                              body['emailOrUserName']!,
                                              body['password']!);
                                          // Add your login logic here using email and password
                                        }
                                      },
                                      color: Colors.orangeAccent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Text(
                                        S.of(context).login,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                )),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1500),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("${S.of(context).dont_have_account} ",
                                        style: const TextStyle(fontSize: 16)),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, 'register');
                                      },
                                      child: Text(
                                        S.of(context).register,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            const SizedBox(height: 20),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1500),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if (_emailController.text.isEmpty) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title:
                                                      Text(S.of(context).error),
                                                  content: Text(S
                                                      .of(context)
                                                      .please_enter_email),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                            S.of(context).yes))
                                                  ],
                                                );
                                              });
                                          return;
                                        }
                                        hadleForgotPassword(
                                            _emailController.text);
                                      },
                                      child: Text(
                                        S.of(context).forgot_password,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
      },
    );
  }
}
