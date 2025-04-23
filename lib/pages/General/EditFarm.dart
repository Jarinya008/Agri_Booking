// import 'package:flutter/material.dart';

// class EditFarmPage extends StatelessWidget {
//   final String farmData;

//   const EditFarmPage({super.key, required this.farmData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('แก้ไขข้อมูลไร่นา'),
//         backgroundColor: Colors.amber,
//         centerTitle: true,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'กรุณากรอกข้อมูลไร่นา',
//                   style: TextStyle(color: Colors.red, fontSize: 16),
//                 ),
//                 const SizedBox(height: 10),
//                 _buildTextField('ตำบล'),
//                 _buildTextField('อำเภอ'),
//                 _buildTextField('จังหวัด'),
//                 _buildTextField('รายละเอียดที่อยู่',
//                     maxLines: 3, hintText: 'เช่น 16/50 บ้านนาคา ตำบล...'),
//                 _buildGPSButton(),
//                 _buildTextField('ที่อยู่', maxLines: 3),
//                 const SizedBox(height: 20),
//                 _buildBottomButtons(context),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTextField(String label, {int maxLines = 1, String? hintText}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 5),
//           TextFormField(
//             maxLines: maxLines,
//             decoration: InputDecoration(
//               hintText: hintText,
//               filled: true,
//               fillColor: Colors.grey[300],
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGPSButton() {
//     return Center(
//       child: SizedBox(
//         width: double.infinity, // ทำให้ปุ่มกว้างเต็มพื้นที่เท่ากับ TextField
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.yellow,
//             foregroundColor: Colors.black,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           onPressed: () {
//             // TODO: เพิ่มฟังก์ชัน GPS
//           },
//           child: const Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.center, // จัดไอคอนและข้อความไว้กลางปุ่ม
//             children: [
//               Icon(Icons.location_on, color: Colors.black),
//               SizedBox(width: 5), // เว้นช่องว่างระหว่างไอคอนกับข้อความ
//               Text(
//                 'GPS',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomButtons(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.grey,
//               foregroundColor: Colors.black,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('ยกเลิก', style: TextStyle(fontSize: 16)),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed: () {
//               // TODO: เพิ่มฟังก์ชันยืนยันข้อมูล
//             },
//             child: const Text('ยืนยัน', style: TextStyle(fontSize: 16)),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditFarmPage extends StatefulWidget {
  final Map<String, dynamic> farmData;

  const EditFarmPage({super.key, required this.farmData});

  @override
  _EditFarmPageState createState() => _EditFarmPageState();
}

class _EditFarmPageState extends State<EditFarmPage> {
  late TextEditingController nameController;
  late TextEditingController tumbolController;
  late TextEditingController districtController;
  late TextEditingController provinceController;
  late TextEditingController detailController;

  double? lat;
  double? lng;
  late GoogleMapController mapController;
  late Marker _marker;

  @override
  void initState() {
    super.initState();
    // ตั้งค่าตัวควบคุมฟอร์มจากข้อมูลที่มีอยู่
    nameController = TextEditingController(text: widget.farmData['name_farm']);
    tumbolController = TextEditingController(text: widget.farmData['tumbol']);
    districtController =
        TextEditingController(text: widget.farmData['district']);
    provinceController =
        TextEditingController(text: widget.farmData['province']);
    detailController = TextEditingController(text: widget.farmData['detail']);

    lat = widget.farmData['lat'];
    lng = widget.farmData['lng'];

    // ตั้งค่าหมุดแผนที่
    _marker = Marker(
      markerId: const MarkerId('selected_location'),
      position: LatLng(lat ?? 13.7563, lng ?? 100.5018),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    tumbolController.dispose();
    districtController.dispose();
    provinceController.dispose();
    detailController.dispose();
    super.dispose();
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
                  markers: {_marker},
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

  Future<void> updateFarm() async {
    final String apiUrl =
        "http://projectnodejs.thammadalok.com/AGribooking/client/update/farm/${widget.farmData['fid']}";

    final Map<String, dynamic> farmData = {
      "name_farm": nameController.text,
      "tumbol": tumbolController.text,
      "district": districtController.text,
      "province": provinceController.text,
      "detail": detailController.text,
      "lat": lat,
      "lng": lng
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(farmData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("อัปเดตฟาร์มสำเร็จ!")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("อัปเดตไม่สำเร็จ: ${response.body}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("เกิดข้อผิดพลาด: $error")),
      );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, String? hintText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลไร่นา'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'กรุณากรอกข้อมูลไร่นา',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 10),
                _buildTextField('ชื่อฟาร์ม', nameController),
                _buildTextField('ตำบล', tumbolController),
                _buildTextField('อำเภอ', districtController),
                _buildTextField('จังหวัด', provinceController),
                _buildTextField('รายละเอียดที่อยู่', detailController,
                    maxLines: 3, hintText: 'เช่น 16/50 บ้านนาคา ตำบล...'),
                _buildGPSButton(),
                const SizedBox(height: 20),
                _buildBottomButtons(context),
              ],
            ),
          );
        },
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: updateFarm,
            child: const Text('ยืนยัน', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
