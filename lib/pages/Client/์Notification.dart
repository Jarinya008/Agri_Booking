import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การแจ้งเตือน'),
        backgroundColor: const Color(0xFFFFC074),
        centerTitle: true,
        automaticallyImplyLeading: false, // ปิดปุ่ม "กดกลับ"
      ),
      bottomNavigationBar: const ToobarC(),
    );
  }
}
