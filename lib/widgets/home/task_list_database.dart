import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // allows mobile and non-mobile platforms (but not web)
import 'dart:io'; // For checking non-mobile platforms

class DbTask {
  final String tab;
  final String section;
  final String title;
  final String description;

  DbTask ({
    required this.tab,
    required this.section,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'tab' : tab, 
      'section' : section,
      'title' : title,
      'description' : description,
    };
  }
  
  factory DbTask.fromMap(Map<String, dynamic> map) {
    return DbTask(
      tab: map['tab'],
      section: map['section'],
      title: map['title'],
      description: map['description'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    if(Platform.isWindows || Platform.isLinux || Platform.isMacOS) { // For non-mobile platforms
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'task_manager.db'); 
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // key is a combination of tab, section, title; used in deleteTask()
    await db.execute('''
      CREATE TABLE task_list (
        tab TEXT,
        section TEXT,
        title TEXT,
        description TEXT,
        PRIMARY KEY (tab, section, title) 
      )
    ''');
  }  

  Future<void> close() async {
    final db = await instance.db;
    await db.close();
  }

  Future<void> insertTask(DbTask task) async { 
    Database db = await instance.db;
    await db.insert(
      'task_list', 
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    Database db = await instance.db;
    return await db.query('task_list');
  }

  Future<void> updateTask(DbTask task) async {
    Database db = await instance.db;
    await db.update(
      'task_list', 
      task.toMap(), 
      where: 'tab = ? AND section = ? AND title = ?', 
      whereArgs: [task.tab, task.section, task.title]);
  }

  void deleteTaskDatabase() async { // delete this function when database is finalized.
    // resets database on each run, remove when database is finalized
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'task_manager.db');
    await deleteDatabase(path);  
  }

  Future<void> deleteTask(String tab, String section, String title) async {
    Database db = await instance.db;
    await db.delete(
      'task_list', 
      where: 'tab = ? AND section = ? AND title = ?',
      whereArgs: [tab, section, title],
    );
  }
}