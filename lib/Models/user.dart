import 'package:chat_app/Models/chat.dart';

class User {
  int? id;
  String? username;
  String? password;
  String? email;

  User({this.id, this.email, this.username, this.password});

  User.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.email = obj['email'];
    this.username = obj['username'];
    this.password = obj['password'];
  }

  // String? get _username => username;
  // String? get _password => password;

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["username"] = username;
  //   map["password"] = password;
  //   return map;
  // }
}
