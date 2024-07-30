import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/theme.dart';
import 'package:flutter_application_1/screens/goal_desc.dart';
import 'package:flutter_application_1/screens/navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

GoRouter router(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;
  return GoRouter(
    initialLocation: user == null ? '/login' : '/navigation',
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
        ],
      ),
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
