import 'package:app_agri_booking/pages/Client/QueueCar.dart';
import 'package:app_agri_booking/pages/Client/Report.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final int mid;
  final int tid;
  final int fid;

  DetailsPage({
    super.key,
    required this.tid,
    required this.mid,
    required this.fid,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _selectedTab = 0;

  // Mock data แทน API
  Map<String, dynamic> tractData = {
    'tract_image':
        'https://cdn.pixabay.com/photo/2016/07/12/23/44/tractor-1513858_960_720.jpg',
    'name_tract': 'รถแทรกเตอร์ A',
    'amount': 3,
    'type_name_tract': ['แทรกเตอร์'],
    'username': 'สมชาย คนดี',
    'contact': '081-234-5678',
    'address': '123 หมู่บ้านเกษตร ตำบลบางเขน อำเภอบางเขน',
    'description': 'เหมาะสำหรับงานนาและงานขุดดินหนัก',
    'price': '1,200 บาท/วัน',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      appBar: AppBar(
        title: const Text('รายละเอียดเพิ่มเติม'),
        backgroundColor: const Color.fromARGB(255, 255, 179, 64),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailsSection(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton('รีวิว', 0),
                const SizedBox(width: 10),
                _buildTabButton('ตารางงาน', 1),
              ],
            ),
            const SizedBox(height: 20),
            _selectedTab == 0 ? _buildReviews() : _buildSchedule(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QueueCarScreen(
                  tractData: tractData,
                  mid: widget.mid,
                  fid: widget.fid,
                ),
              ),
            );
          },
          child: const Text('จองคิวรถ', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(
                tractData['tract_image'] ??
                    'https://www.forest.go.th/training/wp-content/uploads/sites/17/2015/03/noimages.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ชื่อรถ: ${tractData['name_tract'] ?? '-'}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('จำนวนรถ: ${tractData['amount'] ?? '-'} คัน'),
                Text('ประเภท: ${tractData['type_name_tract'][0] ?? '-'}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ชื่อผู้รับจ้าง: ${tractData['username'] ?? '-'}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('ข้อมูลติดต่อ: ${tractData['contact'] ?? '-'}'),
              Text('ที่อยู่: ${tractData['address'] ?? '-'}'),
              const SizedBox(height: 6),
              Text('รายละเอียดเพิ่มเติม: ${tractData['description'] ?? '-'}'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          color: const Color.fromARGB(255, 41, 200, 49),
          child: Text(
            'ราคา ${tractData['price'] ?? '-'}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
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
          _reportReview,
        ),
        _buildReviewItem(
          'ใช้งานง่ายและสะดวก',
          5,
          'https://itp1.itopfile.com/ImageServer/d470d8876d08f5d2/0/0/iTopPlus949740413461.jpg',
          '2025-03-10',
          _reportReview,
        ),
      ],
    );
  }

  Widget _buildReviewItem(String comment, int rating, String imageUrl,
      String date, Function(BuildContext) onReport) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Image.network(imageUrl),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ElevatedButton(
                  onPressed: () => onReport(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.red),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.report, color: Colors.red, size: 20),
                      SizedBox(width: 5),
                      Text('รายงานรีวิว',
                          style: TextStyle(color: Colors.red, fontSize: 14)),
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

  Widget _buildSchedule() {
    return const Center(
      child: Text('ตารางงาน (ข้อมูลจำลอง)',
          style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
