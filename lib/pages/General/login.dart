import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:app_agri_booking/pages/Contractor/ToobarCar.dart';
import 'package:app_agri_booking/pages/General/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // ตัวอย่างการนำทางแบบกำหนดเอง
    // ลองเปลี่ยนค่าด้านล่างตาม mtype ที่คุณต้องการจำลอง
    int mtype = 1; // 0 = เจ้าของรถ, 1 = ผู้จ้าง

    Map<String, dynamic> dummyUserData = {
      'username': _usernameController.text.trim(),
      'mtype': mtype,
    };

    _navigateToHomePage(mtype, dummyUserData);
  }

  void _navigateToHomePage(int mtype, dynamic userData) {
    if (mtype == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ToolbarCar(
                  userData: userData,
                  value: 1,
                )),
      );
    } else if (mtype == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ToobarC(
            userData: userData,
            value: 0,
          ),
        ),
      );
    }
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
                        labelStyle: TextStyle(fontSize: 20),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 19, horizontal: 18),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'รหัสผ่าน',
                        labelStyle: TextStyle(fontSize: 20),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 19, horizontal: 18),
                      ),
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: navigateToRegister,
                        child: const Text(
                          'สมัครสมาชิก',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 74, 207, 70),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(fontSize: 20),
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
