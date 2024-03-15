import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:vtag/pages/decision_screen.dart";
import "package:vtag/pages/login_or_register_page.dart";

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool signupDone = false;

  void signupDoneConfirmation() {
    setState(() {
      signupDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const DecisionScreen();
        } else {
          return LoginOrRegisterScreen(
            signupDoneConfirmation: signupDoneConfirmation,
          );
        }
      },
    );
  }
}
