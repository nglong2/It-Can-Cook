import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:animate_do/animate_do.dart';
import 'package:it_can_cook/src/api/rest.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add the form key

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).login,
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
                              S.of(context).login,
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
                                  var body = {
                                    'emailOrUserName': email,
                                    'password': password,
                                  };
                                  // Navigator.pushReplacementNamed(
                                  //     context, "home");
                                  RestApi()
                                      .post("api/auth/login", body)
                                      .then((value) async => {
                                            if (value.statusCode == 200)
                                              {
                                                if (jsonDecode(value.body)[
                                                        "statusCode"] ==
                                                    200)
                                                  {
                                                    //decode jwt

                                                    await Navigator
                                                        .pushReplacementNamed(
                                                            context, "home")
                                                  }
                                                else
                                                  {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text("Fail"),
                                                            content: Text(
                                                                jsonDecode(value
                                                                        .body)[
                                                                    "message"]),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text("OK"),
                                                              )
                                                            ],
                                                          );
                                                        })
                                                  }
                                              }
                                            else
                                              {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text("Error"),
                                                        content: Text(
                                                            "Error From Server"),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text("OK"),
                                                          )
                                                        ],
                                                      );
                                                    })
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
                                S.of(context).login,
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}