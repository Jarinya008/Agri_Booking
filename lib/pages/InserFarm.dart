// import 'package:flutter/material.dart';

// class InsertFarmPage extends StatelessWidget {
//   final int mid;

//   const InsertFarmPage({super.key, required this.mid});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ข้อมูลไร่นา'),
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
//           onPressed: _openMapDialog() {
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
//             child: const Text('ข้าม', style: TextStyle(fontSize: 16)),
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class InsertFarmPage extends StatefulWidget {
  final int mid;

  const InsertFarmPage({super.key, required this.mid});

  @override
  _InsertFarmPageState createState() => _InsertFarmPageState();
}

class _InsertFarmPageState extends State<InsertFarmPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tumbolController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();

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
                    target: initialLocation,
                    zoom: 12,
                  ),
                  mapType: MapType.normal,
                  onTap: (LatLng location) {
                    setDialogState(() {
                      lat = location.latitude;
                      lng = location.longitude;
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
        latController.text = lat.toString();
        lngController.text = lng.toString();
      });
    }
  }

  Future<void> _submitFarm() async {
    final url =
        "http://projectnodejs.thammadalok.com/AGribooking/client/insert/farm";

    final Map<String, dynamic> farmData = {
      "name_farm": nameController.text,
      "tumbol": tumbolController.text,
      "district": districtController.text,
      "province": provinceController.text,
      "detail": detailController.text,
      "lat": lat,
      "lng": lng,
      "mid": widget.mid
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(farmData),
      );

      final responseData = jsonDecode(response.body);
      print("🔹 API Response: $responseData");

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("เพิ่มฟาร์มสำเร็จ!")),
        );
        Navigator.pop(context, widget.mid); // ส่ง mid กลับไป
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("เกิดข้อผิดพลาด: ${responseData['message']}")),
        );
      }
    } catch (e) {
      print("🚨 Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("เกิดข้อผิดพลาดในการเชื่อมต่อ")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มฟาร์ม'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("ชื่อฟาร์ม", nameController),
            _buildTextField("ตำบล", tumbolController),
            _buildTextField("อำเภอ", districtController),
            _buildTextField("จังหวัด", provinceController),
            _buildTextField("รายละเอียดที่อยู่", detailController, maxLines: 3),
            _buildGPSButton(),
            _buildTextField("ละติจูด", latController, readOnly: true),
            _buildTextField("ลองจิจูด", lngController, readOnly: true),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, bool readOnly = false}) {
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
            readOnly: readOnly,
            decoration: InputDecoration(
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
              Text(
                'เลือกตำแหน่ง GPS',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: _submitFarm,
          child: const Text("เพิ่มฟาร์ม", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
