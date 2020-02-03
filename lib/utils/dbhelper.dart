import 'dart:io';

import 'package:driver/models/auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;  
  DBHelper._createObject();

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {

  //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contact.db';

   //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE auth (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        accessToken TEXT,
        refreshToken TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('auth', orderBy: 'id');
    return mapList;
  }

  Future<int> insert(Auth object) async {
    Database db = await this.database;
    int count = await db.insert('contact', object.toJson());
    return count;
  }

  Future<int> update(Auth object) async {
    Database db = await this.database;
    int count = await db.update('auth', object.toJson(), 
        where: 'id=?',whereArgs: [object.id]);
    return count;
  }
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('contact', 
                                where: 'id=?', 
                                whereArgs: [id]);
    return count;
  }

  Future<List<Auth>> getContactList() async {
    var contactMapList = await select();
    int count = contactMapList.length;
    List<Auth> contactList = List<Auth>();
    for (int i=0; i<count; i++) {
      contactList.add(Auth.fromJson(contactMapList[i]));
    }
    return contactList;
  }
  
}