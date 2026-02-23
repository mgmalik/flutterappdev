import 'package:flutter_lec06_todo_app_sqflite/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _database;
  DatabaseService._constructor();

  final String _tasksTableName = 'tasks';
  final String _tasksIdColumnName = 'id';
  final String _tasksContentColumnName = 'content';
  final String _tasksStatusColumnName = 'status';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getDatabase();
    return _database!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'todo_app.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) => {
        db.execute('''
            CREATE TABLE $_tasksTableName (
              $_tasksIdColumnName INTEGER PRIMARY KEY,
              $_tasksContentColumnName TEXT NOT NULL,
              $_tasksStatusColumnName INTEGER NOT NULL
            )
            '''),
      },
    );
    return database;
  }

  void addTask(String content) async {
    final db = await database;
    await db.insert(_tasksTableName, {
      _tasksContentColumnName: content,
      _tasksStatusColumnName: 0,
    });
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final data = await db.query(_tasksTableName);
    List<Task> tasks = data
        .map(
          (t) => Task(
            id: t[_tasksIdColumnName] as int,
            content: t[_tasksContentColumnName] as String,
            status: t[_tasksStatusColumnName] as int,
          ),
        )
        .toList();
    return tasks;
  }

  void updateTask(int id, String content, int status) async {
    final db = await database;
    await db.update(
      _tasksTableName,
      {_tasksContentColumnName: content, _tasksStatusColumnName: status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void updateTaskStatus(int id, int status) async {
    final db = await database;
    await db.update(
      _tasksTableName,
      {_tasksStatusColumnName: status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void deleteTask(int id) async {
    final db = await database;
    await db.delete(_tasksTableName, where: 'id = ?', whereArgs: [id]);
  }
}
