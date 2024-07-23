// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),

            Text(
              'ZEN',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 30),
            Text(
              'Welcome to the healthy space',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 30),
            Image.asset(
              'assets/images/brain.png',
              width: 140,
              height: 140,
            ),
            const SizedBox(height: 30),
            Text(
              'Log in',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w500, // Change the font weight here
                  ),
            ),

            // Image(image: image),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 24,
            ),

            Text(
              'OR',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = await signInWithGoogle();
                if (user != null) {
                  print('Sign-In successful: $user');
                  // Navigate to another screen or show a success message
                } else {
                  print('Sign-In failed');
                }
              },
              child: Text('Sign In with Google'),
            )
          ],
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SignInScreen(),
//     );
//   }
// }

Future<User?> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            User? user = await signInWithGoogle();
            if (user != null) {
              print('Sign-In successful: $user');
              // Navigate to another screen or show a success message
            } else {
              print('Sign-In failed');
            }
          },
          child: Text('Sign In with Google'),
        ),
      ),
    );
  }
}
