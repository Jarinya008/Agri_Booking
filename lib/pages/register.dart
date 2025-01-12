import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int? selectedMtype; // เก็บค่า mtype (0 หรือ 1)
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? profileImage; // เก็บรูปโปรไฟล์

  Future<void> _registerUser() async {
    // ตรวจสอบว่าข้อมูลครบถ้วนก่อน
    if (selectedMtype == null ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
      return;
    }

    // ข้อมูลที่ต้องส่งไปยัง API
    final Map<String, dynamic> data = {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'image': profileImage ?? '', // หากไม่มีรูปให้ส่งค่าว่าง
      'mtype': selectedMtype,
    };

    try {
      // เรียกใช้ API
      final response = await http.post(
        Uri.parse(
            'https://agri-api-glxi.onrender.com/register'), // แทนที่ด้วย URL ของ API
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        // สมัครสมาชิกสำเร็จ
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(responseData['message'] ?? 'สมัครสมาชิกสำเร็จ')),
        );
        // รีเซ็ตฟอร์มหรือเปลี่ยนหน้า
        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneController.clear();
        setState(() {
          selectedMtype = null;
          profileImage = null;
        });
      } else {
        // เกิดข้อผิดพลาด
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'เกิดข้อผิดพลาด')),
        );
      }
    } catch (e) {
      // จัดการข้อผิดพลาดในการเชื่อมต่อ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สมัครสมาชิก'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'เลือกประเภทผู้ใช้งาน',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() {
                      selectedMtype = 0;
                    }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedMtype == 0 ? Colors.blue : Colors.grey,
                    ),
                    child: const Text('เจ้าของรถ'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() {
                      selectedMtype = 1;
                    }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedMtype == 1 ? Colors.blue : Colors.grey,
                    ),
                    child: const Text('ผู้จ้าง'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  // กดเพื่ออัปโหลดรูปภาพ (ทำ Mock สำหรับตอนนี้)
                  setState(() {
                    profileImage =
                        'assets/profile_placeholder.png'; // สมมติใส่รูปแทนที่
                  });
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage:
                      profileImage != null ? AssetImage(profileImage!) : null,
                  child: profileImage == null
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'ชื่อผู้ใช้',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'อีเมล',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'รหัสผ่าน',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'เบอร์โทร',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _registerUser, // เรียกฟังก์ชันเมื่อกดปุ่ม
                child: const Text('สมัครสมาชิก'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
