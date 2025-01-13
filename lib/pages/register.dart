import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_agri_booking/pages/Contractor/MyCars.dart';
import 'package:app_agri_booking/pages/Client/InsertFarm.dart';
import 'package:app_agri_booking/pages/map.dart'; // Import the map page
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      profileImage =
                          'assets/images/beginprofile.png'; // Placeholder profile image
                    });
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        profileImage != null ? AssetImage(profileImage!) : null,
                    child: profileImage == null
                        ? const Icon(Icons.person,
                            size: 50, color: Color.fromARGB(255, 135, 241, 169))
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: 'ชื่อผู้ใช้', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'อีเมล', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'รหัสผ่าน', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                    labelText: 'เบอร์โทร', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contractController,
                decoration: const InputDecoration(
                    labelText: 'ข้อมูลติดต่อเพิ่มเติม',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _openMapDialog,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 250, 231, 87)),
                child: const Text('เลือกตำแหน่ง GPS'),
              ),
              const SizedBox(height: 10),
              Text(
                'ตำแหน่งที่เลือก: ${lat ?? 'ไม่ระบุ'}, ${lng ?? 'ไม่ระบุ'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: addrassController,
                decoration: const InputDecoration(
                    labelText: 'ที่อยู่',
                    hintText: 'เช่น บ้านเลขที่ ชื่อหมู่บ้าน ถนน ลักษณะเด่น',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous page
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0)),
                    child: const Text('ยกเลิก',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 68, 255, 78)),
                    child: const Text('สมัครสมาชิก',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
