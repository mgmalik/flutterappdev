import 'package:flutter/material.dart';
import 'package:flutter_lec06_todo_app_sqflite/models/task.dart';
import 'package:flutter_lec06_todo_app_sqflite/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _databaseService.getTasks(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Task task = snapshot.data![index];
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 5.0,
                shadowColor: Colors.blueGrey,
                child: ListTile(
                  title: Text(task.content),
                  leading: Checkbox(
                    value: task.status == 1,
                    onChanged: (newValue) {
                      _databaseService.updateTaskStatus(
                        task.id,
                        newValue == true ? 1 : 0,
                      );
                      setState(() {});
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _databaseService.deleteTask(task.id);
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _task = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'new task',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_task == null || _task!.isEmpty) return;
                        _databaseService.addTask(_task!);
                        setState(() {
                          _task = null;
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Add Task'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        tooltip: 'Add a Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
