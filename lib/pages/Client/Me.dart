import 'package:app_agri_booking/pages/Client/EditUser.dart';
import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:app_agri_booking/pages/Contractor/Home.dart';
import 'package:app_agri_booking/pages/General/Farm.dart';
import 'package:app_agri_booking/pages/General/Toobar.dart';
import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 240, 194),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ToobarC(
                            value: 0,
                            userData: null,
                          )),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC074),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                  ),
                ),
                child: Column(
                  children: const [
                    SizedBox(height: 55),
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'นายตัวอย่าง เกษตร',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0987654321',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
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
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.5,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildMenuItem(
                        title: 'แก้ไขข้อมูลส่วนตัว',
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/512/10629/10629723.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUser(),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        title: 'แก้ไขข้อมูลไร่นา',
                        imageUrl:
                            'https://img.freepik.com/premium-vector/edit-map-icon_933463-4534.jpg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FarmListPage(
                                mid: 1,
                              ),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        title: 'ออกจากระบบ',
                        imageUrl:
                            'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR_OSwHRWaHZlUQ3AiRMMhf5Aqg9ZcnvBsBuUEbuAXu_jIESdvq',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Toobar(value: 0)),
                          );
                        },
                      ),
                      _buildMenuItem(
                        title: 'สลับโหมดผู้ใช้',
                        imageUrl:
                            'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQDkOOsZmX7Xxaf5NerCTSNekJcBHyzzBB6MtPI2KotTJSzLaPx',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeContractorPage(),
                            ),
                          ); // ยังไม่ระบุการกระทำ
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
    );
  }

  Widget _buildMenuItem({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, height: 60),
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
