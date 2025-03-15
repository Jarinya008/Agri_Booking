// import 'package:app_agri_booking/pages/Contractor/AddCar.dart';
// import 'package:app_agri_booking/pages/Toobar.dart';
// import 'package:flutter/material.dart';

// class MyCars extends StatelessWidget {
//   final Map<String, dynamic> userData;

//   const MyCars({super.key, required this.userData});

//   @override
//   Widget build(BuildContext context) {
//     print("เข้าสู่ระบบของผู้จ้างแล้วนะเย้ๆๆๆๆ");
//     print(this.userData);
//     return Scaffold(
//       backgroundColor: Colors.orange[100],
//       appBar: AppBar(
//         backgroundColor: Colors.orange[100],
//         elevation: 0,
//         actions: [
//           PopupMenuButton<int>(
//             icon: const Icon(Icons.more_vert, color: Colors.black),
//             onSelected: (int result) {
//               switch (result) {
//                 case 1:
//                   break;
//                 case 2:
//                   // ฟังก์ชันการสลับบัญชี

//                   break;
//                 case 3:
//                   // ฟังก์ชันออกจากระบบ
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const Toobar(
//                               value: 0,
//                             )),
//                   );
//                   break;
//               }
//             },
//             itemBuilder: (BuildContext context) => [
//               const PopupMenuItem<int>(
//                 value: 1,
//                 child: Row(
//                   children: [
//                     Icon(Icons.edit, color: Colors.black),
//                     SizedBox(width: 10),
//                     Text("แก้ไขข้อมูลส่วนตัว"),
//                   ],
//                 ),
//               ),
//               const PopupMenuItem<int>(
//                 value: 2,
//                 child: Row(
//                   children: [
//                     Icon(Icons.switch_account, color: Colors.black),
//                     SizedBox(width: 10),
//                     Text("สลับบัญชี"),
//                   ],
//                 ),
//               ),
//               const PopupMenuItem<int>(
//                 value: 3,
//                 child: Row(
//                   children: [
//                     Icon(Icons.exit_to_app, color: Colors.black),
//                     SizedBox(width: 10),
//                     Text("ออกจากระบบ"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildUserProfile(),
//               const SizedBox(height: 20),
//               _buildMyCarsSection(context), // แสดงรายการรถ
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserProfile() {
//     return Card(
//       color: Colors.orange[100],
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10), side: BorderSide.none),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/images/Logo.png'),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         userData['username'] ?? '',
//                         style: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       Text('ที่อยู่: ${userData['address'] ?? 'ไม่ระบุ'}'),
//                       Text(
//                           'สอบถามรายละเอียดเพิ่มเติมติดต่อ: ${userData['phone'] ?? 'ไม่ระบุ'}'),
//                       Text('E-mail: ${userData['email'] ?? 'ไม่ระบุ'}'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMyCarsSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: double.infinity, // ทำให้ความกว้างเต็มหน้าจอ
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Center(
//             child: const Text(
//               'รถของฉัน',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AddCarPage(
//                     usermid: userData['mid']), // ส่ง usermid เป็น int
//               ),
//             );
//           },
//           child: const Text('เพิ่มรถ', style: TextStyle(color: Colors.white)),
//         ),
//         const SizedBox(height: 10),
//         _buildCarCard(
//           imageUrl: 'assets/images/Logo.png',
//           name: 'รถตัดอ้อยขนาดใหญ่ รุ่น CH570',
//           type: 'รถตัด',
//           location: 'ตำบลเมืองพล จังหวัดขอนแก่น',
//           price: '400 บาท/ไร่',
//           rating: '4.9',
//           distance: '146 กิโลเมตร',
//         ),
//         _buildCarCard(
//           imageUrl: 'assets/images/Logo.png',
//           name: 'รถไถเดินตาม',
//           type: 'รถไถ',
//           location: 'ตำบลหลวงจิก อำเภอบรบือ จังหวัดมหาสารคาม',
//           price: '400 บาท',
//           rating: '4.4',
//           distance: '',
//         ),
//       ],
//     );
//   }

//   Widget _buildCarCard({
//     required String imageUrl,
//     required String name,
//     required String type,
//     required String location,
//     required String price,
//     required String rating,
//     required String distance,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset(imageUrl,
//                   height: 100, width: 90, fit: BoxFit.cover),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(name,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 16)),
//                   Text('ประเภท: $type'),
//                   Text('ที่อยู่: $location'),
//                   Text('ราคา: $price',
//                       style: const TextStyle(color: Colors.green)),
//                   if (distance.isNotEmpty) Text('ระยะทาง: $distance'),
//                   const SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green),
//                         onPressed: () {},
//                         child: const Text('รายละเอียดเพิ่มเติม',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 11)),
//                       ),
//                       const SizedBox(width: 5),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red),
//                         onPressed: () {},
//                         child: const Text('ลบ',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 11)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:app_agri_booking/pages/Client/EditUser.dart';
import 'package:app_agri_booking/pages/Contractor/DetailCon.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:app_agri_booking/pages/Contractor/AddCar.dart';
import 'package:app_agri_booking/pages/General/Toobar.dart';

class MyCars extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MyCars({super.key, required this.userData});

  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  List<dynamic> _carsData = []; // Initialize as an empty list
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCarsData();
  }

  Future<void> _fetchCarsData() async {
    final url =
        'http://projectnodejs.thammadalok.com/AGribooking/contractor/tracts?mid=${widget.userData['mid']}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _carsData = data;
          _isLoading = false;
        });
        print(response.body);
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $error');
    }

    print(widget.userData);
    print(widget.userData['mid']);
  }

  // Future<void> _deleteCar(String tid) async {
  //   final url =
  //       'hhttp://projectnodejs.thammadalok.com/AGribooking/contractor/delete/tract?tid=$tid'; // ส่ง tid ไปใน URL
  //   try {
  //     final response = await http.delete(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       print('Car deleted successfully');
  //       _fetchCarsData(); // รีเฟรชข้อมูลรถหลังจากลบ
  //     } else {
  //       print('Failed to delete car: ${response.body}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }

  Future<void> _deleteCar(String tid) async {
    // แสดง Dialog เพื่อยืนยันการลบ
    bool? isConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการลบ'),
          content: const Text('คุณต้องการลบรถคันนี้ใช่หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // กดยกเลิก
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // กดยืนยัน
              },
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );

    if (isConfirmed == true) {
      // ถ้ายืนยันการลบ
      final url =
          'http://projectnodejs.thammadalok.com/AGribooking/contractor/delete/tract?tid=$tid'; // ส่ง tid ไปใน URL
      try {
        final response = await http.delete(Uri.parse(url));

        if (response.statusCode == 200) {
          print('Car deleted successfully');
          print(response.body);
          // รีเฟรชข้อมูลหลังจากลบสำเร็จ
          setState(() {
            _fetchCarsData(); // เรียกใช้ฟังก์ชันเพื่อดึงข้อมูลใหม่
          });
        } else {
          print('Failed to delete car: ${response.body}');
        }
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print('Car deletion cancelled');
    }
  }

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
                  // Navigate to EditUser page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditUser(userData: widget.userData), // Pass userData
                    ),
                  );
                  break;
                case 2:
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Toobar(value: 0)),
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
              _buildMyCarsSection(context),
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
                CircleAvatar(
                  radius: 50,
                  backgroundImage: widget.userData['image'] != null
                      ? NetworkImage(widget.userData['image'])
                      : const AssetImage('assets/images/Logo.png')
                          as ImageProvider,
                  onBackgroundImageError: (_, __) {
                    // ถ้าภาพโหลดไม่ได้ ให้ใช้รูป fallback (ต้องใช้ SetState ถ้าจะให้เปลี่ยนรูป)
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userData['username'] ?? '',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'ที่อยู่: ${widget.userData['address'] ?? 'ไม่ระบุ'}'),
                      Text(
                          'สอบถามรายละเอียดเพิ่มเติมติดต่อ: ${widget.userData['phone'] ?? 'ไม่ระบุ'}'),
                      Text('E-mail: ${widget.userData['email'] ?? 'ไม่ระบุ'}'),
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
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
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
                builder: (context) =>
                    AddCarPage(usermid: widget.userData['mid']),
              ),
            );
          },
          child: const Text('เพิ่มรถ', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 10),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _carsData.isEmpty
                ? const Center(child: Text('ไม่มีข้อมูลรถ'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _carsData.length,
                    itemBuilder: (context, index) {
                      final car = _carsData[index];
                      print(_carsData[index]);
                      return _buildCarCard(
                        tid: int.parse(car['tid']
                            .toString()), // Ensure tid is passed as int
                        imageUrl: car['tract_image'] ?? '',
                        name: car['name_tract'] ?? 'ไม่ระบุ',
                        type: car['type_name_tract'].join(', ') ?? 'ไม่ระบุ',
                        location: car['address'] ?? 'ไม่ระบุ',
                        price: car['price'] ?? 'ไม่ระบุ',
                        rating: car['rate'].toString(),
                        distance: 'ไม่ระบุ',
                      );
                    },
                  )
      ],
    );
  }

  Widget _buildCarCard({
    required String imageUrl, // เปลี่ยนเป็น String? รองรับ null
    required String name,
    required String type,
    required String location,
    required String price,
    required String rating,
    required String distance,
    required int tid,
  }) {
    print("🚗 Image URL: $imageUrl"); // Debug ดูว่ามีค่าหรือไม่

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl!, // ใช้ URL จาก userData หรือ URL พื้นฐาน
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/Logo.png",
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                );
              },
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailConPage(),
                            ),
                          );
                        },
                        child: const Text('รายละเอียดเพิ่มเติม',
                            style:
                                TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          if (tid != null) {
                            await _deleteCar(tid.toString());
                          } else {
                            print('tid is null');
                          }
                        },
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
