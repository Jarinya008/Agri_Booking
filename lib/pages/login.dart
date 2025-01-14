import 'dart:convert';
import 'package:app_agri_booking/pages/Client/Home.dart';
import 'package:app_agri_booking/pages/Contractor/Home.dart';
import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:app_agri_booking/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ฟังก์ชันสำหรับตรวจสอบการเข้าสู่ระบบ
  // ฟังก์ชันสำหรับตรวจสอบการเข้าสู่ระบบ
  Future<void> _login() async {
    final String usernameOrEmail = _usernameController.text;
    final String password = _passwordController.text;

    // ตรวจสอบว่าเป็นอีเมลหรือไม่
    bool isEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(usernameOrEmail);

    final Map<String, dynamic> data = {
      if (isEmail) 'email': usernameOrEmail,
      if (!isEmail) 'username': usernameOrEmail,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse('http://192.168.215.78:3001/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // ตรวจสอบว่า response มี users และข้อมูลใน users
        if (responseData.containsKey('users') &&
            responseData['users'] is List &&
            responseData['users'].isNotEmpty) {
          final List<dynamic> users = responseData['users']; // ดึงผู้ใช้ทั้งหมด
          print('Users fetched: $users');

          // ตัวอย่าง: แสดงชื่อผู้ใช้ทั้งหมดใน Console
          for (var user in users) {
            print('User: ${user['username']}, mtype: ${user['mtype']}');
          }

          final int rowCount = responseData['rowCount'];

          if (rowCount == 1) {
            // กรณีมีผู้ใช้เพียงคนเดียว
            final int mtype = users[0]['mtype'];
            _navigateToHomePage(mtype); // นำทางไปหน้าผู้ใช้ประเภทนั้น
          } else if (rowCount > 1) {
            // กรณีมีผู้ใช้มากกว่าหนึ่งคน ให้เลือก mtype
            _showUserSelectionDialog(users); // เปิด Dialog เพื่อเลือก mtype
          }
        } else {
          _showErrorDialog('ข้อมูลการตอบกลับไม่สมบูรณ์');
        }
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        _showErrorDialog(errorData['message']);
      }
    } catch (e) {
      _showErrorDialog('เกิดข้อผิดพลาด: $e');
    }
  }

// ฟังก์ชันสำหรับแสดงป๊อปอัปถามผู้ใช้ว่าอยากเข้าสู่ระบบในฐานะอะไร
  void _showUserTypeDialog(int mtype) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เลือกประเภทผู้ใช้'),
          content: Text(
              'คุณต้องการเข้าสู่ระบบในฐานะ ${mtype == 0 ? "Contractor" : "Client"} หรือไม่?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToHomePage(mtype); // หากผู้ใช้เลือก ยืนยัน
              },
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }

// ฟังก์ชันสำหรับนำทางไปยังหน้าต่างๆ ตาม mtype
  void _navigateToHomePage(int mtype) {
    if (mtype == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeContractorPage()),
      );
    } else if (mtype == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeClientPage()),
      );
    }
  }

  void _showUserSelectionDialog(List<dynamic> users) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เลือกประเภทผู้ใช้'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: users.map((user) {
                final String username = user['username'];
                final int mtype = user['mtype'];

                // แปลง mtype เป็นข้อความ
                final String userType = mtype == 0 ? 'เจ้าของรถ' : 'ผู้จ้าง';

                return ListTile(
                  title: Text(username),
                  subtitle: Text(userType), // แสดงประเภทผู้ใช้ในรูปแบบข้อความ
                  onTap: () {
                    Navigator.pop(context); // ปิด Dialog
                    _navigateToHomePage(mtype); // ส่ง mtype และนำทาง
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
              },
              child: Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

  // ฟังก์ชันสำหรับแสดงข้อความข้อผิดพลาด
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ข้อผิดพลาด'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }

//ไปยังหน้าสมัครสมาชิก
  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Register(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 214, 169), // สีพื้นหลัง
      body: SafeArea(
        child: SingleChildScrollView(
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
                        'ชื่อผู้ใช้ / email',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _usernameController,
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
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'รหัสผ่าน',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: navigateToRegister,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('สมัครสมาชิก'),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('ลืมรหัสผ่าน'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _login,
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
                          color: Colors.white,
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
