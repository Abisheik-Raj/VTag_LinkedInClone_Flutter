import "package:flutter/material.dart";
import "package:vtag/pages/login_screen.dart";
import "package:vtag/pages/signup_screen.dart";

class LoginOrRegisterScreen extends StatefulWidget {
  final void Function()? signupDoneConfirmation;

  const LoginOrRegisterScreen({
    super.key,
    required this.signupDoneConfirmation,
  });

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  bool showLoginScreen = true;
  void changeScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen == true) {
      return LoginScreen(
        changeScreen: changeScreen,
      );
    } else {
      return SignupScreen(
        signupDoneConfirmation: widget.signupDoneConfirmation,
        changeScreen: changeScreen,
      );
    }
  }
}
