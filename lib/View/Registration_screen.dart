import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:phainoit_solutions/View/dashboard_page.dart';
import 'package:phainoit_solutions/global/global.dart';
import 'package:phainoit_solutions/global/main_button.dart';

class RegistrationScreen extends StatefulWidget {
  String mobilenumber;
  RegistrationScreen({super.key, required this.mobilenumber});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  File? imageFile;
  getImage() async {
    var pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        // path = pickedFile.path;
      });
    }
  }

  Future Registration() async {
    var response = await http.post(
        Uri.parse(
            "https://beta.phainoitsolutions.com/flutterassessment/apis/registration.php"),
        body: ({
          'first_name': firstName.text,
          'last_name': lastName.text,
          'mobile': widget.mobilenumber,
          'email': email.text,
          "API_KEY": "sXZ7tdYP7hy2qZKD9cL",
          "tnc": "1"
        }));

    var s = json.decode(response.body);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: s['message']);
      if (s['message'] == "Your account created successfully") {
        switchScreenReplacement(
            context,
            DashboardPage(
              firstName: firstName.text,
              lastName: lastName.text,
              email: email.text,
              mobile: widget.mobilenumber,
              // image: imageFile!,
            ));
      } else {
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Registration',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  imageFile != null
                      ? GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: FileImage(imageFile!),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: AssetImage('assets/1.png'),
                          ),
                        ),
                  spaceBetween,
                  TextField(
                    controller: firstName,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                    ),
                  ),
                  spaceBetween,
                  TextField(
                    controller: lastName,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    ),
                  ),
                  spaceBetween,
                  TextField(
                    enabled: false,
                    controller: mobile,
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: widget.mobilenumber,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  spaceBetween,
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    maxLines: 2,
                  ),
                  spaceBetween,
                  MainButton(
                      title: "Submit",
                      onPressed: () {
                        Registration();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
