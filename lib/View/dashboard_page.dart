import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phainoit_solutions/global/global.dart';
import 'package:phainoit_solutions/global/main_button.dart';

import 'login_page.dart';

class DashboardPage extends StatefulWidget {
  String firstName;
  String lastName;
  String email;
  String mobile;
  // File? image;
  DashboardPage(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      // this.image
      });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List UserData = [];
  Future getUserData() async {
    var response = await http.post(
        Uri.parse(
            "https://beta.phainoitsolutions.com/flutterassessment/apis/sendOTP.php"),
        body: ({'user_id': "1", "API_KEY": "sXZ7tdYP7hy2qZKD9cL"}));
    var convertjosn = json.decode(response.body);
    setState(() {
      UserData = convertjosn['result_array'];
      print(UserData.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("User Detail")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // widget.image == null
              //     ? CircleAvatar(
              //         radius: 60.0, backgroundImage: AssetImage('assets/1.png'))
              //     : CircleAvatar(
              //         radius: 60,
              //         backgroundImage: FileImage(widget.image!),
              //       ),
              spaceBetween,
              Text("Name: ${widget.firstName}${widget.lastName} "),
              spaceBetween,
              Text("Mobile Number: ${widget.mobile}"),
              spaceBetween,
              Text("Email: ${widget.email}"),
              spaceBetween,
              MainButton(
                  title: "Logout",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
