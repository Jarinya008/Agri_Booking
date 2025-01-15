import 'package:app_agri_booking/pages/Client/Home.dart';
import 'package:app_agri_booking/pages/HomeUserAll.dart';
import 'package:app_agri_booking/pages/login.dart';
import 'package:app_agri_booking/pages/map.dart';
import 'package:app_agri_booking/pages/register.dart';
import 'package:app_agri_booking/pages/Client/InsertFarm.dart';
import 'package:flutter/material.dart';
import 'package:flogger/flogger.dart';
import 'package:logger/logger.dart';

void main() {
  var logger = Logger();

  // เริ่มใช้งาน log
  logger.d("This is a debug message!");

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
      //home: MapPage(),
      //home: LoginPage(),
      home: HomeClientPage(),
      //home: LoginPage(),
    );
  }
}
