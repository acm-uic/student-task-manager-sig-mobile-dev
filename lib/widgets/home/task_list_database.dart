import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Task {
  final String tab;
  final String section;
  final String detail;

  Task ({
    required this.tab,
    required this.section,
    required this.detail,
  });

  Map<String, dynamic> toMap() {
    return {
      'tab': tab, 
      'section': section,
      'detail': detail,
    };
  }
  
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      tab: map['tab'],
      section: map['section'],
      detail: map['detail'],
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
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'task_manager.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    String databasesPath = await getDatabasesPath();

    // resets database on each run, remove when database is finalized
    String path = join(databasesPath, 'task_manager.db');
    await deleteDatabase(path); 
    
    // key is a combination of tab, section, and detail, used in deleteTask()
    await db.execute('''
      CREATE TABLE task_list (
        tab TEXT,
        section TEXT,
        detail TEXT,
        PRIMARY KEY (tab, section, detail) 
      )
    ''');
  }

  Future<void> insertTask(Task task) async { 
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

  Future<void> updateTask(Task task) async {
    Database db = await instance.db;
    await db.update(
      'task_list', 
      task.toMap(), 
     where: 'tab = ? AND section = ? AND where: detail = ?', 
     whereArgs: [task.tab, task.section, task.detail]);
  }

  Future<void> deleteTask(String tab, String section, String detail) async {
    Database db = await instance.db;
    await db.delete(
      'task_list', 
      where: 'tab = ? AND section = ? AND detail = ?',
      whereArgs: [tab, section, detail]
    );
  }
}