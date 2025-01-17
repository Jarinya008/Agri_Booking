import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:app_agri_booking/pages/HomeUserAll.dart';
import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 69, 9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ส่วนบนของโปรไฟล์
            Container(
              width: double.infinity, // กำหนดความกว้างให้เต็มหน้าจอ
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color(0xFFFFC074),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
              ),
              child: const Column(
                children: [
                  // รูปภาพโปรไฟล์จาก URL
                  SizedBox(height: 55),
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4e9fWazRAThnhmWBrNW7gfn8E1vF8vtrtzY9iMHe_QZsjmC-gzxv-zMDMLvYaHW5cv9o&usqp=CAU',
                    ),
                  ),
                  SizedBox(height: 16),
                  // ชื่อและเบอร์โทร
                  Text(
                    'Jarinya',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '0822222222',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
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
                        },
                      ),
                      _buildMenuItem(
                        'แก้ไขข้อมูลไร่นา',
                        'https://img.freepik.com/premium-vector/edit-map-icon_933463-4534.jpg',
                        () {
                          // กดแล้วทำอะไร
                        },
                      ),
                      _buildMenuItem(
                        'ออกจากระบบ',
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR_OSwHRWaHZlUQ3AiRMMhf5Aqg9ZcnvBsBuUEbuAXu_jIESdvq',
                        () {
                          // กดแล้วทำอะไร

                          // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าผู้ใช้
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeUserAllPage()),
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
      bottomNavigationBar: const ToobarC(),
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
