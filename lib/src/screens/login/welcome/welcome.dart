import 'package:flutter/material.dart';
import 'package:it_can_cook/generated/l10n.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20),
          color: const Color(0xFFFF7A00),
          child: Column(
            children: <Widget>[
              const Image(image: AssetImage('assets/images/login/1.png')),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  S.of(context).login_welcome,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      height: 1.2,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the value as needed
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize:
                        MainAxisSize.max, // To minimize the button's size
                    children: [
                      Text(
                        "${S.of(context).register}  ",
                        style: const TextStyle(fontSize: 20, height: 3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${S.of(context).already_have_account}  ",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            S.of(context).login,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              shadows: [
                                Shadow(
                                    color: Colors.white, offset: Offset(0, -5))
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 2,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
