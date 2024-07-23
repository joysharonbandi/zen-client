// // Copyright 2019 The Flutter team. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// import 'package:provider_shopper/common/theme.dart';
// import 'package:provider_shopper/models/cart.dart';
// import 'package:provider_shopper/models/catalog.dart';
// import 'package:provider_shopper/screens/cart.dart';
// import 'package:provider_shopper/screens/catalog.dart';
import 'screens/login.dart';
// import 'package:window_size/window_size.dart';

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
// void main() {
//   // setupWindow();
//   runApp(const MyApp());
// }

const double windowWidth = 400;
const double windowHeight = 800;

// void setupWindow() {
//   if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
//     WidgetsFlutterBinding.ensureInitialized();
//     setWindowTitle('Provider Demo');
//     setWindowMinSize(const Size(windowWidth, windowHeight));
//     setWindowMaxSize(const Size(windowWidth, windowHeight));
//     getCurrentScreen().then((screen) {
//       setWindowFrame(Rect.fromCenter(
//         center: screen!.frame.center,
//         width: windowWidth,
//         height: windowHeight,
//       ));
//     });
//   }
// }

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
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
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        Provider(create: (context) => Object()),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
