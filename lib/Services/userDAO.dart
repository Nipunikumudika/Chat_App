import 'package:chat_app/Models/user.dart';
import 'package:get/get.dart';

import '../Controllers/userController.dart';
import '../Models/chat.dart';
import '../Utils/databaseSetup.dart';

class UserDAO {
  UserController userController = Get.put(UserController());

  var dbConnection;
  UserDAO() {
    //make DB connection
    makeConnection();
  }

  void makeConnection() async {
    print("go to create database");
    this.dbConnection = await DatabaseSetup().getDatabaseInstance();
  }

  //insert a row
  Future<int> insertUser(User user) async {
    int outputID = -1;
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    await dbConnection.transaction((txn) async {
      outputID = await txn.rawInsert(
          'INSERT INTO Users(email, password ,username) VALUES("${user.email}", "${user.password}","${user.username}")');
    });
    print(outputID);
    return outputID;
  }

  Future<int> insertChat(Chat chat) async {
    int outputID = -1;
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    await dbConnection.transaction((txn) async {
      outputID = await txn.rawInsert(
          'INSERT INTO Chats(fromfriend, tofriend ,chatline,time) VALUES("${chat.fromFriend}", "${chat.toFriend}","${chat.chatline}","${chat.datetime}")');
    });
    print(outputID);
    return outputID;
  }

  Future<User?> getLogin(String? email, String? password) async {
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    var res = await dbConnection.rawQuery(
        "SELECT * FROM Users WHERE email = '$email' and password = '$password'");
    if (res.length > 0) {
      return new User.fromMap(res.first);
    } else {
      return null;
    }
  }

  //read all users
  Future<List<Map>> readUSER() async {
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    List<Map> list = await dbConnection.rawQuery('Select * FROM Users');
    print(list);
    return list;
  }

  Future<List<Map>> readCHAT1(User chatter) async {
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    User usr = userController.getUser();

    String? friend1 = usr.email;
    String? friend2 = chatter.email;

    print("friend1+friend2");
    print(friend1);
    print(friend2);
    List<Map> list1 = await dbConnection.rawQuery(
        "SELECT * FROM Chats WHERE fromfriend = '$friend1' and tofriend = '$friend2' ");

    // List<Map> list2 = await dbConnection.rawQuery(
    //     "SELECT * FROM Chats WHERE fromfriend = '$friend2' and tofriend = '$friend1' ");
    print("dao1");
    print(list1);

    return list1;
  }

  Future<List<Map>> readCHAT2(User chatter) async {
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    User usr = userController.getUser();

    String? friend1 = usr.email;
    String? friend2 = chatter.email;
    print("friend1+friend2");
    print(friend1);
    print(friend2);
    // List<Map> list1 = await dbConnection.rawQuery(
    //     "SELECT * FROM Chats WHERE fromfriend = '$friend1' and tofriend = '$friend2' ");

    List<Map> list2 = await dbConnection.rawQuery(
        "SELECT * FROM Chats WHERE fromfriend = '$friend2' and tofriend = '$friend1' ");
    print("dao2");
    print(list2);
    return list2;
  }

  void update(User user, String username) async {
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    int updateCount = await dbConnection.rawUpdate('''
      UPDATE Users
      SET username = ?
      WHERE email =?
    ''', [username, user.email]);
  }
}
