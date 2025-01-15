import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:flutter/material.dart';

class QueuePage extends StatefulWidget {
  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการจองคิวรถ'),
        backgroundColor: const Color(0xFFFFC074),
        centerTitle: true,
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
      bottomNavigationBar: const ToobarC(),
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
              ? Color.fromARGB(255, 191, 239, 243)
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

  Widget _buildCurrentQueueContent() {
    // เนื้อหาสำหรับ "รายการจองคิว"
    return Container(
      color: const Color.fromARGB(255, 244, 214, 169), // สีพื้นหลัง
      child: const Align(
        alignment: Alignment.topLeft, // ขยับเนื้อหาไปมุมบนซ้าย
        child: Padding(
          padding: EdgeInsets.all(16.0), // ระยะห่างขอบ
          child: Text(
            '    รายการจองคิวทั้งหมด',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryContent() {
    // เนื้อหาสำหรับ "ประวัติการจองคิว"
    return Container(
      color: const Color.fromARGB(255, 244, 214, 169), // สีพื้นหลัง
      child: const Align(
        alignment: Alignment.topLeft, // ขยับเนื้อหาไปมุมบนซ้าย
        child: Padding(
          padding: EdgeInsets.all(16.0), // ระยะห่างขอบ
          child: Text(
            '    ประวัติการจองคิวทั้งหมด',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
