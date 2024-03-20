import "package:flutter/material.dart";
import "package:vtag/resources/colors.dart";

class SearchComponent extends StatelessWidget {
  final TextEditingController controller;
  final onSubmitted;

  const SearchComponent(
      {super.key, required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Color.fromRGBO(32, 34, 41, 1)));

    return SizedBox(
      height: 40,
      width: screenSize.width * 0.75,
      child: TextField(
        onSubmitted: onSubmitted,
        controller: controller,
        cursorColor: blueColor,
        style: const TextStyle(
            fontFamily: "PoppinsRegular", fontSize: 15, color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Color.fromRGBO(109, 113, 117, 1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          filled: true,
          fillColor: const Color.fromRGBO(32, 34, 41, 1),
          enabledBorder: border,
          focusedBorder: border,
          hintText: "Search",
          hintStyle: const TextStyle(
              fontFamily: "PoppinsSemiBold",
              fontSize: 15,
              color: Color.fromRGBO(109, 113, 117, 1)),
        ),
      ),
    );
  }
}
