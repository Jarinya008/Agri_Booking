import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_agri_booking/pages/General/SearchAll.dart';

class HomeUserAllPage extends StatefulWidget {
  const HomeUserAllPage({super.key});

  @override
  _HomeUserAllPageState createState() => _HomeUserAllPageState();
}

class _HomeUserAllPageState extends State<HomeUserAllPage> {
  final List<String> imageUrls = [
    'https://www.vervaet.nl/dbupload/_p34_hydro.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNHzaUcniTqXfWLOpa5HfWV_eTQAdBjHPNKg&s',
  ];

  // ข้อมูลจำลอง
  final List<Map<String, String>> mockTracts = [
    {
      'nameTract': 'รถไถนา KUBOTA',
      'typeNameTract': 'รถไถ',
      'address': 'เชียงใหม่, สันทราย',
      'price': '1,200 บาท/วัน',
      //ใช้ลิงก์รูปภาพ
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtJfaUNK9PiSt-r-_UrgEIEJwFJEqlHFP5Sg&s',
    },
    {
      'nameTract': 'รถเกี่ยวข้าว Yanmar',
      'typeNameTract': 'รถเกี่ยวข้าว',
      'address': 'นครราชสีมา, โชคชัย',
      'price': '2,000 บาท/วัน',
      //ใช้ลิงก์รูปภาพ
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtJfaUNK9PiSt-r-_UrgEIEJwFJEqlHFP5Sg&s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                'assets/images/Logo.png',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(fontSize: 14.0, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'ค้นหา :ชื่อรถ,ประเภทรถ,ราคา,จังหวัด,อำเภอ',
                  hintStyle:
                      const TextStyle(fontSize: 14.0, color: Colors.grey),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchAllPage(),
                        ),
                      );
                    },
                    child: const Icon(Icons.search),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 100.0,
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
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 8.0),
              child: Text(
                'รถที่ให้บริการ',
                style:
                    TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mockTracts.length,
              itemBuilder: (context, index) {
                final tract = mockTracts[index];
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              child: Image.network(
                                tract['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tract['nameTract']!,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'ประเภทรถ : ${tract['typeNameTract']}',
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                                Text(
                                  'ที่อยู่ : ${tract['address']}',
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'ราคา : ',
                                      style: TextStyle(fontSize: 11.0),
                                    ),
                                    Text(
                                      tract['price']!,
                                      style: const TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
