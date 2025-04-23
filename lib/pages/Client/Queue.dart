import 'dart:convert';

import 'package:app_agri_booking/pages/Client/Search.dart';
import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QueuePage extends StatefulWidget {
  final int mid;
  const QueuePage({super.key, required this.mid});
  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  int selectedTabIndex = 0;

  List<Map<String, dynamic>> queueData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQueueData();
  }

  // 📌 ฟังก์ชันดึงข้อมูลจาก API
  Future<void> fetchQueueData() async {
    final String apiUrl =
        "http://projectnodejs.thammadalok.com/AGribooking/client/myqueue/${widget.mid}";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          queueData = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        print("⚠️ Error: ${response.body}");
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("❌ Fetch error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการจองคิวรถ'),
        backgroundColor: const Color(0xFFFFC074),
        centerTitle: true,
        automaticallyImplyLeading: false, // ปิดปุ่ม "กดกลับ"
      ),
      body: Column(
        children: [
          // ปุ่ม Tab
          Container(
            color: const Color.fromARGB(255, 244, 214, 169),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton('รายการจองคิว', 0),
                _buildTabButton('ประวัติการจองคิว', 1),
              ],
            ),
          ),
          // แสดงเนื้อหาตามแท็บที่เลือก
          Expanded(
            child: selectedTabIndex == 0
                ? _buildCurrentQueueContent()
                : _buildHistoryContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: selectedTabIndex == index
              ? const Color.fromARGB(255, 191, 239, 243)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedTabIndex == index ? Colors.black : Colors.black,
            fontSize: 15,
            fontWeight:
                selectedTabIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

//เนื้อหาในหน้ารายการจองคิว
  Widget _buildCurrentQueueContent() {
    return Container(
      color: const Color.fromARGB(255, 244, 214, 169),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'รายการจองคิวทั้งหมด',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16.0),

            // ✅ ใช้ ListView.builder เพื่อแสดงรายการ
            Expanded(
              child: queueData.isEmpty
                  ? const Center(child: Text("ไม่มีข้อมูลคิว"))
                  : ListView.builder(
                      itemCount: queueData.length,
                      itemBuilder: (context, index) {
                        final queue = queueData[index];
                        return _buildQueueItem(
                          queue['name_qt'] ?? "ไม่ระบุ",
                          queue['name_tract'] ?? "ไม่ระบุ",
                          queue['phone'] ?? "ไม่ระบุ",
                          queue['acc_status'] ?? "ไม่ระบุ",
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

//เนื้อหาในหน้าประวัติการจองคิว
  Widget _buildHistoryContent() {
    return Container(
      color: const Color.fromARGB(255, 244, 214, 169),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ประวัติการจองคิวทั้งหมด',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16.0),
            _buildQueueItem('ตัดอ้อยยยยยย', 'รถตัดอ้อยขนาดใหญ่ รุ่น CH570',
                '085-222-0000', 'สถานะทำงานเสร็จเรียบร้อย'),
            // Add more items as needed
          ],
        ),
      ),
    );
  }

  //เป็น code ส่วนที่รับเนื้อหามาใส่ในการ์ดแล้วส่งการ์ดไปแสดงตามหน้าที่ต้องการ
  Widget _buildQueueItem(
      String title, String subtitle, String phone, String status) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  'https://play-lh.googleusercontent.com/IawSyao8NWsYCE_o7GoN6PvngS_ev5wLhXb3XmqB0ijbq2GBZYK5Bu8sLppG2Yqhc3dE', // URL ของรูปภาพ
                  width: 70.0,
                  height: 70.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11.0),
                  ),
                  Text(
                    'เบอรโทร $phone',
                    style: const TextStyle(fontSize: 11.0),
                  ),
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Color.fromARGB(255, 2, 187, 233),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              width: 75.0,
              height: 100.0,
              child: ElevatedButton(
                onPressed: () {
                  // กำหนดการทำงานเมื่อกดปุ่ม
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 46, 210, 51),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '   รายละเอียดเพิ่มเติม',
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
