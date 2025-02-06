import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การแจ้งเตือน'),
        backgroundColor: const Color(0xFFFFC074),
        centerTitle: true,
        automaticallyImplyLeading: false, // ปิดปุ่ม "กดกลับ"
      ),
      body: _buildHistoryContent(), // เรียกใช้ _buildHistoryContent ที่นี่
    );
  }

  // เนื้อหารายการการแจ้งเตือน
  Widget _buildHistoryContent() {
    return Container(
      color: const Color.fromARGB(255, 244, 214, 169),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //ข้อมูลที่ส่งไปใส่การ์ด
          children: [
            const SizedBox(height: 16.0),
            _buildQueueItem('ตัดอ้อยยยยยย', 'รถตัดอ้อยขนาดใหญ่ รุ่น CH570',
                '085-222-0000', 'สถานะทำงานเสร็จเรียบร้อย'),
            const SizedBox(height: 16.0),
            _buildQueueItem('ขุดดิน', 'รถแมคโคขนาดเลฺก ', '0252542221',
                'สถานะกำลังดำเนินงาน'),
            // Add more items as needed
          ],
        ),
      ),
    );
  }

  // การ์ดแสดงข้อมูลที่ดึงข้อมูลมาใส่แล้วส่งกลับไป
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
