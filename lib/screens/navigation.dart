// import 'package:flutter/material.dart';

// /// Flutter code sample for [NavigationBar].

// // void main() => runApp(const NavigationBarApp());

// class NavigationBarApp extends StatelessWidget {
//   const NavigationBarApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // theme: ThemeData(useMaterial3: true),
//       home: const NavigationExample(),
//     );
//   }
// }

// class NavigationExample extends StatefulWidget {
//   const NavigationExample({super.key});

//   @override
//   State<NavigationExample> createState() => _NavigationExampleState();
// }

// class _NavigationExampleState extends State<NavigationExample> {
//   int currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         // indicatorColor: Color.fromARGB(255, 7, 255, 110),
//         backgroundColor: Colors.black,
//         selectedIndex: currentPageIndex,
//         destinations: const <Widget>[
//           NavigationDestination(
//             selectedIcon: Icon(Icons.home),
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           NavigationDestination(
//             icon: Badge(child: Icon(Icons.notifications_sharp)),
//             label: 'Notifications',
//           ),
//           NavigationDestination(
//             icon: Badge(
//               label: Text('2'),
//               child: Icon(Icons.messenger_sharp),
//             ),
//             label: 'Messages',
//           ),
//         ],
//       ),
//       body: <Widget>[
//         /// Home page
//         Card(
//           shadowColor: Colors.transparent,
//           margin: const EdgeInsets.all(8.0),
//           child: SizedBox.expand(
//             child: Center(
//               child: Text(
//                 'Home page',
//                 style: theme.textTheme.titleLarge,
//               ),
//             ),
//           ),
//         ),

//         /// Notifications page
//         const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: <Widget>[
//               Card(
//                 child: ListTile(
//                   leading: Icon(Icons.notifications_sharp),
//                   title: Text('Notification 1'),
//                   subtitle: Text('This is a notification'),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   leading: Icon(Icons.notifications_sharp),
//                   title: Text('Notification 2'),
//                   subtitle: Text('This is a notification'),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         /// Messages page
//         ListView.builder(
//           reverse: true,
//           itemCount: 2,
//           itemBuilder: (BuildContext context, int index) {
//             if (index == 0) {
//               return Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   margin: const EdgeInsets.all(8.0),
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.primary,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     'Hello',
//                     style: theme.textTheme.bodyLarge!
//                         .copyWith(color: theme.colorScheme.onPrimary),
//                   ),
//                 ),
//               );
//             }
//             return Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 margin: const EdgeInsets.all(8.0),
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Text(
//                   'Hi!',
//                   style: theme.textTheme.bodyLarge!
//                       .copyWith(color: theme.colorScheme.onPrimary),
//                 ),
//               ),
//             );
//           },
//         ),
//       ][1],
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/goals_list.dart';
import 'package:flutter_application_1/screens/posts.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(useMaterial3: true),
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
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors
            .black, // Match the bottomNavigationBar's background color or adjust as needed
        title: Text('Your App Title'), // Optional: Adjust the title as needed
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              context.pushReplacement('/login');
              // Optionally navigate the user to the login screen after logging out
              // Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  if (currentPageIndex == 0)
                    Positioned(
                      top: -20,
                      right: 0,
                      child: Icon(Icons.arrow_drop_up, color: Colors.red),
                    ),
                ],
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Icon(Icons.explore),
                  if (currentPageIndex == 1)
                    Positioned(
                      top: -10,
                      right: 0,
                      child: Icon(Icons.arrow_drop_up, color: Colors.red),
                    ),
                ],
              ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Icon(Icons.messenger_sharp),
                  if (currentPageIndex == 2)
                    Positioned(
                      top: -15,
                      right: 0,
                      child: Icon(Icons.arrow_drop_up, color: Colors.red),
                    ),
                ],
              ),
            ),
            label: 'Messages',
          ),
        ],

        // unselectedItemColor: Colors.white, // Set unselected items to white
        // selectedItemColor: Colors.white, // Set selected item to white
        selectedLabelStyle: TextStyle(
            color: Colors
                .white), // Optional: Ensure label text is white when selected
        unselectedLabelStyle: TextStyle(color: Colors.white),
      ),
      body: <Widget>[
        HomePage(),
        // Card(
        //   shadowColor: Colors.transparent,
        //   margin: const EdgeInsets.all(8.0),
        //   child: SizedBox.expand(
        //     child: Center(
        //       child: Text(
        //         'Home page',
        //         style: theme.textTheme.titleLarge,
        //       ),
        //     ),
        //   ),
        // ),

        GoalsPage(),

        /// Notifications page
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Column(
        //     children: <Widget>[
        //       // HomePage(),
        //       Card(
        //         child: ListTile(
        //           leading: Icon(Icons.notifications_sharp),
        //           title: Text('Notification 1'),
        //           subtitle: Text('This is a notification'),
        //         ),
        //       ),
        //       Card(
        //         child: ListTile(
        //           leading: Icon(Icons.notifications_sharp),
        //           title: Text('Notification 2'),
        //           subtitle: Text('This is a notification'),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
