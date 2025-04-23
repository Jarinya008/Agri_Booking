import 'package:app_agri_booking/pages/Client/QueueCar.dart';
import 'package:flutter/material.dart';
import 'package:app_agri_booking/pages/Client/Home.dart';
import 'package:app_agri_booking/pages/Client/Queue.dart';
import 'package:app_agri_booking/pages/Client/%E0%B9%8CNotification.dart';
import 'package:app_agri_booking/pages/Client/Me.dart';

class ToobarC extends StatefulWidget {
  final int value;
  final dynamic userData; // รับข้อมูลจาก Login

  const ToobarC({super.key, required this.value, required this.userData});

  @override
  State<ToobarC> createState() => _ToobarCState();
}

class _ToobarCState extends State<ToobarC> {
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
        currentPage = HomeClientPage(userData: widget.userData);
      } else if (index == 1) {
        currentPage = const QueuePage();
      } else if (index == 2) {
        currentPage = NotificationPage();
      } else if (index == 3) {
        currentPage = MePage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Show both icons and labels
        backgroundColor: Colors.white, // White background for the navbar
        currentIndex: value,
        selectedItemColor: const Color(0xFFEF6C00), // Orange for selected item
        unselectedItemColor: Colors.black, // Black for unselected items
        selectedLabelStyle: const TextStyle(
          color: Color(0xFFEF6C00),
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
        ),
        onTap: (index) => switchPage(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'จองคิว',
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
      ),
    );
  }
}
