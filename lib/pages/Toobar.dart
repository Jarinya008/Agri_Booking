import 'package:flutter/material.dart';

class Toobar extends StatelessWidget {
  const Toobar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[300], // สีพื้นหลัง
      padding: const EdgeInsets.symmetric(vertical: 10), // ระยะห่างบน-ล่าง
      child: const Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // จัดตำแหน่งไอคอนให้กระจายทั่วแถว
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home, size: 30), // ไอคอนหน้าหลัก
              Text('หน้าหลัก'), // ข้อความด้านล่างไอคอน
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, size: 30), // ไอคอนโปรไฟล์
              Text('ฉัน'), // ข้อความด้านล่างไอคอน
            ],
          ),
        ],
      ),
    );
  }
}
