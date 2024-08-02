import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  // final int day;

  TaskListScreen();

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List to keep track of the checkbox states
  List<bool> _isChecked = List<bool>.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks for Day 1'),
      ),
      body: ListView.builder(
        itemCount: 5, // Assume each day has 5 tasks
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Checkbox(
                value: _isChecked[index],
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked[index] = value ?? false;
                  });
                },
              ),
              title: Text('Task ${index + 1}'),
              subtitle: Text('Description for task ${index + 1}'),
            ),
          );
        },
      ),
    );
  }
}
