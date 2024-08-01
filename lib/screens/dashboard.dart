import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});
  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  String name = 'Shankar';
  final List<String> imagePaths = [
    'assets/images/angry_icon.png',
    'assets/images/cry_icon.png',
    'assets/images/shy_icon.png',
    'assets/images/sad_icon.png',
    'assets/images/smile_icon.png',
    'assets/images/smile_with_pain_icon.png',
    'assets/images/thinking_icon.png'
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: ClipPath(
                    clipper: EllipseClipper(),
                    child: Container(
                      width: 300,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(500)),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 174, 150, 201),
                            Color(0xFFFFFFFF)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Good Morning $name",
                              style: TextStyle(fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Image.asset(
                            'assets/images/morning_icon.png',
                            width: 80,
                            height: 80,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 30),
                              Image.asset(
                                'assets/images/notification_icon.png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/reminder_icon.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 18),
                              Expanded(
                                child: Text(
                                  "Even if we don't have the power to choose where we come from, we can still choose where we go from there.",
                                  style: TextStyle(fontSize: 12),
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
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "What's your mood like right now?",
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(height: 24),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: imagePaths.map((path) {
                                    return Image.asset(
                                      path,
                                      width: 30,
                                      height: 30,
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 35,
                                child: TextField(
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(fontSize: 12),
                                    labelText: 'How do you feel?',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(
                                  value: 0.5,
                                  strokeWidth: 10,
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 158, 124, 191)),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  value: 0.5,
                                  strokeWidth: 10,
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 158, 134, 182)),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Goals',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 200, // Set your desired height here
                        child: SpeedometerChart(
                          dimension: 200,
                          minValue: 0,
                          maxValue: 100,
                          value: 30,
                          graphColor: [
                            Color.fromARGB(255, 167, 153, 181),
                            Color.fromARGB(255, 177, 152, 206),
                            Color.fromARGB(255, 114, 68, 160)
                          ],
                          pointerColor: Colors.black,
                          // title: Text('Happiness Meter'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 158, 124, 191),
          border: Border.all(
            color: Color.fromARGB(255, 174, 150, 201), // Border color
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(100)), // Optional: rounded corners
        ),
        child: Lottie.asset(
          'assets/images/chat_bot_anim.json',
          width: 65,
          height: 65,
        ),
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
