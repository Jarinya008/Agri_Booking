import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_agri_booking/pages/Client/Detail.dart';
import 'package:app_agri_booking/pages/Client/Search.dart';

class HomeClientPage extends StatefulWidget {
  final dynamic userData;

  const HomeClientPage({Key? key, required this.userData}) : super(key: key);

  @override
  _HomeClientPageState createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  int? selectedFarmId;

  final List<Map<String, dynamic>> mockFarms = [
    {'fid': 1, 'name_farm': 'ไร่ทดสอบ A'},
    {'fid': 2, 'name_farm': 'สวนมะม่วง B'},
  ];

  final List<Map<String, String>> mockTracts = [
    {
      'tid': '101',
      'name': 'รถไถคูโบต้า',
      'type': 'ไถพรวน',
      'address': 'อุบลราชธานี',
      'price': '1500',
      'image': 'https://www.vervaet.nl/dbupload/_p34_hydro.jpg'
    },
    {
      'tid': '102',
      'name': 'รถเกี่ยวนวดข้าว',
      'type': 'เก็บเกี่ยว',
      'address': 'ขอนแก่น',
      'price': '2500',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNHzaUcniTqXfWLOpa5HfWV_eTQAdBjHPNKg&s'
    },
  ];

  final List<String> imageUrls = [
    'https://www.vervaet.nl/dbupload/_p34_hydro.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNHzaUcniTqXfWLOpa5HfWV_eTQAdBjHPNKg&s',
  ];

  @override
  void initState() {
    super.initState();
    selectedFarmId = mockFarms.first['fid']; // ตั้งค่าไร่เริ่มต้น
  }

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

            // 🔍 ช่องค้นหา
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ค้นหา :ชื่อรถ,ประเภทรถ,ราคา,จังหวัด,อำเภอ',
                  prefixIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                              mid: widget.userData['mid'],
                              userData: widget.userData),
                        ),
                      );
                    },
                    child: const Icon(Icons.search),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                          mid: widget.userData['mid'],
                          userData: widget.userData),
                    ),
                  );
                },
              ),
            ),

            // 📸 รูปสไลด์
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 100,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: imageUrls.map((url) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(url), fit: BoxFit.cover),
                    ),
                  );
                }).toList(),
              ),
            ),

            // 🌾 เลือกไร่นา
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField<int>(
                value: selectedFarmId,
                decoration: const InputDecoration(
                  labelText: 'เลือกไร่นาของคุณ',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: mockFarms.map((farm) {
                  return DropdownMenuItem<int>(
                    value: farm['fid'],
                    child: Text(farm['name_farm']),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedFarmId = newValue;
                  });
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 16),
              child: Text(
                'รถที่ให้บริการ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // 🚜 รายการรถ
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockTracts.length,
              itemBuilder: (context, index) {
                final tract = mockTracts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              tract['image']!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tract['name']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text("ประเภทรถ : ${tract['type']}"),
                                Text("ที่อยู่ : ${tract['address']}"),
                                Text("ราคา : ${tract['price']} บาท",
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 150,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                              tid: 1,
                                              mid: 1,
                                              fid: 1,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2ED233),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: const Text(
                                        'รายละเอียดเพิ่มเติม',
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
