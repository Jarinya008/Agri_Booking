// import 'package:app_agri_booking/pages/Contractor/%E0%B9%8CNotification.dart';
// import 'package:app_agri_booking/pages/Contractor/Home.dart';
// import 'package:app_agri_booking/pages/Contractor/MyCars.dart';
// import 'package:flutter/material.dart';

// class ToobarCar extends StatefulWidget {
//   final int value;
//   final dynamic userData; // รับข้อมูลจาก Login
//   const ToobarCar({super.key, required this.value, required this.userData});

//   @override
//   State<ToobarCar> createState() => _ToobarCState();
// }

// class _ToobarCState extends State<ToobarCar> {
//   late int value;
//   late Widget curretnPage = MyCars(
//     userData: {},
//   );

//   @override
//   void initState() {
//     super.initState();
//     value = widget.value;
//     switchPage(value);
//   }

//   void switchPage(int index) {
//     setState(() {
//       value = index;
//       if (index == 0) {
//         curretnPage = HomeContractorPage(
//           userData: null,
//         );
//       } else if (index == 1) {
//         curretnPage = NotificationPage();
//       } else if (index == 2) {
//         curretnPage = const MyCars(
//           userData: {},
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color(0xFFEF6C00), // เปลี่ยนสีพื้นหลังของ Scaffold
//       body: curretnPage,
//       bottomNavigationBar: Container(
//         child: BottomNavigationBar(
//           backgroundColor: Colors.white,
//           currentIndex: value,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today),
//               label: 'ตารางงาน',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat),
//               label: 'แจ้งเตือน',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'ฉัน',
//             ),
//           ],
//           onTap: switchPage,
//           selectedItemColor: const Color(0xFFEF6C00),
//           unselectedItemColor: Colors.black,
//         ),
//       ),
//     );
//   }
// }

import 'package:app_agri_booking/pages/Contractor/%E0%B9%8CNotification.dart';
import 'package:app_agri_booking/pages/Contractor/Home.dart';
import 'package:app_agri_booking/pages/Contractor/MyCars.dart';
import 'package:flutter/material.dart';

class ToolbarCar extends StatefulWidget {
  final int value;
  final dynamic userData; // รับข้อมูลจาก Login
  const ToolbarCar({super.key, required this.value, required this.userData});

  @override
  State<ToolbarCar> createState() => _ToolbarCarState();
}

class _ToolbarCarState extends State<ToolbarCar> {
  late int value;
  late Widget currentPage;

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
        currentPage = HomeContractorPage(
          userData: widget.userData,
        );
      } else if (index == 1) {
        currentPage = NotificationPage();
      } else if (index == 2) {
        currentPage = MyCars(
          userData: widget.userData,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'ตารางงาน',
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
        selectedItemColor: const Color(0xFFEF6C00),
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
