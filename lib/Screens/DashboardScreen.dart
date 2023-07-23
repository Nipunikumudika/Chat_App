import 'package:chat_app/Controllers/userController.dart';
import 'package:chat_app/Models/user.dart';
import 'package:chat_app/Screens/chatScreen.dart';
import 'package:chat_app/Screens/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/databaseSetup.dart';
import 'dashboardScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void setUpdb() {
    DatabaseSetup databaseSetup = DatabaseSetup();
  }

  UserController userController = Get.put(UserController());
  User? loggedUser;
  String? loggedUserUsername;

  @override
  void initState() {
    super.initState();
    loggedUser = userController.loggedUser.value;
    loggedUserUsername = loggedUser!.username;
    userController.clearusers();
    userController.readUsers();
    userController.clearchats();
  }

  void gotoChatScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Welcome $loggedUserUsername to Hello Chat...")),
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
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("You are in Home"),
              duration: Duration(seconds: 1),
              backgroundColor: Color.fromARGB(255, 87, 128, 241),
            ));
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SettingsScreen()));
          }
        },
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10, top: 15),
          child: Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Obx(() => ListView.builder(
                itemCount: userController.userList.value.length,
                itemBuilder: (context, index) {
                  User user = userController.userList.value[index];
                  return GestureDetector(
                    onTap: () {
                      print(user.username);
                      userController.setChattingUser(user);
                      gotoChatScreen();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 106, 179, 239)),
                      height: 50,
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(user.username!),
                      ),
                    ),
                  );
                })),
          ),
        ),
      ]),
    );
  }
}
