import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200], // สีพื้นหลัง
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // โลโก้และข้อความด้านบน
            Column(
              children: [
                SizedBox(height: 40),
                Image.asset(
                  'assets/images/Logo.png', // ใส่ path รูปภาพโลโก้
                  width: 250,
                  // height: 15,
                ),
                SizedBox(height: 10),
                Text(
                  'เข้าสู่ระบบ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // ฟอร์มการเข้าสู่ระบบ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'ชื่อผู้ใช้ / email',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'รหัสผ่าน',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Colors.black, // กำหนดสีตัวอักษรเป็นสีดำ
                        ),
                        child: Text('สมัครสมาชิก'),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Colors.black, // กำหนดสีตัวอักษรเป็นสีดำ
                        ),
                        child: Text('ลืมรหัสผ่าน'),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00BA00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
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
      bottomNavigationBar: Toobar(), // เรียกใช้ Toobar ที่สร้างแยก
    );
  }
}
