import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phainoit_solutions/View/Registration_screen.dart';
import 'package:phainoit_solutions/global/main_button.dart';

import '../global/global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  String countryDial = "+91";
  int screenState = 0;

  Future SendOTP() async {
    var response = await http.post(
        Uri.parse(
            "https://beta.phainoitsolutions.com/flutterassessment/apis/sendOTP.php"),
        body: ({
          'mobile': mobilenumber.text,
          'page_type': "register",
          "API_KEY": "sXZ7tdYP7hy2qZKD9cL"
        }));

    var s = json.decode(response.body);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: s['message']);

      if (s['message'] == "Mobile number already exist") {
      } else {
        setState(() {
          screenState = 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: headingText,
            ),
            Text(
              "Please login to continue",
              style: descriptionText,
            ),
            spaceBetween,
            screenState == 1
                ? Column(
                    children: [
                      TextFormField(
                        controller: otp,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          hintText: "Enter OTP",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                      spaceBetween,
                      MainButton(
                          title: "Login",
                          onPressed: () {
                            if (otp.text == '9933') {
                              switchScreenPush(
                                  context,
                                  RegistrationScreen(
                                    mobilenumber: mobilenumber.text,
                                  ));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Enter correct OTP"),
                                  );
                                },
                              );
                            }
                          })
                    ],
                  )
                : Column(
                    children: [
                      IntlPhoneField(
                        controller: mobilenumber,
                        showCountryFlag: true,
                        flagsButtonPadding: EdgeInsets.only(left: 20),
                        showDropdownIcon: false,
                        disableLengthCheck: false,
                        initialValue: countryDial,
                        onCountryChanged: (country) {
                          setState(() {
                            countryDial = "+" + country.dialCode;
                          });
                        },
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        ),
                      ),
                      spaceBetween,
                      MainButton(
                          title: "Send OTP",
                          onPressed: () {
                            if (mobilenumber.text.length < 10) {
                              Fluttertoast.showToast(
                                  msg: 'Enter Mobile Number');
                            } else {
                              setState(() {
                                SendOTP();
                              });
                            }
                          })
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
