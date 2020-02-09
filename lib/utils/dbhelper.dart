import 'dart:io';

import 'package:driver/models/auth.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;  
  static String _tableName = 'auth';

  final String databaseName = 'main.db';
  static List initScript = [];
  static List migrationScripts = [];
  final logs = List<Object>();
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
    String path = directory.path + databaseName;

    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb,);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE auth (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
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
    var mapList = await db.query(_tableName, orderBy: 'id');
    return mapList;
  }

  Future<int> insert(Auth object) async {
    Database db = await this.database;
    int count = await db.insert(_tableName, object.toJson());
    return count;
  }

  Future<int> update(Auth object) async {
    Database db = await this.database;
    int count = await db.update(_tableName, object.toJson(), 
        where: 'id=?',whereArgs: [object.id]);
    return count;
  }
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete(_tableName, 
                                where: 'id=?', 
                                whereArgs: [id]);
    return count;
  }

  Future<List<Auth>> getAuthList() async {
    var contactMapList = await select();
    int count = contactMapList.length;
    List<Auth> contactList = List<Auth>();
    for (int i=0; i<count; i++) {
      print(contactMapList[i]);
      contactList.add(Auth.fromJson(contactMapList[i]));
    }
    return contactList;
  }

  Future<int> truncate(String tableName) async {
    try {
      Database db = await this.database;
      await db.transaction((txn) async {
        return await txn.delete(tableName);
      });
    } catch (e) {
      print(e);
      logs.add(e);
    }
    return -1;
  }

  Future<bool> checkDatabaseExists() async {
    final databasesPath = await getDatabasesPath();
    final String _path = join(databasesPath, databaseName);

    try {
      return await databaseExists(_path);
    } catch (e) {
      print(e);
      logs.add(e);
      return false;
    }
  }

  // Future<void> deleteDatabase() async {
  //   if (await checkDatabaseExists()) {
  //     final databasesPath = await getDatabasesPath();
  //     final String _path = join(databasesPath, databaseName);

  //     try {
  //       await deleteDatabase(_path);
  //     } catch (e) {
  //       print(e);
  //       logs.add(e);
  //     }
  //   }
  // } 

  Future<bool> checkTableExists(String tableName) async {
    try {
      List result;
      Database db = await this.database;
      result = await db.rawQuery(
          'SELECT * FROM sqlite_master WHERE name =\'$tableName\' and type=\'table\'');

      assert(result != null);

      if (result.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      logs.add(e);
      return false;
    }
  }
  
}