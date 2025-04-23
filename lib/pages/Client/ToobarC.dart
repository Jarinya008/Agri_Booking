import 'package:app_agri_booking/pages/Client/%E0%B9%8CNotification.dart';

import 'package:app_agri_booking/pages/Client/Home.dart';
import 'package:app_agri_booking/pages/Client/Me.dart';
import 'package:app_agri_booking/pages/Client/Queue.dart';

import 'package:flutter/material.dart';

class ToobarC extends StatefulWidget {
  final int value;
  final dynamic userData; // รับข้อมูลจาก Login
  const ToobarC({super.key, required this.value, required this.userData});

  @override
  State<ToobarC> createState() => _ToobarCState();
}

class _ToobarCState extends State<ToobarC> {
  late int value;
  late Widget curretnPage;

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
        curretnPage = HomeClientPage(userData: widget.userData);
      } else if (index == 1) {
        curretnPage = QueuePage(
          mid: widget.userData['mid'],
        );
      } else if (index == 2) {
        curretnPage = NotificationPage();
      } else if (index == 3) {
        // ส่ง userData ไปยัง MePage
        curretnPage = MePage(userData: widget.userData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: curretnPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // ให้แสดงไอคอน + ข้อความครบถ้วน
        backgroundColor: Colors.white, // เปลี่ยนพื้นหลังเป็นสีขาว
        currentIndex: value,
        selectedItemColor: const Color(0xFFEF6C00), // สีไอเท็มที่เลือกเป็นสีส้ม
        unselectedItemColor: Colors.black, // สีไอเท็มที่ไม่ได้เลือกเป็นสีดำ
        selectedLabelStyle: const TextStyle(
            color: Color(0xFFEF6C00)), // สีตัวหนังสือของไอเท็มที่เลือก
        unselectedLabelStyle: const TextStyle(
            color: Colors.black), // สีตัวหนังสือของไอเท็มที่ไม่ได้เลือก
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
