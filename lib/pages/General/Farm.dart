import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_agri_booking/pages/General/EditFarm.dart';
import 'package:app_agri_booking/pages/General/InserFarm.dart';

class FarmListPage extends StatefulWidget {
  final int mid; // รับค่า mid จากหน้า MePage

  const FarmListPage(
      {super.key, required this.mid, required Map<String, dynamic> userData});

  @override
  _FarmListPageState createState() => _FarmListPageState();
}

class _FarmListPageState extends State<FarmListPage> {
  List farms = []; // เก็บรายการฟาร์ม
  bool isLoading = true; // เช็คสถานะการโหลด

  @override
  void initState() {
    super.initState();
    fetchFarms(); // เรียก API เมื่อหน้าโหลด
  }

// ฟังก์ชันสำหรับดึงข้อมูลฟาร์ม

  Future<void> fetchFarms() async {
    final url =
        "http://projectnodejs.thammadalok.com/AGribooking/client/farms/${widget.mid}";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("🔹 API Response: ${response.body}"); // Log ข้อมูลที่ API ส่งมา
        setState(() {
          final decodedData = json.decode(response.body);
          farms = decodedData['farms'] ?? []; // ดึงเฉพาะ farms
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load farms");
      }
    } catch (e) {
      print("Error fetching farms: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> fetchFarms() async {
  //   final url =
  //       "http://projectnodejs.thammadalok.com/AGribooking/client/farms/${widget.mid}";
  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       print("🔹 API Response: ${response.body}"); // Log ข้อมูลที่ API ส่งมา
  //       setState(() {
  //         final decodedData = json.decode(response.body);
  //         farms = decodedData['farms'] ?? []; // ดึงเฉพาะ farms
  //         isLoading = false;
  //       });
  //     } else {
  //       throw Exception("Failed to load farms");
  //     }
  //   } catch (e) {
  //     print("Error fetching farms: $e");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลไร่นา'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // แสดงโหลดดิ้ง
          : farms.isEmpty
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
        icon: const Icon(Icons.add,
            color: Colors.orange, size: 30), // ไอคอนเพิ่มขึ้น
        label: const Text(
          'เพิ่มไร่นา',
          style: TextStyle(
              fontSize: 16, color: Colors.black), // ขนาดฟอนต์และสีของข้อความ
        ),
        backgroundColor:
            const Color.fromARGB(255, 255, 255, 255), // พื้นหลังปุ่มสีขาว
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
              farm['name_farm'] +
                  " " +
                  farm['tumbol'] +
                  " " +
                  farm['district'] +
                  " " +
                  farm['province'] +
                  ", " +
                  farm['detail'],
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
                  onPressed: () => _deleteFarm(farm['fid']),
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
                        builder: (context) => EditFarmPage(farmData: farm),
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

  // Future<void> _deleteFarm(int farmId) async {
  //   final url =
  //       "http://projectnodejs.thammadalok.com/AGribooking/client/delete/farm/$farmId";

  //   try {
  //     final response = await http.delete(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         farms.removeWhere((farm) => farm['fid'] == farmId);
  //       });
  //     } else {
  //       throw Exception("Failed to delete farm");
  //     }
  //   } catch (e) {
  //     print("Error deleting farm: $e");
  //   }
  // }

  Future<void> _deleteFarm(int farmId) async {
    // แสดงกล่องยืนยันก่อนลบ
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการลบฟาร์ม'),
          content: Text('คุณต้องการลบฟาร์มนี้หรือไม่?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // ผู้ใช้เลือกไม่ลบ
              },
              child: Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // ผู้ใช้เลือกลบ
              },
              child: Text('ลบ'),
            ),
          ],
        );
      },
    );

    // ถ้าผู้ใช้เลือกลบ
    if (confirmDelete == true) {
      final url =
          "http://projectnodejs.thammadalok.com/AGribooking/client/delete/farm/$farmId";

      try {
        final response = await http.delete(Uri.parse(url));

        if (response.statusCode == 200) {
          setState(() {
            farms.removeWhere((farm) => farm['fid'] == farmId);
          });

          // เรียกฟังก์ชันเพื่อโหลดข้อมูลฟาร์มใหม่
          await fetchFarms();
        } else {
          throw Exception("Failed to delete farm");
        }
      } catch (e) {
        print("Error deleting farm: $e");
      }
    }
  }
}
