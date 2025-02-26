//import 'package:flutter/material.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class edituser extends StatelessWidget {
//   final dynamic userData; // รับข้อมูลที่ส่งมา

//   const edituser({super.key, this.userData});

//   @override
//   Widget build(BuildContext context) {

//   double? lat;
//   double? lng;
//   late GoogleMapController mapController;
//   late Marker _marker;

//     @override
//   void initState() {
//     super.initState();

//     lat = widget.farmData['lat'];
//     lng = widget.farmData['lng'];

//     // ตั้งค่าหมุดแผนที่
//     _marker = Marker(
//       markerId: const MarkerId('selected_location'),
//       position: LatLng(lat ?? 13.7563, lng ?? 100.5018),
//     );
//   }
//     print(this.userData);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('แก้ไขข้อมูลส่วนตัว'),
//         backgroundColor: Colors.orange[100],
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         color: Colors.orange[100],
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       //ใส่รูปโปรไฟล์
//                       backgroundImage: AssetImage('assets/images/Logo.png'),
//                     ),
//                     CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.edit, color: Colors.black),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16.0),
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         _buildTextField(
//                             'ชื่อผู้ใช้', userData['username'], false),
//                         _buildTextField('Email', userData['email'], false),
//                         _buildTextField('เบอร์โทร', userData['phone'], false),
//                         _buildTextField('ข้อมูลการติดต่อเพิ่มเติม',
//                             userData['contact'], false,
//                             maxLines: 3),
//                         const SizedBox(height: 8.0),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton.icon(
//                                 onPressed: () {},
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.yellow,
//                                 ),
//                                 icon: const Icon(Icons.location_on,
//                                     color: Colors.black),
//                                 label: const Text('GPS',
//                                     style: TextStyle(color: Colors.black)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8.0),
//                         _buildTextField('ที่อยู่', userData['address'], false,
//                             maxLines: 3),
//                         const SizedBox(height: 16.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red,
//                               ),
//                               child: const Text('ยกเลิก',
//                                   style: TextStyle(color: Colors.white)),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                               ),
//                               child: const Text('ยืนยัน',
//                                   style: TextStyle(color: Colors.white)),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, String value, bool isEditable,
//       {int maxLines = 1}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: TextEditingController(text: value),
//         readOnly: !isEditable,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:app_agri_booking/pages/Client/Me.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditUser extends StatefulWidget {
  final dynamic userData;

  const EditUser({super.key, required this.userData});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController passwordController;
  late TextEditingController imageController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController contactController;
  late TextEditingController addressController;
  double? lat;
  double? lng;
  int? mid;
  int? mtype;
  GoogleMapController? mapController;
  Marker? _marker;

  @override
  void initState() {
    super.initState();

    // กำหนดค่าเริ่มต้นให้ TextEditingController

    nameController = TextEditingController(text: widget.userData['username']);
    passwordController =
        TextEditingController(text: widget.userData['password']);
    emailController = TextEditingController(text: widget.userData['email']);
    phoneController = TextEditingController(text: widget.userData['phone']);
    contactController = TextEditingController(text: widget.userData['contact']);
    addressController = TextEditingController(text: widget.userData['address']);
    imageController = TextEditingController(text: 'assets/images/Logo.png');
    mtype = widget.userData['mtype'];
    mid = widget.userData['mid'];
    // ตรวจสอบและตั้งค่าพิกัดเริ่มต้น
    lat = (widget.userData['lat'] as num).toDouble();
    lng = (widget.userData['lng'] as num).toDouble();

    _marker = Marker(
      markerId: const MarkerId('selected_location'),
      position: LatLng(lat!, lng!),
    );
  }

  @override
  void dispose() {
    // เคลียร์ค่าของ TextEditingController เพื่อป้องกัน memory leak
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    contactController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageController.text = image.path; // อัพเดตเส้นทางของภาพที่เลือก
      });
    }
  }

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
                    target: initialLocation,
                    zoom: 12,
                  ),
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  onTap: (LatLng location) {
                    setDialogState(() {
                      lat = location.latitude;
                      lng = location.longitude;
                      _marker = Marker(
                        markerId: const MarkerId('selected_location'),
                        position: location,
                      );
                    });
                  },
                  markers: _marker != null ? {_marker!} : {},
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, LatLng(lat!, lng!));
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

  Future<void> _updateUserData() async {
    const String apiUrl =
        "http://projectnodejs.thammadalok.com/AGribooking/member/edit";

    // สร้างข้อมูล JSON ที่จะส่ง
    final Map<String, dynamic> data = {
      "mid": mid,
      "username": nameController.text,
      "newEmail": emailController.text,
      "password": passwordController.text,
      "phone": phoneController.text,
      "image": imageController.text,
      "contact": contactController.text,
      "address": addressController.text,
      "lat": lat,
      "lng": lng,
      "mtype": mtype,
    };

    final response = await http.put(
      Uri.parse(apiUrl), // ใช้ apiUrl ที่ถูกต้อง
      headers: {"Content-Type": "application/json"},
      body: json.encode(data), // ส่งข้อมูลที่เป็น JSON
    );
    if (response.statusCode == 200) {
      print('ข้อมูลถูกอัปเดตแล้ว');
      // นำทางไปยังหน้า MePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MePage(userData: widget.userData)), // ปรับให้เป็นหน้าที่ต้องการ
      );
    } else {
      print('เกิดข้อผิดพลาดในการอัปเดตข้อมูล');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลส่วนตัว'),
        backgroundColor: Colors.orange[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.orange[100],
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/Logo.png'),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTextField('ชื่อผู้ใช้', nameController, true),
                        _buildTextField('Email', emailController, true),
                        _buildTextField('เบอร์โทร', phoneController, true),
                        _buildTextField(
                            'ข้อมูลการติดต่อเพิ่มเติม', contactController, true,
                            maxLines: 3),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed:
                                    _openMapDialog, // เรียกใช้ฟังก์ชันเมื่อกดปุ่ม
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                ),
                                icon: const Icon(Icons.location_on,
                                    color: Colors.black),
                                label: const Text('GPS',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        _buildTextField('ที่อยู่', addressController, true,
                            maxLines: 3),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('ยกเลิก',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _updateUserData();
                                // เพิ่มฟังก์ชันบันทึกข้อมูลที่นี่
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('ยืนยัน',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isEditable,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: !isEditable,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildGPSButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: _openMapDialog,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.black),
              SizedBox(width: 5),
              Text('GPS',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ยกเลิก', style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _updateUserData; // Call this to update the user data
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('ยืนยัน', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
