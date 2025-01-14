import 'package:flutter/material.dart';

class InsertFarm extends StatelessWidget {
  final Map<String, dynamic> userData;

  const InsertFarm({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Farm'),
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
            Text(
                'ประเภทผู้ใช้งาน: ${userData['mtype'] == 0 ? 'เจ้าของรถ' : 'ผู้จ้าง'}'),
            const SizedBox(height: 20),
            const Text(
              'เพิ่มข้อมูลฟาร์มของคุณ:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // ใส่ฟอร์มหรือ UI เพิ่มข้อมูลฟาร์มที่นี่
          ],
        ),
      ),
    );
  }
}
