import 'package:chat_app/Screens/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/userController.dart';
import '../Models/chat.dart';
import '../Models/user.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserController userController = Get.put(UserController());
  TextEditingController chatController = TextEditingController();
  String? loggedemail;
  String? chattingUsername;

  @override
  void initState() {
    super.initState();
    User chattingUser = userController.getChattingUser();
    chattingUsername = chattingUser.username;
    userController.readChats(chattingUser);
    loggedemail = userController.getUser().email;
  }

  void chatinsert() {
    String? loggedemail = userController.getUser().email;
    User chattingUser = userController.getChattingUser();
    String? chattingemail = chattingUser.email;

    DateTime dt = new DateTime.now();
    final date =
        '${dt.year}-${dt.month}-${dt.day} (${dt.hour}:${dt.minute}:${dt.second})';

    String chat = chatController.text;
    if (chat != "") {
      userController.insertChat(loggedemail!, chattingemail!, chat, date);
    }

    userController.readChats(chattingUser);
    chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Chat with $chattingUsername ...")),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: null,
                  controller: chatController,
                  decoration: InputDecoration(
                    hintText: "Message...",
                    hintStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
              ),

              // Send Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 11, 199, 246),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onPressed: () {
                    chatinsert();
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                  // backgroundColor: ColorConstant.lightBlueA100,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 11, 199, 246),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    minimumSize: Size(30, 40),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()));
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.only(right: 55),
                child: Text(
                  "$chattingUsername",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 117, 11, 255), fontSize: 25),
                ),
              ))),
            ],
          ),
          Expanded(
            child: Container(
              child: Obx(() => ListView.builder(
                  itemCount: userController.chatList.value.length,
                  itemBuilder: (context, index) {
                    Chat chat = userController.chatList.value[index];
                    print(chat.datetime);
                    print(loggedemail);
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: chat.fromFriend == loggedemail
                              ? Color.fromARGB(255, 106, 179, 239)
                              : Colors.yellow,
                        ),
                        height: 50,
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 8, bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex:
                                    3, // you can play with this value, by default it is 1
                                child: Text(
                                  chat.chatline!,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  chat.datetime!,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
