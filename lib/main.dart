import 'package:app_agri_booking/pages/login.dart';
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
      home: Login(),
      //555555
    );
  }
}
