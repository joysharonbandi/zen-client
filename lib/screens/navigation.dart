import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/goals_list.dart';
import 'package:flutter_application_1/screens/mood.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

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
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                selected = index;
              });
            },
            children: const [
              Center(child: Text('Home')),
              GoalsPage(),
              MoodPage(),
              Center(child: Text('Profile')),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
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
              Icons.mood_bad_outlined,
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
