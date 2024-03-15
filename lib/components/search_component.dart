import "package:flutter/material.dart";
import "package:vtag/resources/colors.dart";

class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: lightWhiteColor));

    return SizedBox(
      height: 40,
      width: screenSize.width * 0.7,
      child: TextField(
        cursorColor: Colors.black,
        style: const TextStyle(fontFamily: "PoppinsSemiBold", fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: blueColor,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          filled: true,
          fillColor: lightWhiteColor,
          enabledBorder: border,
          focusedBorder: border,
          hintText: "Search",
          hintStyle: const TextStyle(
              fontFamily: "PoppinsSemiBold", fontSize: 15, color: greyColor),
        ),
      ),
    );
  }
}
