import 'package:app_agri_booking/pages/Client/%E0%B9%8CNotification.dart';
import 'package:app_agri_booking/pages/Client/Home.dart';
import 'package:app_agri_booking/pages/Client/Me.dart';
import 'package:app_agri_booking/pages/Client/Queue.dart';
import 'package:app_agri_booking/pages/Client/Search.dart';
import 'package:app_agri_booking/pages/HomeUserAll.dart';

import 'package:flutter/material.dart';

class ToobarC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[300], // สีพื้นหลัง
      padding: const EdgeInsets.symmetric(vertical: 10), // ระยะห่างบน-ล่าง
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // กระจายพื้นที่อย่างเท่ากัน
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าหลัก
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeClientPage()),
                );
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, size: 30), // ไอคอนหน้าหลัก
                  Text('หน้าหลัก'), // ข้อความด้านล่างไอคอน
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าจองคิว
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QueuePage()),
                );
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, size: 30), // ไอคอนจองคิว
                  Text('จองคิว'), // ข้อความด้านล่างไอคอน
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าการแจ้งเตือน
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chat, size: 30), // ไอคอนแจ้งเตือน
                  Text('แจ้งเตือน'), // ข้อความด้านล่างไอคอน
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าผู้ใช้
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MePage(
                            userData: null,
                          )),
                );
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 30), // ไอคอนโปรไฟล์
                  Text('ฉัน'), // ข้อความด้านล่างไอคอน
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
