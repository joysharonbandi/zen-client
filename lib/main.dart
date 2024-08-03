import 'package:firebase_auth/firebase_auth.dart';
// // Copyright 2019 The Flutter team. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/theme.dart';
import 'package:flutter_application_1/screens/chat.dart';
import 'package:flutter_application_1/screens/dashboard.dart';
import 'package:flutter_application_1/screens/goal_desc.dart';
import 'package:flutter_application_1/screens/navigation.dart';
import 'package:flutter_application_1/screens/task_list.dart';
import 'package:flutter_application_1/screens/tasks_details.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

GoRouter router(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;
  return GoRouter(
    initialLocation: "/navigation",
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/navigation',
        builder: (context, state) => const NavigationExample(),
        routes: [
          GoRoute(
            path: 'goal_details',
            builder: (context, state) => GoalDetailScreen(),
          ),
          GoRoute(
            path: 'chat',
            builder: (context, state) => ChatScreen(),
          ),
          GoRoute(
              path: 'day_list',
              builder: (context, state) => SevenDayPlanScreen(),
              routes: [
                GoRoute(
                  path: 'task_list',
                  builder: (context, state) => TaskListScreen(),
                ),
              ]),
        ],
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const MyDashboard(),
      ),

      // GoRoute(
      //   path: '/catalog',
      //   builder: (context, state) => const MyCatalog(),
      //   routes: [
      //     GoRoute(
      //       path: 'cart',
      //       builder: (context, state) => const MyCart(),
      //     ),
      //   ],
      // ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return MultiProvider(
          providers: [
            Provider(create: (context) => Object()),
          ],
          child: MaterialApp.router(
            title: 'Provider Demo',
            theme: appTheme,
            routerConfig: router(context),
          ),
        );
      },
    );
  }
}
