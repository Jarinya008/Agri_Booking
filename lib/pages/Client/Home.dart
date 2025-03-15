import 'dart:convert';
import 'package:app_agri_booking/config.dart';
import 'package:app_agri_booking/model/GetAllTracts.dart';
import 'package:app_agri_booking/pages/Client/Detail.dart';
import 'package:app_agri_booking/pages/Client/Search.dart';
import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeClientPage extends StatelessWidget {
  final dynamic userData; // รับข้อมูลที่ส่งมา

  const HomeClientPage({super.key, required this.userData});

  // Function to fetch data from the API
  Future<List<GetAllTracts>> fetchData() async {
    final response = await http.get(Uri.parse(ApiConfig.getAllTractsList));

    if (response.statusCode == 200) {
      return getAllTractsFromJson(
          response.body); // ใช้ฟังก์ชันที่แปลงข้อมูล JSON
    } else {
      throw Exception('Failed to load data');
    }
  }

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
                  prefixIcon: GestureDetector(
                    onTap: () {
                      // เมื่อกดที่ไอคอนค้นหา
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                              mid: userData['mid'],
                              userData: {}), // ไปยังหน้า SearchPage
                        ),
                      );
                    },
                    child: const Icon(Icons.search), // ไอคอนค้นหาที่กดได้
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  // เมื่อกด Enter หลังจากพิมพ์ข้อความ
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                          mid: userData['mid'],
                          userData: {}), // ไปยังหน้า SearchPage พร้อมส่งค่าคำค้นหา
                    ),
                  );
                },
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

            // FutureBuilder to load the tracts data
            FutureBuilder<List<GetAllTracts>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  // Data loaded successfully, build the list of cards
                  List<GetAllTracts> tracts = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tracts.length,
                    itemBuilder: (context, index) {
                      final tract = tracts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
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
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16.0), // ระยะห่าง
                                // ข้อมูลทางขวา
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tract.nameTract,
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'ประเภทรถ : ${tract.typeNameTract}',
                                        style: const TextStyle(fontSize: 11.0),
                                      ),
                                      Text(
                                        'ที่อยู่ : ${tract.address}',
                                        style: const TextStyle(fontSize: 11.0),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'ราคา : ',
                                            style: TextStyle(fontSize: 11.0),
                                          ),
                                          Text(
                                            tract.price,
                                            style: const TextStyle(
                                              fontSize: 11.0,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'คะแนน : ${tract.rate}',
                                        style: const TextStyle(fontSize: 11.0),
                                      ),
                                      Text(
                                        'ระยะทาง : 50 กิโลเมตร', // Example for distance
                                        style: const TextStyle(fontSize: 11.0),
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          width:
                                              150.0, // กำหนดความกว้างที่ต้องการ
                                          height:
                                              35.0, // กำหนดความสูงที่ต้องการ
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // ฟังก์ชันที่ทำงานเมื่อกดปุ่ม
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(), // เปลี่ยนเป็นหน้าที่ต้องการ
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 46, 210, 51),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0), // มุมโค้ง
                                              ),
                                            ),
                                            child: const Text(
                                              'รายละเอียดเพิ่มเติม',
                                              style: TextStyle(
                                                fontSize: 11.0,
                                                color: Colors
                                                    .white, // ใช้สีขาวสำหรับตัวอักษร
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
      //bottomNavigationBar: ToobarC(),
    );
  }
}
