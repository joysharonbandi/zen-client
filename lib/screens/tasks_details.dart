import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SevenDayPlanScreen extends StatelessWidget {
  SevenDayPlanScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7-Day Plan'),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text('Day ${index + 1}'),
              subtitle: Text('Description for day ${index + 1}'),
              trailing: Icon(Icons.check_circle_outline),
              onTap: () {
                context.push('/navigation/day_list/task_list');
              },
            ),
          );
        },
      ),
    );
  }
}
