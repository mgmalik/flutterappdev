import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_lec06_todo_app_drift/models/task.dart';

part 'database_service.g.dart';

@DriftDatabase(tables: [Task])
class DatabaseService extends _$DatabaseService {
  DatabaseService() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // inserting new record
  Future<int> insertTask(TaskCompanion taskObj) {
    return into(task).insert(taskObj);
  }

  // read data from table
  Future<List<TaskData>> getAllTasks() {
    return select(task).get();
  }

  Future<List<TaskData>> getSelectedTasks() {
    return (select(task)..where((t) => t.id.isSmallerOrEqualValue(5))).get();
  }

  Future<List<TaskData>> getCompletedTasks() {
    return (select(task)..where((t) => t.status.isValue(true))).get();
  }

  Future<bool> updateTask(TaskData taskData) {
    return update(task).replace(taskData);
  }

  Future<void> deleteTask(int id) {
    return (delete(task)..where((t) => t.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return driftDatabase(
      name: 'todo_app_db.db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  });
}
