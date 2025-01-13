import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:flutter/material.dart';

class HomeUserAllPage extends StatelessWidget {
  const HomeUserAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ผู้ใช้ทั่วไป'),
      ),
      body: const Center(
        child: Text(
          'หน้าแรกผู้ใช้ทั่วไป', // ใส่ข้อความที่ต้องการแสดงที่นี่
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const Toobar(),
    );
  }
}
