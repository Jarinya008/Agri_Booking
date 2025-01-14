import 'package:app_agri_booking/pages/Toobar.dart';
import 'package:flutter/material.dart';

class HomeUserAllPage extends StatelessWidget {
  const HomeUserAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      appBar: AppBar(
        title: const Text('ผู้ใช้ทั่วไป'),
      ),
      body: SingleChildScrollView(
        // Allow scrolling in case content overflows
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity, // Full screen width
              height: 200, // Defined height
              child: Image.asset(
                'assets/images/Logo.png',
                fit: BoxFit
                    .contain, // Adjust size while maintaining aspect ratio
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'หน้าแรกผู้ใช้ทั่วไป', // Display message
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            // Search field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ค้นหา :ชื่อรถ,ประเภทรถ,ราคา,จังหวัด,อำเภอ',
                  prefixIcon: const Icon(Icons.search),
                  fillColor:
                      Colors.grey[200], // Background color for search field
                  filled: true, // Enable background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // Remove border lines
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Toobar(),
    );
  }
}
