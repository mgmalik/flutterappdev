import 'package:drift/drift.dart';

class Task extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().withLength(max: 250)();
  BoolColumn get status => boolean()();
}
