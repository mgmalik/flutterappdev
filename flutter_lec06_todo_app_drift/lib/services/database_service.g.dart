// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// ignore_for_file: type=lint
class $TaskTable extends Task with TableInfo<$TaskTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 250),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<bool> status = GeneratedColumn<bool>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("status" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, content, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $TaskTable createAlias(String alias) {
    return $TaskTable(attachedDatabase, alias);
  }
}

class TaskData extends DataClass implements Insertable<TaskData> {
  final int id;
  final String content;
  final bool status;
  const TaskData({
    required this.id,
    required this.content,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['status'] = Variable<bool>(status);
    return map;
  }

  TaskCompanion toCompanion(bool nullToAbsent) {
    return TaskCompanion(
      id: Value(id),
      content: Value(content),
      status: Value(status),
    );
  }

  factory TaskData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      status: serializer.fromJson<bool>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'status': serializer.toJson<bool>(status),
    };
  }

  TaskData copyWith({int? id, String? content, bool? status}) => TaskData(
    id: id ?? this.id,
    content: content ?? this.content,
    status: status ?? this.status,
  );
  TaskData copyWithCompanion(TaskCompanion data) {
    return TaskData(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.content == this.content &&
          other.status == this.status);
}

class TaskCompanion extends UpdateCompanion<TaskData> {
  final Value<int> id;
  final Value<String> content;
  final Value<bool> status;
  const TaskCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.status = const Value.absent(),
  });
  TaskCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required bool status,
  }) : content = Value(content),
       status = Value(status);
  static Insertable<TaskData> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<bool>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (status != null) 'status': status,
    });
  }

  TaskCompanion copyWith({
    Value<int>? id,
    Value<String>? content,
    Value<bool>? status,
  }) {
    return TaskCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (status.present) {
      map['status'] = Variable<bool>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseService extends GeneratedDatabase {
  _$DatabaseService(QueryExecutor e) : super(e);
  $DatabaseServiceManager get managers => $DatabaseServiceManager(this);
  late final $TaskTable task = $TaskTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [task];
}

typedef $$TaskTableCreateCompanionBuilder =
    TaskCompanion Function({
      Value<int> id,
      required String content,
      required bool status,
    });
typedef $$TaskTableUpdateCompanionBuilder =
    TaskCompanion Function({
      Value<int> id,
      Value<String> content,
      Value<bool> status,
    });

class $$TaskTableFilterComposer
    extends Composer<_$DatabaseService, $TaskTable> {
  $$TaskTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaskTableOrderingComposer
    extends Composer<_$DatabaseService, $TaskTable> {
  $$TaskTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaskTableAnnotationComposer
    extends Composer<_$DatabaseService, $TaskTable> {
  $$TaskTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<bool> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$TaskTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $TaskTable,
          TaskData,
          $$TaskTableFilterComposer,
          $$TaskTableOrderingComposer,
          $$TaskTableAnnotationComposer,
          $$TaskTableCreateCompanionBuilder,
          $$TaskTableUpdateCompanionBuilder,
          (TaskData, BaseReferences<_$DatabaseService, $TaskTable, TaskData>),
          TaskData,
          PrefetchHooks Function()
        > {
  $$TaskTableTableManager(_$DatabaseService db, $TaskTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<bool> status = const Value.absent(),
              }) => TaskCompanion(id: id, content: content, status: status),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String content,
                required bool status,
              }) => TaskCompanion.insert(
                id: id,
                content: content,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaskTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $TaskTable,
      TaskData,
      $$TaskTableFilterComposer,
      $$TaskTableOrderingComposer,
      $$TaskTableAnnotationComposer,
      $$TaskTableCreateCompanionBuilder,
      $$TaskTableUpdateCompanionBuilder,
      (TaskData, BaseReferences<_$DatabaseService, $TaskTable, TaskData>),
      TaskData,
      PrefetchHooks Function()
    >;

class $DatabaseServiceManager {
  final _$DatabaseService _db;
  $DatabaseServiceManager(this._db);
  $$TaskTableTableManager get task => $$TaskTableTableManager(_db, _db.task);
}
