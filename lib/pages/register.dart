import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_agri_booking/pages/Contractor/MyCars.dart';
import 'package:app_agri_booking/pages/Client/InsertFarm.dart';
import 'package:app_agri_booking/pages/map.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int? selectedMtype;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController contractController = TextEditingController();
  final TextEditingController addrassController = TextEditingController();
  String? profileImage;

  double? lat;
  double? lng;

  Future<void> _registerUser() async {
    if (selectedMtype == null ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        contractController.text.isEmpty ||
        addrassController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')));
      return;
    }

    final Map<String, dynamic> data = {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'image': 'profile.jpg',
      'contact': contractController.text,
      'address': addrassController.text,
      'lat': lat ?? 13.7563,
      'lng': lng ?? 100.5018,
      'mtype': selectedMtype,
    };

    print('Data being sent: $data');
    try {
      final response = await http.post(
        Uri.parse('http://192.168.215.78:3001/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData['message'] ?? 'สมัครสมาชิกสำเร็จ')));
        if (selectedMtype == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyCars(userData: data)),
          );
        } else if (selectedMtype == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InsertFarm(userData: data)),
          );
        }
      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData['message'] ?? 'เกิดข้อผิดพลาด')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้')));
      print('Error: $e');
    }
  }

  void _navigateToMapPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(
          onLocationSelected: (double lat, double lng) {
            setState(() {
              this.lat = lat;
              this.lng = lng;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('สมัครสมาชิก'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context)
                  .size
                  .height, // อย่างน้อยเท่ากับความสูงหน้าจอ
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // กดเพื่ออัปโหลดรูปภาพ (ทำ Mock สำหรับตอนนี้)
                        setState(() {
                          profileImage =
                              'assets/images/beginprofile.png'; // สมมติใส่รูปแทนที่
                        });
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: profileImage != null
                            ? AssetImage(profileImage!)
                            : null,
                        child: profileImage == null
                            ? const Icon(Icons.person,
                                size: 50,
                                color: Color.fromARGB(255, 135, 241, 169))
                            : null,
                      ),
                    ),
                  ),
                  const Text(
                    'เลือกประเภทผู้ใช้งาน',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() {
                            selectedMtype = 0;
                          }),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedMtype == 0
                                ? Color.fromARGB(255, 93, 177, 97)
                                : Color.fromARGB(255, 25, 92, 49),
                          ),
                          child: const Text(
                            'เจ้าของรถ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() {
                            selectedMtype = 1;
                          }),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedMtype == 1
                                ? Color.fromARGB(255, 93, 177, 97)
                                : Color.fromARGB(255, 25, 92, 49),
                          ),
                          child: const Text(
                            'ผู้จ้าง',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
                    keyboardType:
                        TextInputType.number, // ตั้งค่าแป้นพิมพ์เป็นตัวเลข
                    maxLength: 10, // จำกัดความยาวสูงสุดที่ 10 ตัวอักษร
                    decoration: const InputDecoration(
                      labelText: 'เบอร์โทร',
                      hintText: 'กรุณากรอกเบอร์โทร 10 หลัก', // ข้อความแนะนำ
                      border: OutlineInputBorder(),
                      counterText: '', // ซ่อนตัวนับข้อความ
                    ),
                    // onChanged: (value) {
                    //   if (value.length != 10) {
                    //     // แสดงคำเตือนเมื่อจำนวนตัวเลขไม่ครบ 10 ตัว
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text('เบอร์โทรต้องมี 10 หลัก'),
                    //       ),
                    //     );
                    //   }
                    // },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: contractController,
                    decoration: const InputDecoration(
                      labelText: 'ข้อมูลติดต่อเพิ่มเติม',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50, // กำหนดความสูงของปุ่ม
                    width: 100, // กำหนดให้ปุ่มขยายเต็มความกว้าง
                    child: ElevatedButton(
                      onPressed: _navigateToMapPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 250, 231, 87),
                      ),
                      child: const Text(
                        'GPS',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addrassController,
                    decoration: const InputDecoration(
                      labelText: 'ที่อยู่',
                      hintText:
                          'เช่น บ้านเลขที่ ชื่อหมู่บ้าน ถนน ลักษณะเด่น', // ข้อความจางๆ
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // จัดให้ปุ่มอยู่ข้างกัน
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // กลับไปหน้าก่อนหน้า
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 255, 0, 0), // สีของปุ่ม "ยกเลิก"
                        ),
                        child: const Text(
                          'ยกเลิก',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed:
                            _registerUser, // เรียกฟังก์ชันเมื่อกดปุ่ม "สมัครสมาชิก"
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 68, 255,
                              78), // กำหนดสีพื้นหลังของปุ่มเป็นสีเขียว
                        ),
                        child: const Text('สมัครสมาชิก',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}
