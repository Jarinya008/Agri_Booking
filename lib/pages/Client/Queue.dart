import 'package:flutter/material.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  int selectedTabIndex = 0;

  // ✅ จำลองข้อมูล
  List<Map<String, dynamic>> queueData = [
    {
      'name_qt': 'ตัดอ้อย',
      'name_tract': 'รถตัดอ้อยขนาดใหญ่ รุ่น CH570',
      'phone': '089-123-4567',
      'acc_status': 'กำลังดำเนินการ',
    },
    {
      'name_qt': 'ไถพรวนดิน',
      'name_tract': 'รถไถ John Deere',
      'phone': '087-987-6543',
      'acc_status': 'รอการยืนยัน',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการจองคิวรถ'),
        backgroundColor: const Color(0xFFFFC074),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
            color: Colors.black,
            fontSize: 15,
            fontWeight:
                selectedTabIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

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
            Expanded(
              child: queueData.isEmpty
                  ? const Center(child: Text("ไม่มีข้อมูลคิว"))
                  : ListView.builder(
                      itemCount: queueData.length,
                      itemBuilder: (context, index) {
                        final queue = queueData[index];
                        return _buildQueueItem(
                          queue['name_qt'],
                          queue['name_tract'],
                          queue['phone'],
                          queue['acc_status'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

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
            _buildQueueItem('เกี่ยวข้าว', 'รถเกี่ยวข้าว Kubota', '082-555-9999',
                'สถานะทำงานเสร็จเรียบร้อย'),
          ],
        ),
      ),
    );
  }

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
                  'https://play-lh.googleusercontent.com/IawSyao8NWsYCE_o7GoN6PvngS_ev5wLhXb3XmqB0ijbq2GBZYK5Bu8sLppG2Yqhc3dE',
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
                    'เบอร์โทร $phone',
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
