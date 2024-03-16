// ignore_for_file: avoid_unnecessary_containers, must_be_immutable, use_build_context_synchronously, avoid_print

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:http/http.dart" as request;
import "package:vtag/components/button_component.dart";
import "package:vtag/components/button_component2.dart";
import "package:vtag/components/snackbar_component.dart";
import "package:vtag/components/textfield_component.dart";

import "package:vtag/resources/colors.dart";
import "package:vtag/services/auth_service.dart";
import "package:provider/provider.dart";

class LoginScreen extends StatefulWidget {
  void Function()? changeScreen;
  LoginScreen({super.key, required this.changeScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Log In",
                      style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 35,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Please, log in to your account,",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 15,
                          color: greyColor),
                    ),
                    const Text(
                      "It takes less than a minute.",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 15,
                          color: greyColor),
                    ),
                    const SizedBox(height: 50),
                    TextFieldComponent(
                      hintText: "Email",
                      obscureText: false,
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldComponent(
                        hintText: "Password",
                        obscureText: true,
                        controller: passwordController),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () async {
                          var url = Uri.parse(
                              "http://abisheikraj.pythonanywhere.com/SendMail/");
                          var response = await request.get(url);
                          print(response.body);
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              fontSize: 15,
                              color: greyColor),
                        ),
                      ),
                    ),
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
                                .login(emailController.text.trim(),
                                    passwordController.text.trim(), context);
                          }
                        } catch (e) {
                          showSnackbar(context, "Invalid email or password!");
                        } finally {
                          setState(() {
                            loading == false;
                          });
                        }
                      },
                      child: loading == true
                          ? const ButtonComponent2()
                          : const ButtonComponent(
                              text: "Log In",
                            ),
                    ),
                    const SizedBox(height: 200),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 15,
                                color: greyColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: widget.changeScreen,
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 15),
                            ),
                          ),
                        ],
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
