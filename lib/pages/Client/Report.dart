import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // ตัวแปรสำหรับเก็บข้อมูลที่เลือก
  String? selectedReportReason;

  // ฟังก์ชันสำหรับแสดงข้อความหลังจากยืนยัน
  void submitReport() {
    if (selectedReportReason != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('รายงานของคุณ'),
          content: Text('คุณได้เลือกเหตุผล: $selectedReportReason'),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      // ถ้ายังไม่ได้เลือกเหตุผล
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('แจ้งเตือน'),
          content: const Text('กรุณาเลือกเหตุผลก่อนยืนยันการรายงาน'),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      appBar: AppBar(
        title: const Text('รายงานรีวิว'),
        backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'โปรดเลือกเหตุผลที่คุณต้องการรายงานรีวิวนี้',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('ใช้คำไม่สุภาพ'),
              leading: Radio<String>(
                value: 'ใช้คำไม่สุภาพ',
                groupValue: selectedReportReason,
                onChanged: (String? value) {
                  setState(() {
                    selectedReportReason = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('รูปภาพหรือวิดีโอที่ไม่เหมาะสม'),
              leading: Radio<String>(
                value: 'รูปภาพหรือวิดีโอที่ไม่เหมาะสม',
                groupValue: selectedReportReason,
                onChanged: (String? value) {
                  setState(() {
                    selectedReportReason = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('การละเมิดลิขสิทธิ์ผู้อื่น'),
              leading: Radio<String>(
                value: 'การละเมิดลิขสิทธิ์ผู้อื่น',
                groupValue: selectedReportReason,
                onChanged: (String? value) {
                  setState(() {
                    selectedReportReason = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('ใช้ถ้อยคำที่เป็นการโจมตีส่วนบุคคล'),
              leading: Radio<String>(
                value: 'ใช้ถ้อยคำที่เป็นการโจมตีส่วนบุคคล',
                groupValue: selectedReportReason,
                onChanged: (String? value) {
                  setState(() {
                    selectedReportReason = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('ความคิดเห็นที่มีลักษณะหลอกลวงหรือเป็นสแปม'),
              leading: Radio<String>(
                value: 'ความคิดเห็นที่มีลักษณะหลอกลวงหรือเป็นสแปม',
                groupValue: selectedReportReason,
                onChanged: (String? value) {
                  setState(() {
                    selectedReportReason = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // สีพื้นหลังของปุ่มเป็นสีส้ม
                  foregroundColor: Colors.black, // สีตัวอักษรของปุ่มเป็นสีดำ
                  minimumSize: const Size(200,
                      50), // กำหนดขนาดขั้นต่ำของปุ่ม (กว้าง 200px, สูง 50px)
                ),
                child: const Text(
                  'ยืนยันการรายงานรีวิว',
                  style: TextStyle(
                    fontSize: 18, // กำหนดขนาดตัวอักษรที่ต้องการ
                    // fontWeight: FontWeight.bold, // ตัวอักษรหนา
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
