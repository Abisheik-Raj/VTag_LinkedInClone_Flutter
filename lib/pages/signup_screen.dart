// ignore_for_file: avoid_unnecessary_containers, must_be_immutable, use_build_context_synchronously
import "package:flutter/material.dart";
import "package:vtag/components/button_component.dart";
import "package:vtag/components/button_component2.dart";
import "package:vtag/components/snackbar_component.dart";
import "package:vtag/components/textfield_component.dart";
import "package:vtag/resources/colors.dart";
import "package:vtag/services/auth_service.dart";
import "package:provider/provider.dart";

class SignupScreen extends StatefulWidget {
  void Function()? changeScreen;
  void Function()? signupDoneConfirmation;
  SignupScreen(
      {super.key,
      required this.changeScreen,
      required this.signupDoneConfirmation});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 35,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Please sign up.",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                    const Text(
                      "Enjoy the app power to the fullest!",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 15,
                          color: greyColor),
                    ),
                    const SizedBox(height: 50),
                    TextFieldComponent(
                        hintText: "Email",
                        obscureText: false,
                        controller: emailController),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldComponent(
                        hintText: "Password",
                        obscureText: true,
                        controller: passwordController),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () async {
                        try {
                          if (emailController.text.trim().isEmpty ||
                              passwordController.text.trim().isEmpty) {
                            showSnackbar(context,
                                "Please fill both email and password fields.");
                          } else if (!(emailController.text
                              .trim()
                              .split("@")[1]
                              .endsWith("vitstudent.ac.in"))) {
                            showSnackbar(context,
                                "Please use a VIT University email ID.");
                          } else {
                            setState(() {
                              loading = true;
                            });
                            await Provider.of<AuthService>(context,
                                    listen: false)
                                .signup(emailController.text.trim(),
                                    passwordController.text.trim());
                            widget.signupDoneConfirmation!();
                          }
                        } catch (e) {
                          final exception = e.toString().split(" ")[1];

                          if (exception == "weak-password") {
                            showSnackbar(context,
                                "Please use a stronger password. It should be at least 8 characters long.");
                          } else if (exception == "invalid-email") {
                            showSnackbar(
                                context, "Please enter a valid email address.");
                          } else if (exception == "email-already-in-use") {
                            showSnackbar(context,
                                "Email is already in use. Please use a different email.");
                          } else {
                            showSnackbar(context,
                                "An unexpected error occurred. Please try again later.");
                          }
                        } finally {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: loading == true
                          ? const ButtonComponent2()
                          : const ButtonComponent(
                              text: "Sign Up",
                            ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "By clicking on sign up, you agree to Vtag's",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                    const Text(
                      "Terms and Conditions of Use",
                      style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 200),
                    Center(
                      child: GestureDetector(
                        onTap: widget.changeScreen,
                        child: const Column(
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
