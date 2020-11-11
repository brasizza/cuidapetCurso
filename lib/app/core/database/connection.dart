import 'dart:async';

import 'package:cuidapetcurso/app/core/database/migrations/migrations_v1.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:synchronized/synchronized.dart';

class Connection {
  static const VERSION = 1;
  static const DATABASE_NAME = 'cuidapet_curso_db';
  Database _db;
  final _lock = Lock();

  static Connection _instance;

  Connection._();

  factory Connection() {
    _instance ??= Connection._();
    return _instance;
  }

  Future<Database> get instance async => await _openConnection();

  Future<Database> _openConnection() async {
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          var databasePath = await getDatabasesPath();
          var path = join(databasePath, DATABASE_NAME);
          _db = await openDatabase(
            path,
            version: VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
          );
        }
      });
    }
    return _db;
  }

  FutureOr<void> _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = OK");
  }

  FutureOr<void> _onCreate(Database db, int version) {
    var batch = db.batch();
    createV1(batch);
    batch.commit();
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {}

  void closeConnection() async{
   await  _db?.close();
    _db = null;
  }
}
