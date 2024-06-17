import 'package:flutter/material.dart';
import 'package:practice/firebase/pages/login_screen.dart';
import 'package:practice/firebase/pages/sign_up_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(showRegisterPage: toggleScreen);
    } else {
      return SignUpScreen(
        showLoginPage: toggleScreen,
      );
    }
  }
}
