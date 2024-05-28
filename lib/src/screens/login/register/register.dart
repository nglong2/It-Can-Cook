import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:animate_do/animate_do.dart';
import 'package:it_can_cook/src/api/rest.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeyVerification = GlobalKey<FormState>();

  // Add the form key

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _verificationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).register,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: // theme is bright then 1 else 0.5
                    Theme.of(context).brightness == Brightness.light ? 1 : 0.4,
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
                            duration: const Duration(milliseconds: 1000),
                            child: Text(
                              S.of(context).register,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).please_enter_email;
                                }
                                // Add your email validation logic here
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: S.of(context).password,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).please_enter_password;
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
                          const SizedBox(height: 10),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: TextFormField(
                              controller: _passwordConfirmController,
                              decoration: InputDecoration(
                                labelText: S.of(context).confirm_password,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_confirm_password;
                                }
                                if (value.length < 6) {
                                  return S
                                      .of(context)
                                      .please_enter_valid_password;
                                }
                                if (value != _passwordController.text) {
                                  return S.of(context).password_not_match;
                                }
                                // Add your password validation logic here
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                labelText: S.of(context).first_name,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).please_enter_first_name;
                                }
                                // Add your email validation logic here
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                labelText: S.of(context).last_name,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).please_enter_last_name;
                                }
                                // Add your email validation logic here
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: S.of(context).phone_number,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_phone_number;
                                }
                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return S
                                      .of(context)
                                      .phone_number_must_contain_only_digits;
                                }
                                if (value.length != 10) {
                                  return S
                                      .of(context)
                                      .please_enter_valid_phone_number_length;
                                }

                                // Add your email validation logic here
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding: const EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: const Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                )),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text;
                                  final password = _passwordController.text;
                                  final passwordConfirm =
                                      _passwordConfirmController.text;
                                  final firstName = _firstNameController.text;
                                  final lastName = _lastNameController.text;
                                  final phone = _phoneController.text;
                                  var data = {
                                    'email': email,
                                    'password': password,
                                    'confirmPassword': passwordConfirm,
                                    'firstName': firstName,
                                    'lastName': lastName,
                                    'phone': phone
                                  };
                                  RestApi()
                                      .post('api/auth/register', data)
                                      .then((response) {
                                    if (response.statusCode == 200) {
                                      // Handle successful response
                                      if (jsonDecode(
                                              response.body)['statusCode'] ==
                                          200) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(S
                                                    .of(context)
                                                    .enter_verification_code),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Form(
                                                      key: _formKeyVerification,
                                                      child: TextFormField(
                                                        controller:
                                                            _verificationCodeController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        maxLength: 6,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Verification Code',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return S
                                                                .of(context)
                                                                .please_enter_verification_code;
                                                          }
                                                          if (value.length !=
                                                              6) {
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
                                                    child: Text(
                                                        S.of(context).cancel),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      if (_formKeyVerification
                                                          .currentState!
                                                          .validate()) {
                                                        // Process the verification code
                                                        String
                                                            verificationCode =
                                                            _verificationCodeController
                                                                .text;
                                                        // Add your verification code processing logic here
                                                      }
                                                    },
                                                    child: Text(
                                                        S.of(context).submit),
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    Text(S.of(context).error),
                                                content: Text(jsonDecode(
                                                    response.body)['message']),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    } else {
                                      // Handle error response
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(S.of(context).error),
                                              content: Text(
                                                  'An error occurred. Please try again later.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  });
                                  // Add your login logic here using email and password
                                }
                              },
                              color: Colors.orangeAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                S.of(context).register,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ),
                        )),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 120),
                            Text(S.of(context).already_have_account + " ",
                                style: const TextStyle(fontSize: 16)),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, 'login');
                              },
                              child: Text(
                                S.of(context).login,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
