import 'dart:async';
import 'package:flutter_application_1/database/flight.dart';
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
        'Create Table todo (id Integer Primary Key Not null, flightNumber String, airlineCode String, departureCode String, arrivalCode String, departureTime String, arrivalTime String)');
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    List<Map<String, dynamic>> res = await _db!.query(table);

    res.forEach((element) {
      element.values.forEach((value) {
        print(value.runtimeType);
      });
    });
    return res;
  }

  static Future<int> insert(String table, Flight todo) async =>
      await _db!.insert(
        table,
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
  static Future<int> delete(String table, Flight todo) async =>
      await _db!.delete(table, where: 'id = ?', whereArgs: [todo.id]);
}
