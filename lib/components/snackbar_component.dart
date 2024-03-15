import "package:flutter/material.dart";

showSnackbar(context, content) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.fixed,
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(253, 228, 207, 1)),
      child: Text(
        '$content  ❌',
        style: const TextStyle(
            fontFamily: "PoppinsSemiBold", fontSize: 12, color: Colors.red),
      ),
    ),
    duration: const Duration(milliseconds: 800),
  ));
}
