import 'package:app_agri_booking/pages/Client/%E0%B9%8CNotification.dart';
import 'package:app_agri_booking/pages/Client/Home.dart';
import 'package:app_agri_booking/pages/Client/Me.dart';
import 'package:app_agri_booking/pages/Client/Queue.dart';

import 'package:flutter/material.dart';

class ToobarC extends StatefulWidget {
  final int value;
  final dynamic userData; // รับข้อมูลจาก Login
  const ToobarC({super.key, required this.value, required this.userData});

  @override
  State<ToobarC> createState() => _ToobarCState();
}

class _ToobarCState extends State<ToobarC> {
  late int value;
  late Widget curretnPage = HomeClientPage();

  @override
  void initState() {
    super.initState();
    value = widget.value;
    switchPage(value);
  }

  void switchPage(int index) {
    setState(() {
      value = index;
      if (index == 0) {
        curretnPage = const HomeClientPage();
      } else if (index == 1) {
        curretnPage = QueuePage();
      } else if (index == 2) {
        curretnPage = NotificationPage();
      } else if (index == 3) {
        // ส่ง userData ไปยัง MePage
        curretnPage = MePage(userData: widget.userData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFEF6C00), // เปลี่ยนสีพื้นหลังของ Scaffold
      body: curretnPage,
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFEF6C00),
          currentIndex: value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'หน้าหลัก',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'จองคิว',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'แจ้งเตือน',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'ฉัน',
            ),
          ],
          onTap: switchPage,
          selectedItemColor:
              Color(0xFFEF6C00), // ตัวหนังสือในไอเท็มที่เลือกเป็นสีขาว
          unselectedItemColor:
              Colors.black, // ตัวหนังสือในไอเท็มที่ไม่ได้เลือกเป็นสีดำ
        ),
      ),
    );
  }
}



//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.orange[300], // สีพื้นหลัง
//       padding: const EdgeInsets.symmetric(vertical: 10), // ระยะห่างบน-ล่าง
//       child: Row(
//         mainAxisAlignment:
//             MainAxisAlignment.spaceAround, // กระจายพื้นที่อย่างเท่ากัน
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าหลัก
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const HomeClientPage()),
//                 );
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.home, size: 30), // ไอคอนหน้าหลัก
//                   Text('หน้าหลัก'), // ข้อความด้านล่างไอคอน
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าจองคิว
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => QueuePage()),
//                 );
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.calendar_today, size: 30), // ไอคอนจองคิว
//                   Text('จองคิว'), // ข้อความด้านล่างไอคอน
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าการแจ้งเตือน
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => NotificationPage()),
//                 );
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.chat, size: 30), // ไอคอนแจ้งเตือน
//                   Text('แจ้งเตือน'), // ข้อความด้านล่างไอคอน
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 // ใช้ Navigator เพื่อเปลี่ยนหน้าไปที่หน้าผู้ใช้
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => MePage(
//                             userData: null,
//                           )),
//                 );
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.person, size: 30), // ไอคอนโปรไฟล์
//                   Text('ฉัน'), // ข้อความด้านล่างไอคอน
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }











// class _ToobarState extends State<Toobar> {
//   late int value;
//   late Widget curretnPage = HomeUserAllPage();

//   @override
//   void initState() {
//     super.initState();
//     value = widget.value;
//     switchPage(value);
//   }

//   void switchPage(int index) {
//     log('Switching to index: $index');
//     setState(() {
//       value = index;
//       if (index == 0) {
//         curretnPage = const HomeUserAllPage();
//       } else if (index == 1) {
//         curretnPage = const LoginPage();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: curretnPage,
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xFFFFB74D),
//         currentIndex: value,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'หน้าหลัก',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'ฉัน',
//           ),
//         ],
//         onTap: switchPage,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.white,
//       ),
//     );
//   }
// }
