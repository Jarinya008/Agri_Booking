import 'package:app_agri_booking/pages/HomeUserAll.dart';
import 'package:app_agri_booking/pages/login.dart';
import 'package:flutter/material.dart';

class Toobar extends StatelessWidget {
  const Toobar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[300], // สีพื้นหลัง
      padding: const EdgeInsets.symmetric(vertical: 10), // ระยะห่างบน-ล่าง
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // จัดตำแหน่งไอคอนให้กระจายทั่วแถว
        children: [
          GestureDetector(
            onTap: () {
              // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าหลัก
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeUserAllPage()),
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
          GestureDetector(
            onTap: () {
              // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าผู้ใช้
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
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
        ],
      ),
    );
  }
}
