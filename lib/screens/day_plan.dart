import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SevenDayPlanStaticScreen extends StatelessWidget {
  final Map<String, dynamic> planData;
  // final String goalId;

  SevenDayPlanStaticScreen({required this.planData});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color.fromARGB(255, 190, 151, 229);
    final Color secondaryColor = Color.fromARGB(255, 201, 184, 219);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '7-Day Plan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: primaryColor,
      ),
      body: planData.isNotEmpty
          ? ListView.builder(
              itemCount: planData.length,
              itemBuilder: (context, index) {
                final key = planData.keys.elementAt(index);
                final value = planData[key];
                print('value: $value');
                if (value is Map<String, dynamic>) {
                  final objective = value['objective'] ?? 'No Objective';
                  final description = value['description'] ?? 'No Description';
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: secondaryColor,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        'Day ${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(objective),
                      trailing: Icon(
                        Icons.check_circle_outline,
                        color: primaryColor,
                      ),
                      onTap: () {
                        context.push('/navigation/day_list/task_list',
                            extra: value);
                        // Add navigation logic here
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            )
          : Center(child: Text('No data available')),
    );
  }
}
