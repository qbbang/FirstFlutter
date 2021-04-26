import 'package:flutter/material.dart';

// ThemeData 타입을 값는 상수 appTheme
// final은 const와 달리 런타임 시점에 상수값이 정해진다.
final appTheme = ThemeData(
  primarySwatch: Colors.yellow,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: 'Corben',
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: Colors.black,
    ),
  ),
);
