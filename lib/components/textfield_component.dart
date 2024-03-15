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
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: greyColor));

    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      style: const TextStyle(
          color: Colors.black, fontFamily: "PoppinsRegular", fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            color: greyColor, fontFamily: "PoppinsRegular", fontSize: 15),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
      ),
    );
  }
}
