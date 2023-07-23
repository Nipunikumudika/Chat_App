import 'package:chat_app/Screens/logInScreen.dart';
import 'package:chat_app/Services/userDAO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/userController.dart';
import '../Models/user.dart';
import 'DashboardScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserController userController = Get.put(UserController());
  User? loggedUser;
  String? loggedUserUsername;
  void changeUsername() {
    UserDAO userDAO = UserDAO();

    if (usernameController.text != "") {
      userDAO.update(loggedUser!, usernameController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Updated"),
      ));
      usernameController.text = "";
    }
  }

  @override
  void initState() {
    super.initState();
    loggedUser = userController.loggedUser.value;
    loggedUserUsername = loggedUser!.username;
    userController.readUsers();
    userController.clearchats();
  }

  TextEditingController usernameController = TextEditingController();
  String? selectedLanguage;
  List<String> languages = ['English', 'Sinhala']; // Option 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome!".tr)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 219, 241, 243),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
          } else if (index == 1) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("You are in Settings"),
              duration: Duration(seconds: 1),
              backgroundColor: Color.fromARGB(255, 87, 128, 241),
            ));
          }
        },
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10, top: 15),
          child: Center(
            child: Text(
              "Settings",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Edit Profile",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(),
              labelText: "Username",
              hintText: "Enter Your Username",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: ElevatedButton(
              onPressed: () {
                changeUsername();
              },
              child: Text("Change Username")),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change Language",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        DropdownButton(
          hint: Text('Please choose a location'), // Not necessary for Option 1
          value: selectedLanguage,
          onChanged: (newValue) {
            setState(() {
              selectedLanguage = newValue as String?;
              if (selectedLanguage == 'English') {
                print("eng");
                var locale = Locale('en', 'US');
                Get.updateLocale(locale);
              } else {
                print("sin");
                var locale = Locale('si', 'LK');
                Get.updateLocale(locale);
              }
            });
          },
          items: languages.map((location) {
            return DropdownMenuItem(
              child: new Text(location),
              value: location,
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LogInSCreen()));
              },
              child: Text("Go".tr)),
        ),
      ]),
    );
  }
}
