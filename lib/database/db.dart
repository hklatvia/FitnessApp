import 'dart:async';
import 'package:flutter_application_1/database/todoitem.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

abstract class DB {
  static Database? _db;
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath();
      String _databasepath = p.join(_path, 'todolist.db');
      _db = await openDatabase(_databasepath,
          version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute(
        'Create Table todo (id Integer Primary Key Not null, name String)');
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      await _db!.query(table);

  static Future<int> insert(String table, ToDoItem todo) async =>
      await _db!.insert(table, todo.toMap());
  static Future<int> delete(String table, ToDoItem todo) async =>
      await _db!.delete(table, where: 'id = ?', whereArgs: [todo.id]);
}
