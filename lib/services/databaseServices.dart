import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_notes_app/model/notes.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseServices extends ChangeNotifier {
  Stream<List<Notes>> get notesStream {
    return Stream.fromFuture(GetData());
  }

  Future<Database> startDatabase() async {
    var databasepath = await getDatabasesPath();
    String path = '$databasepath/notes.db';

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE NOTES(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,data TEXT)');
      },
    );
    return database;
  }

  Future<void> insertData(Notes notes) async {
    var database = await startDatabase();
    print('hello');
    database.insert(
      'NOTES',
      notes.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    GetData();
  }

  Future<void> DeleteData(int id) async {
    var database = await startDatabase();

    database.delete('NOTES', where: 'id= ?', whereArgs: [id]);
    GetData();
  }

  Future<void> updateData(Notes notes) async {
    var database = await startDatabase();
    await database.update(
      'NOTES',
      notes.toMap(),
      where: 'id= ?',
      whereArgs: [notes.id],
    );
    GetData();
  }

  Future<List<Notes>> GetData() async {
    var database = await startDatabase();
    final List<Map<String, dynamic>> maps = await database.query('NOTES');
    var notes = maps.map((note) => Notes.fromMap(note)).toList();
    notifyListeners();
    return notes;
  }
}
