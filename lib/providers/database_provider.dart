import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:xpert_iptv/models/user_info.dart';

class DatabaseProvider {
  DatabaseProvider._init();
  static final DatabaseProvider instance = DatabaseProvider._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB('iptv.db');
    return _database!;
  }

  initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS user_info(username TEXT PRIMARY KEY, name TEXT, password TEXT, message TEXT, auth INTEGER, status TEXT, exp_date TEXT, is_trial TEXT, active_cons TEXT, created_at TEXT, max_connections TEXT, url TEXT)',
      );
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> saveUserInfo(UserInfo ui) async {
    int id = 0;
    try {
      final db = await instance.database;
      bool userExist = await userInfoExists(db, ui.username);
      if (userExist) {
        id = await updateUserInfo(db, ui);
      } else {
        id = await db.insert('user_info', ui.toJson());
      }
    } catch (e) {
      Logger().e(e);
    }
    return id;
  }

  Future<List<UserInfo>> getUsersInfo() async {
    late List<UserInfo> infos;
    try {
      final db = await instance.database;
      List<Map<String, dynamic>> records = await db.query('user_info');
      infos = records.map((r) => UserInfo.fromJson(r)).toList();
    } catch (e) {
      Logger().e(e);
    }
    return infos;
  }

  Future<bool> userInfoExists(final db, String username) async {
    List<Map> list = await db
        .rawQuery("SELECT * FROM user_info WHERE username = ?", [username]);
    return list.isNotEmpty;
  }

  Future<int> updateUserInfo(final db, UserInfo ui) async {
    return db.update('user_info', ui.toJson(),
        where: 'username = ?', whereArgs: [ui.username]);
  }

  Future<int> deleteUserInfo(UserInfo ui) async {
    final db = await instance.database;
    return await db
        .delete('user_info', where: 'username = ?', whereArgs: [ui.username]);
  }
}
