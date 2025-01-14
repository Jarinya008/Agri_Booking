import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:flutter/material.dart';

class HomeUserAllPage extends StatelessWidget {
  const HomeUserAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
=======
      appBar: AppBar(
        title: const Text('ผู้ใช้ทั่วไป'),
      ),
      body: const Center(
        child: Text(
          'หน้าแรกผู้ใช้ทั่วไป', // ใส่ข้อความที่ต้องการแสดงที่นี่
          style: TextStyle(fontSize: 24),
        ),
      ),
>>>>>>> whan
      bottomNavigationBar: const Toobar(),
      body: Column(
        children: [
          // รูปภาพ
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity, // ใช้เต็มความกว้างของหน้าจอ
            height: 200, // ความสูงที่กำหนด
            child: Image.asset(
              'assets/images/Logo.png',
              fit: BoxFit.contain, // ปรับขนาดรูปภาพให้พอดีโดยรักษาสัดส่วน
            ),
          ),

          // ช่องค้นหา
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหา : ชื่อรถ,ประเภทรถ,ราคา,จังหวัด,อำเภอ',
                prefixIcon: const Icon(Icons.search),
                fillColor: Colors.grey[200], // สีพื้นหลังของช่องค้นหา
                filled: true, // เปิดการใช้งานสีพื้นหลัง
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // เอาเส้นกรอบออกเพื่อให้ดูเรียบ
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
