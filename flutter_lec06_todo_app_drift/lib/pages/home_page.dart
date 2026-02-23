import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lec06_todo_app_drift/main.dart';
import 'package:flutter_lec06_todo_app_drift/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: databaseService.getAllTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Click on the + button to add a task...'),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
              child: Text('Click on the + button to add a task...'),
            );
          }
          final tasks = snapshot.data;
          return ListView.builder(
            itemCount: tasks!.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 8.0,
                shadowColor: Colors.blueGrey,
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  title: Text(task.content),
                  subtitle: Checkbox(
                    value: task.status,
                    onChanged: (newValue) {
                      databaseService.updateTask(
                        TaskData(
                          id: task.id,
                          content: task.content,
                          status: newValue!,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      databaseService.deleteTask(task.id);
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
          _showCategoryInputDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showCategoryInputDialog(BuildContext context) async {
    // 1. Create a TextEditingController to manage the input
    final TextEditingController textFieldController = TextEditingController();

    // 2. Use showDialog to display the dialog
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: TextField(
            controller: textFieldController,
            style: TextStyle(color: Colors.indigo, fontSize: 14.0),
            decoration: InputDecoration(
              hintText: 'New Task',
              labelStyle: TextStyle(color: Colors.indigo),
              focusColor: Colors.indigo,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.indigo),
              ),
              labelText: 'Add New Task',
            ),
          ),
          actions: <Widget>[
            // 3. Define the Cancel button
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                // Close the dialog without returning any data
                Navigator.pop(context);
              },
            ),
            // 4. Define the Add button
            TextButton(
              child: Text('ADD'),
              onPressed: () {
                // Close the dialog and return the input text
                databaseService.insertTask(
                  TaskCompanion(
                    content: Value(textFieldController.text),
                    status: Value(false),
                  ),
                );
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
