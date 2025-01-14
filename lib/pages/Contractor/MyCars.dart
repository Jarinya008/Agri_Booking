import 'package:flutter/material.dart';

class MyCars extends StatelessWidget {
  final Map<String, dynamic> userData;

  const MyCars({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cars'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ข้อมูลผู้ใช้ที่สมัครสมาชิก:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('ชื่อผู้ใช้: ${userData['username']}'),
            Text('อีเมล: ${userData['email']}'),
            Text('เบอร์โทร: ${userData['phone']}'),
            const SizedBox(height: 20),
            const Text(
              'รายการรถของคุณ:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // เพิ่มส่วนจัดการรถ เช่น ฟอร์มหรือรายการรถ
          ],
        ),
      ),
    );
  }
}
