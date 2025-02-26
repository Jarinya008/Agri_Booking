import 'package:app_agri_booking/pages/Client/EditUser.dart';
import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:app_agri_booking/pages/Farm.dart';
import 'package:app_agri_booking/pages/HomeUserAll.dart';
import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  final dynamic userData; // รับข้อมูลที่ส่งมา

  const MePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    print("เข้าสู่ระบบแล้วนะเย้ๆๆๆๆ");
    print(this.userData);
    print("----------------------------------------");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 153, 69, 9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // ส่งข้อมูล userData ไปยัง ToobarC
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ToobarC(value: 0, userData: userData), // ส่งข้อมูล
                  ),
                );
              },
              child: Container(
                width: double.infinity, // กำหนดความกว้างให้เต็มหน้าจอ
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC074),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                  ),
                ),
                child: Column(
                  children: [
                    // รูปภาพโปรไฟล์จาก URL
                    const SizedBox(height: 55),
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(
                        userData['profilePicture'] ??
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4e9fWazRAThnhmWBrNW7gfn8E1vF8vtrtzY9iMHe_QZsjmC-gzxv-zMDMLvYaHW5cv9o&usqp=CAU', // ใช้ URL จาก userData หรือ URL พื้นฐาน
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ชื่อและเบอร์โทร
                    Text(
                      userData['username'] ??
                          'ไม่มีชื่อ', // ใช้ข้อมูลจาก userData
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userData['phone'] ??
                          'ไม่มีเบอร์โทร', // ใช้ข้อมูลจาก userData
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
            // กล่องเมนูตรงกลาง
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'ผู้จ้าง',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // ไอคอนเมนู
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.5,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildMenuItem(
                        'แก้ไขข้อมูลส่วนตัว',
                        'https://cdn-icons-png.flaticon.com/512/10629/10629723.png',
                        () {
                          // กดแล้วทำอะไร
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditUser(userData: userData)),
                          );
                        },
                      ),
                      _buildMenuItem(
                        'แก้ไขข้อมูลไร่นา',
                        'https://img.freepik.com/premium-vector/edit-map-icon_933463-4534.jpg',
                        () {
                          // กดแล้วทำอะไร
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FarmListPage(mid: userData['mid'])),
                          );
                        },
                      ),
                      _buildMenuItem(
                        'ออกจากระบบ',
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR_OSwHRWaHZlUQ3AiRMMhf5Aqg9ZcnvBsBuUEbuAXu_jIESdvq',
                        () {
                          // กดแล้วทำอะไร
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Toobar(
                                      value: 0,
                                    )),
                          );
                        },
                      ),
                      _buildMenuItem(
                        'สลับโหมดผู้ใช้',
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQDkOOsZmX7Xxaf5NerCTSNekJcBHyzzBB6MtPI2KotTJSzLaPx',
                        () {
                          // กดแล้วทำอะไร
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // เพิ่ม ToobarC ที่ด้านล่างของหน้า
    );
  }

  Widget _buildMenuItem(String title, String imageUrl, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            height: 60, // ขนาดของไอคอน
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
