import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard.dart';
import 'package:flutter_application_1/screens/goals_list.dart';
import 'package:flutter_application_1/screens/mood.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int selected = 0;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBody: true,
      body: Container(
        padding: EdgeInsets.only(bottom: 60.0), // Adjust this value as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          child: SafeArea(
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  selected = index;
                });
              },
              children: const [
                MyDashboard(),
                GoalsPage(),
                MoodPage(),
                Center(child: Text('Profile')),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colorScheme.primary,
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 158, 124, 191),
            border: Border.all(
              color: Color.fromARGB(255, 174, 150, 201), // Border color
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(100)), // Optional: rounded corners
          ),
          child: GestureDetector(
            onTap: () {
              context.push('/navigation/chat');
              // Add your onTap logic here
            },
            child: Lottie.asset(
              'assets/images/chat_bot_anim.json',
              width: 100,
              height: 100,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: StylishBottomBar(
        option: DotBarOptions(),
        backgroundColor: colorScheme.primary,
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.house_outlined,
              size: 30,
            ),
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(
              Icons.explore_outlined,
              size: 30,
            ),
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
            title: const Text('Explore'),
          ),
          BottomBarItem(
            icon: const Icon(
              Icons.mood_outlined,
              size: 30,
            ),
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
            title: const Text('Mood'),
          ),
          BottomBarItem(
            icon: const Icon(
              Icons.person_outline,
              size: 30,
            ),
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
            title: const Text('Profile'),
          ),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected,
        notchStyle: NotchStyle.circle,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}
