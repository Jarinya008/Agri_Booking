import 'package:app_agri_booking/pages/EditFarm.dart';
import 'package:app_agri_booking/pages/InserFarm.dart';
import 'package:flutter/material.dart';

class FarmListPage extends StatelessWidget {
  const FarmListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลไร่นา'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFarmCard(context),
            const Spacer(),
            _buildAddFarmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmCard(BuildContext context) {
    // รับ context เป็นพารามิเตอร์
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '16/50 บ้านนาคา ที่นาติดถนนตรงข้ามร้านขายของชำ\nตำบลนาคา อำเภอนาคา จังหวัดสงขลา',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // TODO: เพิ่มฟังก์ชันลบ
                },
                child: const Text('ลบออก'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context, // ตอนนี้ context ใช้งานได้แล้ว!
                    MaterialPageRoute(builder: (context) => EditFarmPage()),
                  );
                },
                child: const Text('แก้ไข'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAddFarmButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InsertFarmPage()),
          );
        },
        icon: const Icon(Icons.add, color: Colors.orange, size: 50),
        label: const Text(
          'เพิ่มไร่นา',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
