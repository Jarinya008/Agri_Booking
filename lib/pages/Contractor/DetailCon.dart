import 'package:app_agri_booking/pages/Client/Report.dart';
import 'package:app_agri_booking/pages/Contractor/EditCar.dart';
import 'package:flutter/material.dart';

class DetailConPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailConPage> {
  int _selectedTab = 0; // 0 = รีวิว, 1 = ตารางงาน

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
            image: const DecorationImage(
              image: NetworkImage(
                  'https://www.deere.co.th/assets/images/tractors/5-family-utility-tractors/5075e-utility-tractor/5075E_large_064fa3b6d52359673b2b6fd650d5ced239a8b9b6.jpg'), // ใช้ URL ของรูปภาพ
              fit: BoxFit.cover, // รูปภาพจะขยายให้เต็มพื้นที่
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ชื่อรถ: รถตัดอ้อยขนาดใหญ่ รุ่น CH570',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('จำนวนรถ: 5 คัน'),
                Text('ประเภท: รถตัด'),
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ชื่อผู้รับจ้าง: พ่อใหญ่บุญ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('ข้อมูลติดต่อ: เบอร์โทร 085-222-0000'),
              Text('ที่อยู่: ตำบลเมืองพล อำเภอเมืองพล จังหวัดขอนแก่น'),
              SizedBox(height: 6),
              Text(
                'รายละเอียดเพิ่มเติม: รับงานตัดอ้อยทุกพื้นที่ในประเทศไทย และรับงานตลอดฤดูกาล ยกเว้นวันน้ำขังดินชื้น',
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
          child: const Text(
            'ราคา 600 บาท/ไร่',
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
    return const Center(
      child: Text('ตารางงาน (ต้องเพิ่มข้อมูลตารางงานที่นี่)',
          style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
