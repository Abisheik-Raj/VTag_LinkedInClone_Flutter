// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, use_build_context_synchronously, must_be_immutable

import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:vtag/components/button_component.dart";
import "package:vtag/components/button_component2.dart";
import "package:vtag/pages/main_screen.dart";
import "package:vtag/resources/colors.dart";
import "package:http/http.dart" as request;
import "package:vtag/services/auth_service.dart";

class OTPVerificationScreen extends StatefulWidget {
  String email;
  String password;

  OTPVerificationScreen(
      {super.key, required this.email, required this.password});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late Future<int> OTP;
  bool loading = false;

  Future<int> generateOTP() async {
    var url = Uri.parse(
        "http://abisheikraj.pythonanywhere.com/SendMail/${widget.email}");
    var response = await request.get(url);

    final responseData = jsonDecode(response.body);
    final OTP = responseData["OTP"];
    setState(() {});
    return OTP;
  }

  @override
  void initState() {
    super.initState();
    OTP = generateOTP();
  }

  final box1Controller = TextEditingController();
  final box2Controller = TextEditingController();
  final box3Controller = TextEditingController();
  final box4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: greenColor));

    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                "Verify OTP",
                style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 35,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              const Text(
                "OTP is sent to your registered email.",
                style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    fontSize: 15,
                    color: Colors.grey),
              ),
              const SizedBox(height: 50),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 74,
                      width: 70,
                      child: TextField(
                        controller: box1Controller,
                        onChanged: (value) {
                          if (value.isEmpty) {
                          } else {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        cursorColor: greenColor,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border),
                      ),
                    ),
                    SizedBox(
                      height: 74,
                      width: 70,
                      child: TextField(
                        controller: box2Controller,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          } else {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        cursorColor: greenColor,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border),
                      ),
                    ),
                    SizedBox(
                      height: 74,
                      width: 70,
                      child: TextField(
                        controller: box3Controller,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          } else {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        cursorColor: greenColor,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border),
                      ),
                    ),
                    SizedBox(
                      height: 74,
                      width: 70,
                      child: TextField(
                        controller: box4Controller,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        cursorColor: greenColor,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't you receive OTP? ",
                    style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      OTP = generateOTP();
                    },
                    child: const Text(
                      "Resend OTP",
                      style: TextStyle(
                          fontFamily: "PoppinsSemibold",
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                  onTap: () async {
                    try {
                      final int OTPEntered = int.parse(box1Controller.text +
                          box2Controller.text +
                          box3Controller.text +
                          box4Controller.text);

                      final generatedOTP = await OTP;

                      if (generatedOTP == OTPEntered) {
                        setState(() {
                          loading = true;
                        });

                        await Provider.of<AuthService>(context, listen: false)
                            .login2(widget.email, widget.password);

                        await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                            (route) => false);
                      }
                    } catch (e) {
                      print("Error while trying to generate OTP!");
                    } finally {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  child: loading == true
                      ? const ButtonComponent2()
                      : const ButtonComponent(text: "Submit"))
            ],
          ),
        ),
      ),
    ));
  }
}
