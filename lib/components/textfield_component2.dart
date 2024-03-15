import "package:flutter/material.dart";
import "package:vtag/resources/colors.dart";

class TextFieldComponent2 extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  const TextFieldComponent2(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.textInputType});

  @override
  State<TextFieldComponent2> createState() => _TextFieldComponent2State();
}

class _TextFieldComponent2State extends State<TextFieldComponent2> {
  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black));

    final focusedBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: greyColor));

    return TextField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      cursorColor: Colors.black,
      style: const TextStyle(
          color: Colors.black, fontFamily: "PoppinsRegular", fontSize: 15),
      decoration: InputDecoration(
        // suffixIcon: Icon(
        //   size: 25,
        //   MdiIcons.alphaX,
        //   color: Colors.black,
        // ),
        suffix: GestureDetector(
          onTap: () {
            widget.controller.text = "";
          },
          child: const Text(
            "✖",
            style: TextStyle(
                color: Colors.black, fontFamily: "PoppinsBold", fontSize: 12),
          ),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            color: greyColor, fontFamily: "PoppinsRegular", fontSize: 12),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        disabledBorder: enabledBorder,
      ),
    );
  }
}
