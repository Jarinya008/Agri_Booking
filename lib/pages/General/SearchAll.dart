import 'package:app_agri_booking/pages/General/Toobar.dart';
import 'package:flutter/material.dart';

class SearchAllPage extends StatefulWidget {
  const SearchAllPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchAllPage> {
  String query = '';
  String selectedType = 'ประเภท'; // ประกาศตัวแปร selectedType
  String selectedTypeFarm = 'ที่นา';

  bool isDistanceAscending = true;
  bool isPriceAscending = true;
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
  ];
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
        backgroundColor: const Color.fromARGB(255, 244, 214, 169),
        title: const Text(
          'ค้นหา',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ช่องค้นหา
              Row(
                children: [
                  // ช่องค้นหา
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'พิมพ์คำที่ต้องการค้นหา...',
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 13.0),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              //Search menu
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // เปิดการเลื่อนในแนวนอน
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9BF75),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // จัดเรียงปุ่ม
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // จัดแนวให้อยู่ตรงกลางในแนวตั้ง
                    children: [
                      // ปุ่ม "เกี่ยวข้อง"
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          'เกี่ยวข้อง',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // เครื่องหมาย |
                      const Text('|',
                          style: TextStyle(
                            fontSize: 1,
                          )),
                      //ประเภท
                      const Text('|', style: TextStyle(fontSize: 18)),
                      // ปุ่ม "ประเภทรถ"
                      ElevatedButton(
                        onPressed: () {
                          // แสดงป๊อบอัพเมื่อกดปุ่ม
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: const Text('รถไถ'),
                                      onTap: () {
                                        setState(() {
                                          selectedType = 'รถไถ';
                                        });
                                        Navigator.pop(
                                            context); // ปิดป๊อบอัพหลังจากเลือก
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('รถแทรกเตอร์'),
                                      onTap: () {
                                        setState(() {
                                          selectedType = 'รถแทรกเตอร์';
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('รถขุด'),
                                      onTap: () {
                                        setState(() {
                                          selectedType = 'รถขุด';
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('รถเกี่ยวข้าว'),
                                      onTap: () {
                                        setState(() {
                                          selectedType = 'รถเกี่ยวข้าว';
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('รถดำนา'),
                                      onTap: () {
                                        setState(() {
                                          selectedType = 'รถดำนา';
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('รถตัด'),
                                      onTap: () {
                                        setState(() {
                                          selectedType = 'รถตัด';
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: Text(
                          selectedType, // ใช้ค่า selectedType แสดงในปุ่ม
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // เพิ่มระยะห่างเพิ่มเติมถ้าจำเป็น

                      // เครื่องหมาย |
                      const Text('|', style: TextStyle(fontSize: 18)),
                      // ปุ่ม "ระยะทาง"
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isDistanceAscending = !isDistanceAscending;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                        child: Text(
                          'ระยะทาง ${isDistanceAscending ? '↑' : '↓'}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // เครื่องหมาย |
                      const Text('|',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      // ปุ่ม "ราคา"
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isPriceAscending = !isPriceAscending;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                        ),
                        child: Text(
                          'ราคา ${isPriceAscending ? '↑' : '↓'}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const Text(
                '  ผลลัพธ์การค้นหา',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // รายการผลลัพธ์
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredResults.length,
                itemBuilder: (context, index) {
                  final result = filteredResults[index];
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${result['name']}',
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'ประเภทรถ : ${result['type']}',
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                                Text(
                                  'ที่อยู่ : ${result['address']}',
                                  style: const TextStyle(fontSize: 11.0),
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
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
