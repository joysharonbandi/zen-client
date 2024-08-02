import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/tasks_details.dart';
import 'package:flutter_application_1/widgets/Questionare.dart';
import 'package:go_router/go_router.dart';

class GoalDetailScreen extends StatelessWidget {
  // final String name;
  // final String description;
  // final String benefits;

  GoalDetailScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fefewf"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fewfew",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "fewfew",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Benefits:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Fewfe",
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => SafeArea(
                      child: Container(
                        height: MediaQuery.of(context).size.height - 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: QuestionnaireModal(),
                      ),
                    ),
                  );
                  // context.push("/navigation/day_list");
                  // Handle start goal action
                },
                child: Text('Start Goal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
