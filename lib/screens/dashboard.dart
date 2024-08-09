// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/service/remote_service.dart';
// import 'package:speedometer_chart/speedometer_chart.dart';

// class MyDashboard extends StatefulWidget {
//   const MyDashboard({super.key});
//   @override
//   State<MyDashboard> createState() => _MyDashboardState();
// }

// class _MyDashboardState extends State<MyDashboard> {
//   String name = 'Shankar';
//   final List<String> imagePaths = [
//     'assets/images/angry_icon.png',
//     'assets/images/cry_icon.png',
//     'assets/images/shy_icon.png',
//     'assets/images/sad_icon.png',
//     'assets/images/smile_icon.png',
//     'assets/images/smile_with_pain_icon.png',
//     'assets/images/thinking_icon.png',
//     // Add more image paths as needed
//   ];

//   late Future<Map<String, dynamic>> _dashboardData;

//   @override
//   void initState() {
//     super.initState();
//     _dashboardData =
//         RemoteService().fetchDashboardData('XZUGbVJiMQOM6IW6KCebjCHKLBA2');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _dashboardData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final data = snapshot.data!;
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Positioned(
//                         child: ClipPath(
//                           clipper: EllipseClipper(),
//                           child: Container(
//                             width: 300,
//                             height: 250,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   bottomRight: Radius.circular(500)),
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 174, 150, 201),
//                                   Color(0xFFFFFFFF)
//                                 ],
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 60, horizontal: 20),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     "Good Morning $name",
//                                     style: TextStyle(fontSize: 16),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Image.asset(
//                                   'assets/images/morning_icon.png',
//                                   width: 80,
//                                   height: 80,
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: 30),
//                                     Image.asset(
//                                       'assets/images/notification_icon.png',
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 20),
//                             Card(
//                               color: Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/reminder_icon.png',
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                     SizedBox(width: 18),
//                                     Expanded(
//                                       child: Text(
//                                         data["quote"],
//                                         style: TextStyle(fontSize: 12),
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Card(
//                               color: Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "What's your mood like right now?",
//                                       style: TextStyle(fontSize: 13),
//                                     ),
//                                     SizedBox(height: 24),
//                                     Container(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: imagePaths.map((path) {
//                                           return Image.asset(
//                                             path,
//                                             width: 30,
//                                             height: 30,
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                     SizedBox(height: 15),
//                                     Container(
//                                       height: 35,
//                                       child: TextField(
//                                         style: TextStyle(fontSize: 12),
//                                         decoration: InputDecoration(
//                                           labelStyle: TextStyle(fontSize: 12),
//                                           labelText: 'How do you feel?',
//                                           border: OutlineInputBorder(),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 30),
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         SizedBox(
//                                           width: 70,
//                                           height: 70,
//                                           child: CircularProgressIndicator(
//                                             value: data[
//                                                     "overall_completion_percentage"] /
//                                                 100,
//                                             strokeWidth: 10,
//                                             backgroundColor: Colors.white,
//                                             valueColor:
//                                                 AlwaysStoppedAnimation<Color>(
//                                                     Color.fromARGB(
//                                                         255, 158, 124, 191)),
//                                           ),
//                                         ),
//                                         SizedBox(height: 20),
//                                         Text(
//                                           'Tasks',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       children: [
//                                         GoalsCard(
//                                           completedGoals: 5,
//                                           inProgressGoals: 3,
//                                         ),
//                                         Text(
//                                           'Goals',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 30),
//                                 Container(
//                                   height: 200, // Set your desired height here
//                                   child: SpeedometerChart(
//                                     dimension: 200,
//                                     minValue: 0,
//                                     maxValue: 100,
//                                     value: 20,
//                                     graphColor: [
//                                       Color.fromARGB(255, 167, 153, 181),
//                                       Color.fromARGB(255, 177, 152, 206),
//                                       Color.fromARGB(255, 114, 68, 160)
//                                     ],
//                                     pointerColor: Colors.black,
//                                     // title: Text('Happiness Meter'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Center(child: Text('No data available'));
//           }
//         },
//       ),
//     );
//   }
// }

// class EllipseClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, 0);
//     path.quadraticBezierTo(size.width * 5, 0, 20, size.height);
//     path.quadraticBezierTo(size.width, size.height, 0, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class GoalsCard extends StatelessWidget {
//   final int completedGoals;
//   final int inProgressGoals;

//   GoalsCard({required this.completedGoals, required this.inProgressGoals});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Completed Goals: $completedGoals',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: Colors.green,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           'In Progress Goals: $inProgressGoals',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: Colors.orange,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/remote_service.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});
  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

// moods = {"ANGRY": 0, "SAD": 25, "NEUTRAL": 50, "HAPPY": 75, "EXCITED": 100}
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
    _dashboardData =
        RemoteService().fetchDashboardData('XZUGbVJiMQOM6IW6KCebjCHKLBA2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                                            onTap: () {
                                              print('Image tapped $path');
                                              // Add your onTap logic here
                                            },
                                            child: Image.asset(
                                              path["path"]!,
                                              width: 40,
                                              height: 40,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    // Container(
                                    //   height: 40,
                                    //   child: TextField(
                                    //     style: TextStyle(fontSize: 14),
                                    //     decoration: InputDecoration(
                                    //       labelStyle: TextStyle(fontSize: 14),
                                    //       labelText: 'How do you feel?',
                                    //       border: OutlineInputBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(12),
                                    //       ),
                                    //       filled: true,
                                    //       fillColor:
                                    //           Colors.grey.withOpacity(0.1),
                                    //     ),
                                    //   ),
                                    // ),
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
                                SizedBox(height: 30),
                                Container(
                                  height: 200,
                                  child: SpeedometerChart(
                                    dimension: 200,
                                    minValue: 0,
                                    maxValue: 100,
                                    value: 20,
                                    graphColor: [
                                      Color.fromARGB(255, 167, 153, 181),
                                      Color.fromARGB(255, 177, 152, 206),
                                      Color.fromARGB(255, 114, 68, 160)
                                    ],
                                    pointerColor: Colors.black,
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
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class EllipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 5, 0, 20, size.height);
    path.quadraticBezierTo(size.width, size.height, 0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class GoalsCard extends StatelessWidget {
  final int completedGoals;
  final int inProgressGoals;

  GoalsCard({required this.completedGoals, required this.inProgressGoals});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '$completedGoals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Text(
              'Completed ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple[300],
              ),
            ),
            SizedBox(height: 12),
            Text(
              '$inProgressGoals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Text(
              'In Progress ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
