import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การแจ้งเตือน'),
        backgroundColor: const Color(0xFFFFC074),
        centerTitle: true,
        automaticallyImplyLeading: false, // Disable back button
      ),
      body: _buildHistoryContent(), // Display mock data in the body
    );
  }

  // Content of the notifications page
  Widget _buildHistoryContent() {
    return Container(
      color: const Color.fromARGB(255, 244, 214, 169),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

  // Notification item UI (Mock data)
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
                  'https://play-lh.googleusercontent.com/IawSyao8NWsYCE_o7GoN6PvngS_ev5wLhXb3XmqB0ijbq2GBZYK5Bu8sLppG2Yqhc3dE', // Sample image URL
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
                    'เบอร์โทร: $phone',
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
                  // Navigate to more details (dummy action here)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(),
                    ),
                  );
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

// Sample DetailsPage for navigation
class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดเพิ่มเติม'),
        backgroundColor: const Color(0xFFFFC074),
      ),
      body: Center(
        child: Text('รายละเอียดเพิ่มเติมที่นี่'), // Placeholder content
      ),
    );
  }
}
