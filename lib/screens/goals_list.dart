import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/goals.dart';
import 'package:flutter_application_1/service/remote_service.dart';
import 'package:go_router/go_router.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPage();
}

class _GoalsPage extends State<GoalsPage> {
  List<Goal>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getState();
  }

  getState() async {
    posts = await RemoteService().getGoals();
    if (posts != null) {
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color seedColor = Color.fromARGB(255, 190, 151, 229); // seedColor
    final Color primaryColor = seedColor; // primary
    final Color secondaryColor =
        Color.fromARGB(255, 201, 184, 219); // secondary

    return Scaffold(
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.push('/navigation/goal_details');
                print('Card tapped: ${posts![index].title}');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                margin: EdgeInsets.only(bottom: 16),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(0.8),
                        secondaryColor.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          posts![index].title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Brief description here.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: Colors.white70, size: 16),
                            SizedBox(width: 4),
                            Text(
                              "Deadline: 31st Dec 2024",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        replacement: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
