import 'package:flutter/material.dart';

class HomeContractorPage extends StatelessWidget {
  const HomeContractorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าเปล่า'),
      ),
      body: const Center(
        child: Text(
          'หน้าเจ้าของรถ', // ใส่ข้อความที่ต้องการแสดงที่นี่
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
