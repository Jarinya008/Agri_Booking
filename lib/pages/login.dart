import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200], // สีพื้นหลัง
      body: SafeArea(
        child: SingleChildScrollView(
          // เพิ่ม SingleChildScrollView เพื่อให้เลื่อนได้
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // จัดตำแหน่งเริ่มต้น
            children: [
              // โลโก้และข้อความด้านบน
              Column(
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/images/Logo.png', // ใส่ path รูปภาพโลโก้
                    width: 240,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'เข้าสู่ระบบ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // ฟอร์มการเข้าสู่ระบบ
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5), // ขยับข้อความไปทางขวา
                      child: Text(
                        'ชื่อผู้ใช้ / email', // ข้อความที่อยู่ด้านบน
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 5), // ขยับข้อความไปทางขวา
                      child: Text(
                        'รหัสผ่าน', // ข้อความที่อยู่ด้านบน
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Colors.black, // กำหนดสีตัวอักษรเป็นสีดำ
                          ),
                          child: const Text('สมัครสมาชิก'),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Colors.black, // กำหนดสีตัวอักษรเป็นสีดำ
                          ),
                          child: const Text('ลืมรหัสผ่าน'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BA00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white, // ตั้งค่าตัวอักษรเป็นสีขาว
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Toobar(), // เรียกใช้ Toobar ที่สร้างแยก
    );
  }
}
