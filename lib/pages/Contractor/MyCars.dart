import 'package:app_agri_booking/pages/Contractor/AddCar.dart';
import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:flutter/material.dart';

class MyCars extends StatelessWidget {
  final Map<String, dynamic> userData;

  const MyCars({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (int result) {
              switch (result) {
                case 1:
                  break;
                case 2:
                  // ฟังก์ชันการสลับบัญชี

                  break;
                case 3:
                  // ฟังก์ชันออกจากระบบ
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Toobar(
                              value: 0,
                            )),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.black),
                    SizedBox(width: 10),
                    Text("แก้ไขข้อมูลส่วนตัว"),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.switch_account, color: Colors.black),
                    SizedBox(width: 10),
                    Text("สลับบัญชี"),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.black),
                    SizedBox(width: 10),
                    Text("ออกจากระบบ"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserProfile(),
              const SizedBox(height: 20),
              _buildMyCarsSection(context), // แสดงรายการรถ
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Card(
      color: Colors.orange[100],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), side: BorderSide.none),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/Logo.png'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['username'] ?? 'พ่อใหญ่บุญ',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('ที่อยู่: ${userData['address'] ?? 'ไม่ระบุ'}'),
                      Text(
                          'สอบถามรายละเอียดเพิ่มเติมติดต่อ: ${userData['phone'] ?? 'ไม่ระบุ'}'),
                      Text('E-mail: ${userData['email'] ?? 'ไม่ระบุ'}'),
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

  Widget _buildMyCarsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity, // ทำให้ความกว้างเต็มหน้าจอ
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: const Text(
              'รถของฉัน',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddCarPage()), // ไปที่หน้า AddCar
            );
          },
          child: const Text('เพิ่มรถ', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 10),
        _buildCarCard(
          imageUrl: 'assets/images/Logo.png',
          name: 'รถตัดอ้อยขนาดใหญ่ รุ่น CH570',
          type: 'รถตัด',
          location: 'ตำบลเมืองพล จังหวัดขอนแก่น',
          price: '400 บาท/ไร่',
          rating: '4.9',
          distance: '146 กิโลเมตร',
        ),
        _buildCarCard(
          imageUrl: 'assets/images/Logo.png',
          name: 'รถไถเดินตาม',
          type: 'รถไถ',
          location: 'ตำบลหลวงจิก อำเภอบรบือ จังหวัดมหาสารคาม',
          price: '400 บาท',
          rating: '4.4',
          distance: '',
        ),
      ],
    );
  }

  Widget _buildCarCard({
    required String imageUrl,
    required String name,
    required String type,
    required String location,
    required String price,
    required String rating,
    required String distance,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imageUrl,
                  height: 100, width: 90, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('ประเภท: $type'),
                  Text('ที่อยู่: $location'),
                  Text('ราคา: $price',
                      style: const TextStyle(color: Colors.green)),
                  if (distance.isNotEmpty) Text('ระยะทาง: $distance'),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {},
                        child: const Text('รายละเอียดเพิ่มเติม',
                            style:
                                TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {},
                        child: const Text('ลบ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
