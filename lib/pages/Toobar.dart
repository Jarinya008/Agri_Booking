import 'dart:developer';

import 'package:app_agri_booking/pages/HomeUserAll.dart';
import 'package:app_agri_booking/pages/login.dart';
import 'package:flutter/material.dart';

class Toobar extends StatefulWidget {
  final int value;
  const Toobar({super.key, required this.value});

  @override
  State<Toobar> createState() => _ToobarState();
}

class _ToobarState extends State<Toobar> {
  late int value;
  late Widget curretnPage = HomeUserAllPage();

  @override
  void initState() {
    super.initState();
    value = widget.value;
    switchPage(value);
  }

  void switchPage(int index) {
    log('Switching to index: $index');
    setState(() {
      value = index;
      if (index == 0) {
        curretnPage = const HomeUserAllPage();
      } else if (index == 1) {
        curretnPage = const LoginPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: curretnPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ฉัน',
          ),
        ],
        onTap: switchPage,
        selectedItemColor: const Color(0xFFEF6C00),
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
