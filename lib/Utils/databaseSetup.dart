import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/user.dart';

class DatabaseSetup {
  static String _DBNAme = 'my_db_chat.db';
  void setUpDB() async {
    var db = await openDatabase(_DBNAme);
    await db.close();
  }

  void CreateUserTable() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DBNAme);
    print(path);
    //await deleteDatabase(path);
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Users (email TEXT PRIMARY KEY, password TEXT,username TEXT)');
      print("users table created");
      await db.execute(
          'CREATE TABLE Chats (id INTEGER PRIMARY KEY, fromfriend TEXT, tofriend TEXT,chatline TEXT,time TEXT)');
      print("Chats table created");
      print("Chats table created");
    });
  }

  Future<Database> getDatabaseInstance() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DBNAme);

// open the database
    Database database = await openDatabase(path, version: 1);
    return database;
  }
}
