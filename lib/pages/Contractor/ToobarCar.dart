import 'dart:convert';

import 'package:app_agri_booking/pages/Contractor/%E0%B9%8CNotification.dart';
import 'package:app_agri_booking/pages/Contractor/Home.dart';
import 'package:app_agri_booking/pages/Contractor/MyCars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToolbarCar extends StatefulWidget {
  final int value;
  final dynamic userData; // รับข้อมูลจาก Login

  const ToolbarCar({super.key, required this.value, required this.userData});

  @override
  State<ToolbarCar> createState() => _ToolbarCarState();
}

class _ToolbarCarState extends State<ToolbarCar> {
  late int value;
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    value = widget.value;
    switchPage(value);
  }

  void switchPage(int index) {
    setState(() {
      value = index;
      if (index == 0) {
        currentPage = HomeContractorPage();
      } else if (index == 1) {
        currentPage = NotificationPage(mid: widget.userData['mid']);
      } else if (index == 2) {
        currentPage = MyCars(
          userData: widget.userData,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'ตารางงาน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'แจ้งเตือน',
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
