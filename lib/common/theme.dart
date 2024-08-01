// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorSchemeSeed: Color.fromARGB(255, 162, 154, 170),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 48,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      fontSize: 13,
      color: Colors.black,
    ),
  ),
);
