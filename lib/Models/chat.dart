import 'package:chat_app/Models/user.dart';

class Chat {
  int? id;
  String? fromFriend;
  String? toFriend;
  String? chatline;
  String? datetime;

  Chat({this.id, this.fromFriend, this.toFriend, this.chatline, this.datetime});
}
