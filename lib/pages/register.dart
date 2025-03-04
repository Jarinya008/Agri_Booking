import 'dart:io';

import 'package:app_agri_booking/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_agri_booking/pages/Contractor/MyCars.dart';
import 'package:app_agri_booking/pages/Client/InsertFarm.dart';
import 'package:app_agri_booking/pages/map.dart'; // Import the map page
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _openMapDialog() async {
    LatLng? selectedLocation = await showDialog<LatLng>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('เลือกตำแหน่ง'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                LatLng initialLocation =
                    LatLng(lat ?? 13.7563, lng ?? 100.5018);
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:
                        initialLocation, // Use the previously selected location or the default
                    zoom: 12,
                  ),
                  mapType: MapType.normal,
                  onTap: (LatLng location) {
                    setDialogState(() {
                      lat = location.latitude;
                      lng = location.longitude; // Update the selected location
                    });
                  },
                  markers: lat != null && lng != null
                      ? {
                          Marker(
                            markerId: const MarkerId('selected_location'),
                            position: LatLng(lat!, lng!),
                          )
                        }
                      : {},
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context); // Close the dialog without selecting a location
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context,
                    LatLng(lat!, lng!)); // Return the selected location
              },
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );

    if (selectedLocation != null) {
      setState(() {
        lat = selectedLocation.latitude;
        lng = selectedLocation.longitude;
      });
    }
  }

  Future<void> _registerUser() async {
    if (selectedMtype == null ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        contractController.text.isEmpty ||
        addrassController.text.isEmpty ||
        lat == null ||
        lng == null) {
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
      'lat': lat,
      'lng': lng,
      'mtype': selectedMtype,
    };

    print('Data being sent: $data');
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.registerUser), // ใช้ loginUser จาก ApiConfig
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

  File? _selectedImage;

  Future<void> _pickImage() async {
    try {
      print("Attempting to pick image...");
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        print("Image selected: ${image.path}");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
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
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : null, // ไม่มี backgroundImage ถ้าไม่มีการเลือกภาพ
                    child: _selectedImage == null
                        ? const Icon(
                            Icons.person, // ไอคอนรูปคน
                            size: 40, // ขนาดไอคอน
                            color: Colors.green, // สีไอคอน
                          )
                        : null, // ไม่แสดงไอคอนเมื่อมีการเลือกภาพ
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0), // กำหนดระยะห่างซ้ายขวา
                child: Text(
                  'โปรดเลือกประเภทผู้ใช้',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        selectedMtype = 0;
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedMtype == 0
                            ? const Color.fromARGB(255, 93, 177, 97)
                            : const Color.fromARGB(255, 25, 92, 49),
                      ),
                      child: const Text(
                        'เจ้าของรถ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        selectedMtype = 1;
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedMtype == 1
                            ? const Color.fromARGB(255, 93, 177, 97)
                            : const Color.fromARGB(255, 25, 92, 49),
                      ),
                      child: const Text(
                        'ผู้จ้าง',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20), // เพิ่มระยะห่างภายใน
                decoration: BoxDecoration(
                  color: Colors.orange, // สีพื้นหลังสีส้ม
                  borderRadius: BorderRadius.circular(12), // ขอบโค้งมน
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'ชื่อผู้ใช้',
                        filled: true, // ทำให้พื้นหลังเป็นสีที่กำหนด
                        fillColor: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black), // ขอบสีดำ
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'อีเมล',
                        filled: true, // ทำให้พื้นหลังเป็นสีที่กำหนด
                        fillColor: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black), // ขอบสีดำ
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'รหัสผ่าน',
                        filled: true, // ทำให้พื้นหลังเป็นสีที่กำหนด
                        fillColor: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black), // ขอบสีดำ
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: 'เบอร์โทร',
                        filled: true, // ทำให้พื้นหลังเป็นสีที่กำหนด
                        fillColor: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black), // ขอบสีดำ
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: contractController,
                      maxLength: 255,
                      decoration: const InputDecoration(
                        labelText: 'ข้อมูลติดต่อเพิ่มเติม',
                        filled: true, // ทำให้พื้นหลังเป็นสีที่กำหนด
                        fillColor: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black), // ขอบสีดำ
                        ),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // ชิดซ้าย
                      children: [
                        ElevatedButton(
                          onPressed: _openMapDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 250, 231, 87),
                          ),
                          child: const Text('เลือกตำแหน่ง GPS'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    TextField(
                      controller: addrassController,
                      maxLength: 500,
                      decoration: const InputDecoration(
                        labelText: 'ที่อยู่',
                        hintText: 'เช่น บ้านเลขที่ ชื่อหมู่บ้าน ถนน ลักษณะเด่น',
                        filled: true, // ทำให้พื้นหลังเป็นสีที่กำหนด
                        fillColor: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black), // ขอบสีดำ
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // Go back to the previous page
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 0, 0),
                          ),
                          child: const Text('ยกเลิก',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: _registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 68, 255, 78),
                          ),
                          child: const Text('สมัครสมาชิก',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
