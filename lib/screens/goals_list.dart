import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/goals.dart';
import 'package:flutter_application_1/models/posts.dart';
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
    // TODO: implement initState
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
    return Scaffold(
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Handle the tap event here
                context.push('/navigation/goal_details');
                print('Card tapped: ${posts![index].title}');
              },
              child: Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts![index].title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Itw w vdsvc",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
