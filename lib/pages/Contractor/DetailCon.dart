import 'dart:convert';

import 'package:app_agri_booking/pages/Client/Report.dart';
import 'package:app_agri_booking/pages/Contractor/EditCar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailConPage extends StatefulWidget {
  final int tid;
  final int mid;
  DetailConPage({super.key, required this.tid, required this.mid});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailConPage> {
  int _selectedTab = 0; // 0 = รีวิว, 1 = ตารางงาน
  Map<String, dynamic> tractData = {}; // เก็บข้อมูลจาก API
  Map<String, dynamic> queueData = {}; // เก็บข้อมูลจาก API
  bool isLoading = true; // เช็คสถานะโหลดข้อมูล
  String? errorMessage; // ข้อความ error

  @override
  void initState() {
    super.initState();
    print(widget.tid);
    print(widget.mid);
    fetchTractDetails();
    fetchQueueDetails();
  }

  Future<void> fetchQueueDetails() async {
    final url = Uri.parse(
        "http://projectnodejs.thammadalok.com/AGribooking/contractor/myqueue/${widget.mid}");

    print("กำลังดึงข้อมูลจาก: $url"); // ✅ เช็ก URL
    print("MID ที่ส่งไป: ${widget.mid}"); // ✅ เช็กค่าที่ส่งไป

    try {
      final response = await http.get(url);

      print("Response Code: ${response.statusCode}"); // ✅ ดูว่าตอบ 200 ไหม
      print(
          "Response Body: ${response.body}"); // ✅ ดูว่า API ส่งข้อมูลอะไรกลับมา

      if (response.statusCode == 200) {
        setState(() {
          queueData = json.decode(response.body);
          print("queueData: $queueData"); // ✅ เช็กโครงสร้าง JSON
        });
      } else {
        setState(() {
          errorMessage = "ไม่พบข้อมูล หรือเกิดข้อผิดพลาด";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "เกิดข้อผิดพลาด: $e";
      });
    }
  }

  Future<void> fetchTractDetails() async {
    final url = Uri.parse(
        "http://projectnodejs.thammadalok.com/AGribooking/detail/tract?tid=${widget.tid}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          tractData = json.decode(response.body);
          print("\n\n\n");
          print(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "ไม่พบข้อมูล หรือเกิดข้อผิดพลาด";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "เกิดข้อผิดพลาด: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 214, 169), // สีพื้นหลัง
      appBar: AppBar(
        title: const Text('รายละเอียดเพิ่มเติม'),
        backgroundColor: const Color.fromARGB(255, 255, 179, 64),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // เพิ่ม padding รอบ ๆ หน้า
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // ทำให้ทุกอย่างเรียงทางซ้าย
            children: [
              // ข้อมูลรถและผู้ให้บริการ
              _buildDetailsSection(),

              const SizedBox(height: 20), // ระยะห่างระหว่างส่วนต่างๆ

              // ปุ่มสลับแท็บ รีวิว / ตารางงาน
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton('รีวิว', 0),
                  const SizedBox(width: 10),
                  _buildTabButton('ตารางงาน', 1),
                ],
              ),

              const SizedBox(height: 20), // ระยะห่างหลังปุ่ม

              // เนื้อหาของแต่ละแท็บ
              if (_selectedTab == 0) _buildReviews(),
              if (_selectedTab == 1) _buildSchedule(),

              const SizedBox(height: 20), // ระยะห่างหลังเนื้อหา
            ],
          ),
        ),
      ),
    );
  }

  // ส่วนแสดงข้อมูลรถและผู้ให้บริการ
  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // รูปรถ (เต็มความยาวหน้าจอ)
        Container(
          width: double.infinity, // กำหนดให้รูปเต็มความกว้างของหน้าจอ
          height: 200, // กำหนดความสูงของรูป
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(
                tractData['tract_image'] != null &&
                        tractData['tract_image'] != ''
                    ? tractData['tract_image']
                    : 'https://www.forest.go.th/training/wp-content/uploads/sites/17/2015/03/noimages.png', // ใช้ภาพดีฟอลต์เมื่อไม่มี URL
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 10),
        // ปุ่มดูโปรไฟล์เจ้าของรถ
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditCarPage(),
                ),
              );
            },
            child: const Text('แก้ไขข้อมูลรถ'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade300, // สีพื้นหลัง
              foregroundColor: Colors.white, // ตัวหนังสือสีขาว
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 20), // ปรับขนาดปุ่ม
              textStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // ข้อมูลรถ (เพิ่มกรอบ)
        Center(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade200, // สีพื้นหลังอ่อน ๆ
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromARGB(255, 220, 145, 15),
                width: 1, // เส้นกรอบ
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ชื่อรถ: ${tractData['name_tract'] ?? 'ไม่มีข้อมูล'}', // แสดงชื่อรถ
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('จำนวนรถ: ${tractData['amount'] ?? 0}คัน'),
                Text(
                    'ประเภท: ${tractData['type_name_tract'] != null && tractData['type_name_tract'].isNotEmpty ? tractData['type_name_tract'][0] : 'ไม่มีข้อมูล'}'),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // ข้อมูลผู้รับจ้าง
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ชื่อผู้รับจ้าง:  ${tractData['username'] ?? 'ไม่มีข้อมูล'}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('ข้อมูลติดต่อ:  ${tractData['contact'] ?? 'ไม่มีข้อมูล'}'),
              Text('ที่อยู่: ${tractData['address'] ?? 'ไม่มีข้อมูล'}'),
              SizedBox(height: 6),
              Text(
                'รายละเอียดเพิ่มเติม:  ${tractData['description'] ?? 'ไม่มีข้อมูล'}',
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // ราคา
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 41, 200, 49)
                  //borderRadius: BorderRadius.circular(8),
                  ),
          child: Text(
            'ราคา  ${tractData['price'] ?? 'ไม่มีข้อมูล'}',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String text, int index) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedTab == index ? Colors.purple : Colors.grey.shade300,
          foregroundColor: _selectedTab == index ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

