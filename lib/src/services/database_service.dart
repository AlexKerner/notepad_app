import 'dart:io';
import 'package:notepad_app/src/models/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService instance = DatabaseService._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notepad_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         title TEXT,
         content TEXT,
         isFavorite INTEGER
      )
    ''');
  }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await database;
    var result = await db.query('notes', orderBy: 'id');
    return result.isNotEmpty
        ? result.map((e) => NoteModel.fromMap(e)).toList()
        : [];
  }

  Future<int> addNote(NoteModel note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<int> editNote(NoteModel note) async {
    final db = await database;
    final result = await db
        .update('notes', note.toMap(), where: 'id = ${note.id}', whereArgs: []);
    getAllNotes();
    return result;
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = $id', whereArgs: []);
  }
}
