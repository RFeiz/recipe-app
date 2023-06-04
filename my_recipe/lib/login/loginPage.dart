import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_recipe/login/introductionWidget.dart';
import 'package:my_recipe/login/loginButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 90),
              child: IntroductionWidget(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: LoginButton(),
            ),
          ),
        ],
      ),
    );
  }
}
