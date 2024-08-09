import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/remote_service.dart';
import 'package:speedometer_chart/speedometer_chart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});
  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  String name = 'Shankar';
  final List<Map<String, String>> imagePaths = [
    {"path": 'assets/images/angry_icon.png', "mood": "ANGRY"},
    {"path": 'assets/images/sad_icon.png', "mood": "SAD"},
    {"path": 'assets/images/smile_with_pain_icon.png', "mood": "NEUTRAL"},
    {"path": 'assets/images/smile_icon.png', "mood": "HAPPY"},
    {"path": 'assets/images/star.png', "mood": "EXCITED"},
    // Add more image paths and moods as needed
  ];

  late Future<Map<String, dynamic>> _dashboardData;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      _dashboardData = RemoteService()
          .fetchDashboardData(FirebaseAuth.instance.currentUser!.uid);
      setState(() {}); // To refresh the UI after fetching the data
    } catch (e) {
      print('Error refreshing dashboard data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              children: [
                _buildMainContent(), // This method should return your main UI content
                _buildBlurredLoader(), // This method builds the blurred loader
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final double completionPercentage =
                data["overall_completion_percentage"]?.toDouble() ?? 0.0;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: ClipPath(
                          clipper: EllipseClipper(),
                          child: Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(500),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 174, 150, 201),
                                  Color(0xFFFFFFFF),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Good Morning, $name",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/morning_icon.png',
                                  width: 60,
                                  height: 60,
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  'assets/images/notification_icon.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/reminder_icon.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        data["quote"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.deepPurple[300],
                                          fontStyle: FontStyle.italic,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "What's your mood right now?",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    SizedBox(height: 24),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: imagePaths.map((path) {
                                          return InkWell(
                                            onTap: () async {
                                              try {
                                                String selectedMood =
                                                    path["mood"]!;
                                                print(
                                                    '${FirebaseAuth.instance.currentUser!.uid} uid');

                                                // Post the mood
                                                await RemoteService().postMood({
                                                  "user_id": FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid,
                                                  "mood": selectedMood,
                                                });

                                                // Fetch the updated dashboard data
                                                fetchDashboardData();

                                                // Show a toast notification on success
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Mood set to $selectedMood",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              } catch (error) {
                                                // Handle any errors by showing a toast notification
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Failed to set mood. Please try again.",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                                print('Error: $error');
                                              }
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.deepPurple
                                                    .withOpacity(0.1),
                                              ),
                                              child: Image.asset(
                                                path["path"]!,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Tasks',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                value:
                                                    completionPercentage / 100,
                                                strokeWidth: 100,
                                                backgroundColor: Colors.white,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color.fromARGB(
                                                      255, 158, 124, 191),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '${completionPercentage.toStringAsFixed(0)}%',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Goals',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        GoalsCard(
                                          completedGoals:
                                              data["completed_goals_count"],
                                          inProgressGoals:
                                              data["total_in_progress_goals"],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 200,
                                  child: SpeedometerChart(
                                    dimension: 200,
                                    minValue: 0,
                                    maxValue: 100,
                                    value: data["mood_score"],
                                    minLabel: 'Low',
                                    maxLabel: 'High',
                                    currentLabel: 'Mood',
                                    currentValue: data["mood_score"],
                                    currentValueLabel: 'Mood Score',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'Summary of Tasks and Goals:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Your main content goes here
          // Ensure to return your complete main UI content
        ],
      ),
    );
  }

  Widget _buildBlurredLoader() {
    return Center(
      child: Container(
        color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.white.withOpacity(0.8), // Blurred background
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class GoalsCard extends StatelessWidget {
  final int completedGoals;
  final int inProgressGoals;

  const GoalsCard({
    super.key,
    required this.completedGoals,
    required this.inProgressGoals,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Completed Goals: $completedGoals',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'In-Progress Goals: $inProgressGoals',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
