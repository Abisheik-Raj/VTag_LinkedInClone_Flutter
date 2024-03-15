// ignore_for_file: avoid_unnecessary_containers

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vtag/services/auth_gate.dart";
import "package:vtag/services/auth_service.dart";

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
            onTap: () {
              Provider.of<AuthService>(context, listen: false).logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthGate()),
                  (route) => false);
            },
            child: const Text("logout in account page")),
      ),
    );
  }
}
