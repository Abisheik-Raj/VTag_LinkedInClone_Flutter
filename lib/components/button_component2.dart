import "package:flutter/material.dart";
import "package:vtag/resources/colors.dart";

class ButtonComponent2 extends StatelessWidget {
  const ButtonComponent2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
          child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )),
    );
  }
}
