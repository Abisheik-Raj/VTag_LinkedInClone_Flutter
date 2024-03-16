import "package:flutter/material.dart";
import "package:vtag/resources/colors.dart";

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const TextFieldComponent(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    const border =
        UnderlineInputBorder(borderSide: BorderSide(color: greyColor));

    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: blueColor,
      style: const TextStyle(
        color: blueColor,
        fontFamily: "PoppinsRegular",
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: hintText,
        floatingLabelStyle: const TextStyle(
            color: Colors.white,
            fontFamily: "PoppinsRegular",
            fontSize: 17,
            height: 0.1),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
      ),
    );
  }
}
