import 'package:chat_app/Controllers/userController.dart';
import 'package:chat_app/Screens/logInScreen.dart';
import 'package:chat_app/Screens/termsAndConditions.dart';
import 'package:chat_app/Utils/databaseSetup.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

import '../Models/user.dart';
import 'DashboardScreen.dart';
import 'dashboardScreen2.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

  String errorMessageemail = '';
  String errorMessagepw = '';
  bool? agree = false;
  User? loggedUser;
  UserController userController = Get.put(UserController());

  void setUpdb() {
    DatabaseSetup databaseSetup = DatabaseSetup();
    databaseSetup.setUpDB();
    databaseSetup.CreateUserTable();
  }

  @override
  void initState() {
    super.initState();
    setUpdb();
  }

  void validateEmail(String val) {
    if (!EmailValidator.validate(val, true)) {
      setState(() {
        errorMessageemail = "Invalid Email Address";
      });
    } else {
      setState(() {
        errorMessageemail = "";
      });
    }
  }

  void validatePassword(String val) {
    if (val == "") {
      setState(() {
        errorMessagepw = "Enter Your Password";
      });
    }
  }

  void addUser() async {
    print("window ok");
    print(agree);
    if (agree == true &&
        emailcontroller != null &&
        passwordcontroller != null &&
        usernamecontroller != null) {
      userController.insertUser(emailcontroller.text, passwordcontroller.text,
          usernamecontroller.text);

      User? loggedusermoment = await userController.readUser(
          emailcontroller.text, passwordcontroller.text);

      if (loggedusermoment != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      }

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
      //print(userController.getName());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Check your details and submit"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Welcome!".tr)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            emailInputWidget(emailcontroller),
            passwordInputWidget(passwordcontroller),
            usernameInputWidget(usernamecontroller),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditionsScreen()));
                },
                child: const Text(
                    "By Signing up I understand and agree to Terms and Conditions",
                    style: TextStyle(color: Color.fromARGB(255, 52, 15, 239))),
              ),
              value: agree,
              onChanged: (bool? value) {
                setState(() {
                  agree = value!;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30, top: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 11, 199, 246),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(200, 40), //////// HERE
                  ),
                  onPressed: () {
                    addUser();
                  },
                  child: const Text("Sign Up")),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LogInSCreen()));
              },
              child: const Text(
                "Already have an Account. Click here to Sign In",
                style: TextStyle(color: Color.fromARGB(255, 52, 15, 239)),
              ),
            ),
          ],
        ));
  }

  Widget emailInputWidget(TextEditingController ctrl) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: ctrl,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              //errorText: "Error",
              border: OutlineInputBorder(),
              labelText: "Email Address",
              hintText: "Enter Your Email Address",
            ),
            onChanged: (val) {
              validateEmail(val);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorMessageemail,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordInputWidget(TextEditingController ctrl) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: ctrl,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              //errorText: "Error",
              border: OutlineInputBorder(),
              labelText: "Password",
              hintText: "Enter Your Password",
            ),
            onChanged: (val) {
              validatePassword(val);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorMessagepw,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget usernameInputWidget(TextEditingController ctrl) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: ctrl,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              //errorText: "Error",
              border: OutlineInputBorder(),
              labelText: "Username",
              hintText: "Enter Your Username",
            ),
          ),
        ),
      ],
    );
  }
}
