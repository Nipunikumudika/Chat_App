import 'package:chat_app/Models/chat.dart';
import 'package:chat_app/Services/userDAO.dart';
import 'package:get/get.dart';

import '../Models/user.dart';

class UserController extends GetxController {
  var userList = <User>[].obs;
  var chatList = <Chat>[].obs;

  // var friendList = <User>[].obs;

  var loggedUser = User().obs;

  var chattingUser = User().obs;

  void setUser(User usr) {
    loggedUser.value = usr;
  }

  User getUser() {
    return loggedUser.value;
  }

  void setChattingUser(User usr) {
    chattingUser.value = usr;
  }

  User getChattingUser() {
    return chattingUser.value;
  }

  void insertUser(String email, String password, String username) async {
    User user = User(email: email, password: password, username: username);

    UserDAO userDoDAO = UserDAO();

    int id = await userDoDAO.insertUser(user);

    user.id = id;
  }

  void insertChat(
      String fromfriend, String tofriend, String chatline, String time) async {
    Chat chat = Chat(
        fromFriend: fromfriend,
        toFriend: tofriend,
        chatline: chatline,
        datetime: time);

    UserDAO userDoDAO = UserDAO();

    int id = await userDoDAO.insertChat(chat);
    print("chat inserted");
    chat.id = id;
  }

  //String? loggedUserUsername;

  Future<User?> readUser(String email, String password) async {
    User user = User(email: email, password: password);

    UserDAO userDoDAO = UserDAO();

    User? loggedusernow = await userDoDAO.getLogin(user.email, user.password);
    if (loggedusernow != null) {
      setUser(loggedusernow);
      return Future.value(loggedusernow);
    } else {
      print("no user found");
      return null;
    }
  }

  Future<void> readUsers() async {
    UserDAO userDAO = UserDAO();
    List<Map> userL = await userDAO.readUSER();
    for (Map oneT in userL) {
      User user = User(
          email: oneT["email"],
          username: oneT["username"],
          password: oneT["password"],
          id: oneT["id"]);
      if (!(userList.map((item) => item.email).contains(user.email))) {
        // print(loggedUser.value.email);
        // print(user.email);
        if (loggedUser.value.email != user.email) {
          userList.add(user);
        }
      }
    }
  }

  void clearchats() {
    chatList = <Chat>[].obs;
  }

  void clearusers() {
    userList = <User>[].obs;
  }

  Future<void> readChats(User chatter) async {
    User usr = getChattingUser();
    UserDAO userDAO = UserDAO();
    List<Map> chatL1 = await userDAO.readCHAT1(usr);
    List<Map> chatL2 = await userDAO.readCHAT2(usr);

    print(chatL1);
    print("chat2");
    print(chatL2);
    print("combine");
    print(chatL1 + chatL2);

    for (Map oneT in chatL1) {
      Chat chat = Chat(
          fromFriend: oneT["fromfriend"],
          toFriend: oneT["tofriend"],
          chatline: oneT["chatline"],
          datetime: oneT["time"],
          id: oneT["id"]);

      print("chat.fromFriend");
      print(chat.fromFriend);
      print("chat.toFriend");
      print(chat.toFriend);

      if (!(chatList.map((item) => item.id).contains(chat.id))) {
        chatList.add(chat);
      }
      chatList.sort((a, b) => a.id!.compareTo(b.id!));
    }

    for (Map oneT in chatL2) {
      Chat chat = Chat(
          fromFriend: oneT["fromfriend"],
          toFriend: oneT["tofriend"],
          chatline: oneT["chatline"],
          datetime: oneT["time"],
          id: oneT["id"]);
      if (!(chatList.map((item) => item.id).contains(chat.id))) {
        chatList.add(chat);
      }

      chatList.sort((a, b) => a.id!.compareTo(b.id!));
    }
  }

  // Update some record

}
