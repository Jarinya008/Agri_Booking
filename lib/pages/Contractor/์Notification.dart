// import 'dart:convert';

// import 'package:app_agri_booking/pages/Client/ToobarC.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class NotificationPage extends StatelessWidget {
//   final int mid;

//   const NotificationPage({Key? key, required this.mid}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('การแจ้งเตือน'),
//         backgroundColor: const Color(0xFFFFC074),
//         centerTitle: true,
//         automaticallyImplyLeading: false, // ปิดปุ่ม "กดกลับ"
//       ),
//       body: _buildHistoryContent(), // เรียกใช้ _buildHistoryContent ที่นี่
//     );
//   }

//   Future<List<dynamic>> fetchQueueDetails() async {
//     final url = Uri.parse(
//         "http://projectnodejs.thammadalok.com/AGribooking/contractor/myqueue/$mid");

//     print("กำลังดึงข้อมูลจาก: $url");

//     try {
//       final response = await http.get(url);
//       print("Response Code: ${response.statusCode}");

//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception("ไม่พบข้อมูล หรือเกิดข้อผิดพลาด");
//       }
//     } catch (e) {
//       throw Exception("เกิดข้อผิดพลาด: $e");
//     }
//   }

//   // เนื้อหารายการการแจ้งเตือน
//   Widget _buildHistoryContent() {
//     return Container(
//       color: const Color.fromARGB(255, 244, 214, 169),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           //ข้อมูลที่ส่งไปใส่การ์ด
//           children: [
//             const SizedBox(height: 16.0),
//             _buildQueueItem('ตัดอ้อยยยยยย', 'รถตัดอ้อยขนาดใหญ่ รุ่น CH570',
//                 '085-222-0000', 'สถานะทำงานเสร็จเรียบร้อย'),
//             const SizedBox(height: 16.0),
//             _buildQueueItem('ขุดดิน', 'รถแมคโคขนาดเลฺก ', '0252542221',
//                 'สถานะกำลังดำเนินงาน'),
//             // Add more items as needed
//           ],
//         ),
//       ),
//     );
//   }

//   // การ์ดแสดงข้อมูลที่ดึงข้อมูลมาใส่แล้วส่งกลับไป
//   Widget _buildQueueItem(
//       String title, String subtitle, String phone, String status) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 5.0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10.0),
//                 child: Image.network(
//                   'https://play-lh.googleusercontent.com/IawSyao8NWsYCE_o7GoN6PvngS_ev5wLhXb3XmqB0ijbq2GBZYK5Bu8sLppG2Yqhc3dE', // URL ของรูปภาพ
//                   width: 70.0,
//                   height: 70.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16.0),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                         fontSize: 15.0, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     subtitle,
//                     style: const TextStyle(fontSize: 11.0),
//                   ),
//                   Text(
//                     'เบอรโทร $phone',
//                     style: const TextStyle(fontSize: 11.0),
//                   ),
//                   Text(
//                     status,
//                     style: const TextStyle(
//                       fontSize: 11.0,
//                       color: Color.fromARGB(255, 2, 187, 233),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 SizedBox(
//                   width: 75.0,
//                   height: 50.0,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // กำหนดการทำงานเมื่อกดปุ่ม
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 46, 210, 51),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       padding: EdgeInsets.zero,
//                     ),
//                     child: const Text(
//                       'รับงาน',
//                       style: TextStyle(fontSize: 15.0, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: 75.0,
//                   height: 50.0,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // กำหนดการทำงานเมื่อกดปุ่ม
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 252, 72, 41),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       padding: EdgeInsets.zero,
//                     ),
//                     child: const Text(
//                       'ยกเลิก',
//                       style: TextStyle(fontSize: 15.0, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:app_agri_booking/pages/Contractor/MapScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  final int mid;

  const NotificationPage({Key? key, required this.mid}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> queueData = [];

  @override
  void initState() {
    super.initState();
    fetchQueueDetails();
  }

  Future<void> fetchQueueDetails() async {
    final url = Uri.parse(
        "http://projectnodejs.thammadalok.com/AGribooking/contractor/myqueue/${widget.mid}");

    print("กำลังดึงข้อมูลจาก: $url");

    try {
      final response = await http.get(url);
      print("Response Code: ${response.statusCode}");
      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          queueData = json.decode(response.body);
        });
      } else {
        throw Exception("ไม่พบข้อมูล หรือเกิดข้อผิดพลาด");
      }
    } catch (e) {
      print("เกิดข้อผิดพลาด: $e");
    }
  }

  Future<void> updateQueueStatus(int qtid, int status) async {
    print(qtid);
    print(status);
    final url = Uri.parse(
        "http://projectnodejs.thammadalok.com/AGribooking/contractor/update/acc_status");

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"qtid": qtid, "acc_status": status}),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          // อัปเดต UI โดยการลบไอเท็มออกจาก queueData
          queueData.removeWhere((item) => item['qtid'].toString() == qtid);
        });
      } else {
        print("เกิดข้อผิดพลาด: ${response.statusCode}");
        print("รายละเอียด: ${response.body}");
      }
    } catch (e) {
      print("เกิดข้อผิดพลาด: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การแจ้งเตือน'),
        backgroundColor: const Color(0xFFFFC074),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: queueData.isEmpty
          ? const Center(child: Text("ไม่มีข้อมูลการแจ้งเตือน"))
          : _buildHistoryContent(),
    );
  }

  Widget _buildHistoryContent() {
    return Container(
      color: const Color.fromARGB(255, 244, 214, 169),
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: queueData.length,
        itemBuilder: (context, index) {
          final item = queueData[index];

          return _buildQueueItem(
            item['name_qt']?.toString() ?? 'ไม่ระบุ',
            item['name_tract']?.toString() ?? 'ไม่ระบุ',
            item['client_phone']?.toString() ?? 'ไม่ระบุ',
            item['acc_status']?.toString() ?? 'ไม่ระบุ',
            item['queue_qtid'] ?? 0,
            item['farm_lat']?.toDouble() ?? 0.0,
            item['farm_lng']?.toDouble() ?? 0.0,
          );
        },
      ),
    );
  }

  Widget _buildQueueItem(String title, String subtitle, String phone,
      String status, int qtid, double farmLat, double farmLng) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'https://play-lh.googleusercontent.com/IawSyao8NWsYCE_o7GoN6PvngS_ev5wLhXb3XmqB0ijbq2GBZYK5Bu8sLppG2Yqhc3dE',
                width: 70.0,
                height: 70.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MapScreen(farmLat: farmLat, farmLng: farmLng),
                        ),
                      );
                    },
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(subtitle, style: const TextStyle(fontSize: 11.0)),
                  Text('เบอร์โทร: $phone',
                      style: const TextStyle(fontSize: 11.0)),
                  Text(status,
                      style:
                          const TextStyle(fontSize: 11.0, color: Colors.blue)),
                ],
              ),
            ),
            Column(
              children: [
                _buildActionButton('รับงาน', Colors.green, () async {
                  await updateQueueStatus(qtid, 1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MapScreen(farmLat: farmLat, farmLng: farmLng),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                _buildActionButton('ยกเลิก', Colors.red, () async {
                  await updateQueueStatus(qtid, 0);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 75.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 15.0, color: Colors.white)),
      ),
    );
  }
}
