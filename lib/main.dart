import 'package:app_agri_booking/pages/HomeUserAll.dart';
import 'package:app_agri_booking/pages/login.dart';
import 'package:app_agri_booking/pages/register.dart';
import 'package:app_agri_booking/pages/Client/InsertFarm.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //theme: ThemeData(useMaterial3: false),
      title: 'Flutter Demo',
      //home: Register(),
<<<<<<< HEAD
      home: LoginPage(),
=======
      //home: LoginPage(),
      home: HomeUserAllPage(),
>>>>>>> main
      //home: LoginPage(),
    );
  }
}
