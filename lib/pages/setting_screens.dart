import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vtag/services/auth_service.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              Provider.of<AuthService>(context, listen: false).logout();
              Navigator.pop(context);
            },
            child: const Text("Logout",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "PoppinsSemibold",
                    fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
