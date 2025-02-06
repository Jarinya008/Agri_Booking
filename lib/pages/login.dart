import 'dart:convert';
import 'package:app_agri_booking/config.dart';
import 'package:app_agri_booking/pages/Client/Home.dart';
import 'package:app_agri_booking/pages/Client/Me.dart';
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

  Future<void> _login() async {
    final String usernameOrEmail = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // ตรวจสอบรูปแบบว่าเป็นอีเมลหรือไม่
    final bool isEmail =
        RegExp(r"^[^@]+@[^@]+\.[^@]+$").hasMatch(usernameOrEmail);

    // เตรียมข้อมูลส่งไปยัง API
    final Map<String, dynamic> data = {
      if (isEmail) 'email': usernameOrEmail,
      if (!isEmail) 'username': usernameOrEmail,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.loginUser), // ใช้ loginUser จาก ApiConfig
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('users') &&
            responseData['users'] is List &&
            responseData['users'].isNotEmpty) {
          final List<dynamic> users = responseData['users'];

          if (users.length == 1) {
            _navigateToHomePage(users[0]['mtype'], users[0]);
          } else {
            _showUserSelectionDialog(users);
          }
        } else {
          _showErrorDialog('ไม่พบข้อมูลผู้ใช้');
        }
      } else {
        _showErrorDialog('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง');
      }
    } catch (e) {
      _showErrorDialog('เกิดข้อผิดพลาด: $e');
    }
  }

  void _navigateToHomePage(int mtype, dynamic userData) {
    if (userData != null && userData is Map<String, dynamic>) {
      print("Navigating with userData: $userData"); // ตรวจสอบค่า userData

      if (mtype == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeContractorPage()),
        );
      } else if (mtype == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MePage(userData: userData),
          ),
        );
      }
    } else {
      print("Error: userData is null or not a valid Map");
    }
  }

  void _showUserSelectionDialog(List<dynamic> users) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เลือกผู้ใช้'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: users.map((user) {
              final String username = user['username'];
              final int mtype = user['mtype'];
              final String userType = mtype == 0 ? 'เจ้าของรถ' : 'ผู้จ้าง';

              return ListTile(
                title: Text(username),
                subtitle: Text(userType),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToHomePage(mtype, user); // ส่ง userData ด้วย
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ข้อผิดพลาด'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }

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
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset('assets/images/Logo.png', width: 240),
              const SizedBox(height: 10),
              const Text(
                'เข้าสู่ระบบ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'ชื่อผู้ใช้ / email',
                        labelStyle: TextStyle(
                          fontSize: 20, // ปรับขนาดของตัวหนังสือ
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)), // ขอบมน
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior
                            .always, // ป้ายชื่ออยู่ด้านบนเสมอ
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 19,
                            horizontal: 18), // ปรับตำแหน่งป้ายชื่อ
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'รหัสผ่าน',
                        labelStyle: TextStyle(
                          fontSize: 20, // ปรับขนาดของตัวหนังสือ
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)), // ขอบมน
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior
                            .always, // ป้ายชื่ออยู่ด้านบนเสมอ
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 19,
                            horizontal: 18), // ปรับตำแหน่งป้ายชื่อ
                      ),
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerLeft, // จัดให้อยู่ทางซ้าย
                      child: TextButton(
                        onPressed: navigateToRegister,
                        child: const Text(
                          'สมัครสมาชิก',
                          style: TextStyle(
                            fontSize: 15, // กำหนดขนาดของตัวหนังสือ
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 74, 207, 70), // กำหนดสีพื้นหลังเป็นสีเขียว
                        foregroundColor:
                            Colors.white, // กำหนดสีของตัวหนังสือเป็นสีขาว
                        minimumSize: const Size(200,
                            50), // กำหนดขนาดขั้นต่ำของปุ่ม (กว้าง 200px, สูง 50px)
                      ),
                      child: const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                          fontSize: 20, // กำหนดขนาดของตัวหนังสือ
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
    );
  }
}
