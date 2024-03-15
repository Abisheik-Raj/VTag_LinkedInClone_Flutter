import "package:flutter/material.dart";

class SignupPageProgessIndicator extends StatelessWidget {
  final Color fillColor;
  const SignupPageProgessIndicator({super.key, required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
          color: fillColor, borderRadius: BorderRadius.circular(15)),
    );
  }
}
