import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeUserAllPage extends StatelessWidget {
  const HomeUserAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ลิงก์ของรูปภาพ
    final List<String> imageUrls = [
      'https://www.vervaet.nl/dbupload/_p34_hydro.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNHzaUcniTqXfWLOpa5HfWV_eTQAdBjHPNKg&s',
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 214, 169), // สีพื้นหลัง
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                'assets/images/Logo.png', // ใส่โลโก้ของคุณใน assets
                fit: BoxFit.contain,
              ),
            ),
            // Search field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'ค้นหา :ชื่อรถ,ประเภทรถ,ราคา,จังหวัด,อำเภอ',
                  hintStyle: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Slideshow
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 100.0, // ความสูงของ Carousel
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: imageUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(
                  left: 25.0, top: 8.0), // ปรับระยะห่างจากด้านซ้ายและด้านบน
              child: Text(
                'รถที่ให้บริการ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5, // ระยะห่างระหว่างบรรทัด
                ),
              ),
            ),

            // Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // รูปภาพด้านซ้าย
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/images/Logo.png', // เปลี่ยนเป็น path รูปภาพของคุณ
                          width: 100.0,
                          //   height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16.0), // ระยะห่าง
                      // ข้อมูลทางขวา
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ชื่อรถ : รถเกี่ยวข้าวนาปี/นาปรัง',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'ประเภทรถ : รถเกี่ยวข้าว',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'ที่อยู่ : ตำบลบ้านแท่น อำเภอบ้านแท่น\nจังหวัดชัยภูมิ',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(height: 8.0),
                            const Row(
                              children: [
                                Text(
                                  'ราคา : ',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  '400 บาท/ไร่',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'คะแนน : 5.0',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'ระยะทาง : 15 กิโลเมตร',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(height: 16.0),
                            // ปุ่ม
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  // ไปหน้ารายละเอียดเพิ่มเติม
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailPage(), // ระบุหน้าปลายทาง
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text('รายละเอียดเพิ่มเติม'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Toobar(),
    );
  }
}

// หน้ารายละเอียดเพิ่มเติม
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียดเพิ่มเติม')),
      body: const Center(
        child: Text('นี่คือหน้ารายละเอียดเพิ่มเติม'),
      ),
    );
  }
}