//หน้ารีวิว
  void _reportReview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportPage()),
    );
  }

  Widget _buildReviews() {
    return Column(
      children: [
        _buildReviewItem(
          'ผู้รับจ้างทำงานดีมาก กำลังทำงานไว แต่หักคะแนนเพราะมาสาย 10 นาที',
          4,
          'https://i.ytimg.com/vi/IAP7JY7H0Qw/maxresdefault.jpg',
          '2025-03-11',
          (context) =>
              _reportReview(context), // ส่งฟังก์ชันไปที่ _buildReviewItem
        ),
        _buildReviewItem(
          'ใช้งานง่ายและสะดวก',
          5,
          'https://itp1.itopfile.com/ImageServer/d470d8876d08f5d2/0/0/iTopPlus949740413461.jpg',
          '2025-03-10',
          (context) =>
              _reportReview(context), // ส่งฟังก์ชันไปที่ _buildReviewItem
        ),
      ],
    );
  }

  Widget _buildReviewItem(String comment, int rating, String imageUrl,
      String date, Function(BuildContext) onReport) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < rating ? Colors.amber : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(comment),
            const SizedBox(height: 8),
            imageUrl.isNotEmpty
                ? Image.network(imageUrl) // แสดงภาพจากลิงก์
                : const SizedBox.shrink(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date, // แสดงวันที่รีวิว
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () =>
                      onReport(context), // เมื่อกดจะไปที่หน้ารายงาน
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // สีพื้นหลังของปุ่ม
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    shape: const RoundedRectangleBorder(
                      // กำหนดให้เป็นปุ่มสี่เหลี่ยม
                      borderRadius: BorderRadius.zero, // ปรับมุมให้เป็นมุมตรง
                    ),
                    side: const BorderSide(color: Colors.red), // ขอบปุ่มสีแดง
                  ),
                  child: const Row(
                    mainAxisSize:
                        MainAxisSize.min, // ทำให้ขนาดของ Row พอดีกับเนื้อหา
                    children: [
                      Icon(
                        Icons.report, // ไอคอนรายงาน
                        color: Colors.red, // สีของไอคอนเป็นสีแดง
                        size: 20, // ขนาดของไอคอน
                      ),
                      SizedBox(width: 5), // เว้นระยะระหว่างไอคอนและข้อความ
                      Text(
                        'รายงานรีวิว',
                        style: TextStyle(
                          color: Colors.red, // สีข้อความเป็นสีแดง
                          fontSize: 14, // ขนาดฟอนต์
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//หน้าตารางงาน
  Widget _buildSchedule() {
    return queueData.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true, // ให้ขนาดพอดีกับเนื้อหา
            physics: const NeverScrollableScrollPhysics(), // ปิดสกรอล์ซ้อนกัน
            itemCount: queueData.length,
            itemBuilder: (context, index) {
              final queue = queueData[index]; // ดึงข้อมูลแต่ละรายการ
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ชื่อคิว: ${queue['name_qt']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("วันที่เริ่มงาน: ${queue['date_start']}"),
                      Text("วันที่สิ้นสุด: ${queue['date_end']}"),
                      Text("รายละเอียด: ${queue['detail_qt']}"),
                      Text("จำนวนที่จอง: ${queue['amount_qt']}"),
                      Text("สถานะคิว: ${queue['acc_status']}"),
                      Text("สถานะดำเนินงาน: ${queue['ope_status']}"),
                    ],
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text(
              'ยังไม่มีการจองคิวรถ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
