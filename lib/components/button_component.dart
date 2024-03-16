import "package:flutter/material.dart";
import "package:vtag/resources/colors.dart";

class ButtonComponent extends StatelessWidget {
  final String text;
  const ButtonComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontFamily: "PoppinsSemiBold", fontSize: 15),
        ),
      ),
    );
  }
}
