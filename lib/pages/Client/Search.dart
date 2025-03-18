import 'dart:convert';
import 'package:app_agri_booking/pages/Client/ToobarC.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  final int mid;

  const SearchPage({
    super.key,
    required this.mid,
    required Map<String, dynamic> userData,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  String selectedType = '';
  String selectedTypeFarm = 'ที่นา';
  int selectedFarmID = 0; // เพิ่มตัวแปรนี้เพื่อเก็บ farm_id

  bool isDistanceAscending = true;
  bool isPriceAscending = true;
  List<dynamic> farmsList = [];
  bool isFarmLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFarms();
    print(farmsList);
  }

  Future<void> fetchFarms() async {
    final url =
        "http://projectnodejs.thammadalok.com/AGribooking/client/farms/${widget.mid}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        setState(() {
          farmsList = decodedData['farms'] ?? [];
          isFarmLoading = false;
        });
      } else {
        throw Exception("Failed to load farms");
      }
    } catch (e) {
      print("Error fetching farms: $e");
      setState(() {
        isFarmLoading = false;
      });
    }
  }

  Future<void> searchTractors() async {
    // แปลงค่าของ isDistanceAscending และ isPriceAscending เป็น 'ASC' หรือ 'DESC'
    String distanceSort = isDistanceAscending ? 'ASC' : 'DESC';
    String priceSort = isPriceAscending ? 'ASC' : 'DESC';
    print("fid: $distanceSort");
    print("Distance sort: $distanceSort");
    print("Price sort: $priceSort");

    final url = Uri.parse("http://projectnodejs.thammadalok.com/member/search");

    try {
      final response = await http.get(url.replace(queryParameters: {
        'search': query,
        'price': '', // ถ้าไม่ได้ใช้ราคาให้ส่งเป็นค่าว่าง
        'name_type_tract':
            selectedType ?? '', // ถ้าไม่ได้เลือกประเภทแทรกเตอร์ให้ส่งค่าว่าง
        'farm_id': selectedFarmID.toString(),
        'member_id': widget.mid.toString(),
        'sort_distance': distanceSort, // ส่งค่าจัดเรียงตามระยะทาง
        'sort_price': priceSort, // ส่งค่าจัดเรียงตามราคา
      }));

      print(response);
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData['success']) {
          print("🔍 Search Success: ${decodedData['data']}");
        } else {
          throw Exception("Search failed.");
        }
      } else {
        throw Exception("Failed to fetch tractors.");
      }
    } catch (e) {
      print("Error searching tractors: $e");
    }
  }

  Widget _buildTypeOption(String type) {
    return ListTile(
      title: Text(type),
      onTap: () {
        setState(() {
          selectedType = type;
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 214, 169),
        title: const Text('ค้นหา', style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'พิมพ์คำที่ต้องการค้นหา...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (isFarmLoading) return;
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: isFarmLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: farmsList.map((farm) {
                                      return ListTile(
                                        title: Text(farm['name_farm']),
                                        onTap: () {
                                          setState(() {
                                            selectedTypeFarm =
                                                farm['name_farm'];
                                            selectedFarmID =
                                                farm['fid']; // เก็บค่า farm_id
                                          });
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 134, 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: Text(
                      selectedTypeFarm.length > 5
                          ? '${selectedTypeFarm.substring(0, 5)}...'
                          : selectedTypeFarm,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // แถบเมนูการค้นหา
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildTypeOption('รถไถ'),
                                _buildTypeOption('รถแทรกเตอร์'),
                                _buildTypeOption('รถขุด'),
                                _buildTypeOption('รถเกี่ยวข้าว'),
                                _buildTypeOption('รถดำนา'),
                                _buildTypeOption('รถตัด'),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(selectedType),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDistanceAscending = !isDistanceAscending;
                        });
                      },
                      child: Text('ระยะทาง ${isDistanceAscending ? '↑' : '↓'}'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isPriceAscending = !isPriceAscending;
                        });
                      },
                      child: Text('ราคา ${isPriceAscending ? '↑' : '↓'}'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: searchTractors,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                  ),
                  child: const Text(
                    'ค้นหา',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
