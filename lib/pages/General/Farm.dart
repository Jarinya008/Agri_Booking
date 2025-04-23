import 'package:flutter/material.dart';
import 'package:app_agri_booking/pages/General/EditFarm.dart';
import 'package:app_agri_booking/pages/General/InserFarm.dart';

class FarmListPage extends StatefulWidget {
  final int mid;

  const FarmListPage({super.key, required this.mid});

  @override
  _FarmListPageState createState() => _FarmListPageState();
}

class _FarmListPageState extends State<FarmListPage> {
  List<Map<String, dynamic>> farms = [
    {
      'fid': 1,
      'name_farm': 'ฟาร์มตัวอย่าง',
      'tumbol': 'ตำบลหนึ่ง',
      'district': 'อำเภอสอง',
      'province': 'จังหวัดสาม',
      'detail': 'รายละเอียดของฟาร์มตัวอย่าง',
    },
    // สามารถเพิ่ม mock farms เพิ่มเติมได้
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลไร่นา'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: farms.isEmpty
          ? const Center(child: Text("ไม่มีข้อมูลไร่นา"))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: farms.length,
              itemBuilder: (context, index) {
                return _buildFarmCard(context, farms[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertFarmPage(
                mid: widget.mid,
                userData: {},
              ),
            ),
          );
        },
        icon: const Icon(Icons.add, color: Colors.orange, size: 30),
        label: const Text(
          'เพิ่มไร่นา',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  Widget _buildFarmCard(BuildContext context, dynamic farm) {
    return Card(
      color: const Color.fromARGB(255, 247, 172, 60),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${farm['name_farm']} ${farm['tumbol']} ${farm['district']} ${farm['province']}, ${farm['detail']}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                    setState(() {
                      farms.remove(farm);
                    });
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
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditFarmPage(),
                      ),
                    );
                  },
                  child: const Text('แก้ไข'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
