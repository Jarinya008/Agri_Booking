import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ตัวแปรเก็บคำค้นหา
  String query = '';

  // รายการข้อมูลที่จะแสดงผล
  List<Map<String, String>> searchResults = [
    {
      'name': 'รถเกี่ยวข้าวนาปี/นาปรัง',
      'type': 'รถเกี่ยวข้าว',
      'address': 'ตำบลบ้านแท่น อำเภอบ้านแท่น จังหวัดชัยภูมิ',
      'price': '400 บาท/ไร่',
      'rating': '5.0',
      'distance': '15 กิโลเมตร',
      'image': 'assets/images/Logo.png',
    },
    // เพิ่มข้อมูลตัวอย่างที่เหลือ
  ];

  // ฟังก์ชันสำหรับค้นหาข้อมูล
  List<Map<String, String>> get filteredResults {
    return searchResults
        .where(
            (item) => item['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 214, 169), // สีพื้นหลัง
        title: const Text(
          'ค้นหา',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 244, 214, 169), // สีพื้นหลัง
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // ช่องค้นหา
            TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'พิมพ์คำที่ต้องการค้นหา...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ผลลัพธ์การค้นหา',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: filteredResults.isEmpty
                  ? const Center(
                      child: Text('ไม่พบผลลัพธ์'),
                    )
                  : ListView.builder(
                      itemCount: filteredResults.length,
                      itemBuilder: (context, index) {
                        final result = filteredResults[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
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
                                    child: Image.asset(
                                      result['image']!,
                                      width: 80.0,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${result['name']}',
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'ประเภทรถ : ${result['type']}',
                                          style:
                                              const TextStyle(fontSize: 11.0),
                                        ),
                                        Text(
                                          'ที่อยู่ : ${result['address']}',
                                          style:
                                              const TextStyle(fontSize: 11.0),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'ราคา : ',
                                              style: TextStyle(fontSize: 11.0),
                                            ),
                                            Text(
                                              result['price']!,
                                              style: const TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'คะแนน : ${result['rating']}',
                                          style:
                                              const TextStyle(fontSize: 11.0),
                                        ),
                                        Text(
                                          'ระยะทาง : ${result['distance']}',
                                          style:
                                              const TextStyle(fontSize: 11.0),
                                        ),
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            width: 150.0,
                                            height: 35.0,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // ฟังก์ชันที่ทำงานเมื่อกดปุ่ม
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 46, 210, 51),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              child: const Text(
                                                'รายละเอียดเพิ่มเติม',
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Colors.white,
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
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ToobarC(),
    );
  }
}
