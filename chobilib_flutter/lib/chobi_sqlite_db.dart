import 'dart:async';

import 'package:chobilib_flutter/extensions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChobiSQLiteDb {

  static List<String> getCreateTableSqls(String tableName, Map<String, String> columnsMap, {List<String>? additionalCommands}) {
    final res = <String>[];

    final colSb = StringBuffer();
    for (var key in columnsMap.keys) {
      if (colSb.isNotEmpty) {
        colSb.write(', ');
      }
      colSb..write(key)..write(' ')..write(columnsMap[key]);
    }

    res.add(
      'CREATE TABLE IF NOT EXISTS $tableName ($colSb)'
    );

    additionalCommands?.also((t) => res.addAll(t));

    return res;
  }

  static Future<String> getDbFullPath(String dbName) async {
    final dbDirPath = await getDatabasesPath();
    return join(dbDirPath, dbName);
  }

  final String dbFileName;
  final int dbVersion;
  final FutureOr<void> Function(Database db, int version)? onCreate;
  final FutureOr<void> Function(Database db, int oldVer, int newVer)? onUpgrade;

  ChobiSQLiteDb({required this.dbFileName, required this.dbVersion, this.onCreate, this.onUpgrade});

  Database? _db;

  Future<Database> get database async {
    return _db ?? await _open().then((value) => _db = value);
  }

  Future<void> delete() async {
    await close();
    deleteDatabase(await getDbFullPath(dbFileName));
  }

  Future<void> close() async {
    await (await database).close();
    _db = null;
  }


  Future<Database> _open() async {
    final dbFullPath = await getDbFullPath(dbFileName);
    return await openDatabase(
      dbFullPath,
      version: dbVersion,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  Future<T> withDb<T>(Future<T> Function(Database db) f) async {
    return (await database).withDb((db) => f(db));
  }

  Future<T> withTransaction<T>(Future<T> Function(Transaction txn) f) async {
    return (await database).withTransaction((txn) => f(txn));
  }

  Future<void> createTable(String tableName, Map<String, String> columnsMap, {Database? db, List<String>? additionalCommands}) async {
    final sqlArr = getCreateTableSqls(tableName, columnsMap, additionalCommands: additionalCommands);

    final d = db ?? await database;
    await d.withTransaction((txn) async {
      for (var sql in sqlArr) {
        await txn.execute(sql);
      }
    });
  }

}


extension DatabaseExtensions on Database {

  Future<T> withDb<T>(Future<T> Function(Database db) f) async {
    return await f(this);
  }

  Future<T> withTransaction<T>(Future<T> Function(Transaction txn) f) async {
    return await transaction((txn) async {
      return await f(txn);
    });
  }

}
