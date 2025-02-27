import 'package:flutter/material.dart';

class HomeContractorPage extends StatelessWidget {
  final dynamic userData; // รับข้อมูลที่ส่งมา

  const HomeContractorPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'หน้าเจ้าของรถ', // ใส่ข้อความที่ต้องการแสดงที่นี่
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
