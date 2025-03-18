import 'dart:convert';
import 'package:app_agri_booking/pages/Client/Detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  final int mid;
  final dynamic userData;
  const SearchPage({super.key, required this.mid, required this.userData});

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
  List<dynamic> tractorsList =
      []; // เพิ่มตัวแปรนี้เพื่อเก็บข้อมูลที่ได้จากการค้นหา

  @override
  void initState() {
    super.initState();
    fetchFarms();
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
    String distanceSort = isDistanceAscending ? 'ASC' : 'DESC';
    String priceSort = isPriceAscending ? 'ASC' : 'DESC';

    final baseUrl =
        "http://projectnodejs.thammadalok.com/AGribooking/member/search";
    final queryParams = {
      'search': query,
      if (selectedType.isNotEmpty) 'name_type_tract': selectedType,
      if (selectedFarmID > 0) 'farm_id': selectedFarmID.toString(),
      'member_id': widget.mid.toString(),
      'sort_distance': distanceSort,
      'sort_price': priceSort,
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData['success']) {
          setState(() {
            tractorsList =
                decodedData['data'] ?? []; // เก็บข้อมูลที่ได้รับจาก API
          });
        } else {
          throw Exception("Search failed.");
        }
      } else {
        throw Exception("Failed to fetch tractors.");
      }
    } catch (e) {
      print("🚨 Error searching tractors: $e");
    }
  }

  Widget _buildTractorItem(dynamic tractor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: tractor['image'] != ''
            ? Image.network(tractor['image'])
            : Icon(Icons.image), // ถ้ามีรูปแสดงรูปภาพ ถ้าไม่มีแสดงไอคอน
        title: Text(tractor['name_tract']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ประเภท: ${tractor['name_type_tract'].join(', ')}"),
            Text("ราคา: ${tractor['price']}"),
            Text("ระยะทาง: ${tractor['distance']} กิโลเมตร"),
            Text("ติดต่อ: ${tractor['contact']}"),
            Text("ที่อยู่: ${tractor['address']}"),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // เมื่อกดปุ่ม "รายละเอียดเพิ่มเติม" ส่งข้อมูลไปยังหน้ารายละเอียด
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  tid: tractor['tid'],
                  mid: widget.mid, // ส่งข้อมูล member_id ไปด้วย
                  fid: selectedFarmID, // ส่ง farm_id ไปด้วย
                ),
              ),
            );
          },
          child: const Text("รายละเอียดเพิ่มเติม"),
        ),
      ),
    );
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
              // พื้นที่สำหรับค้นหา (TextField, Filter Button, etc.)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                      decoration: const InputDecoration(
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
                                            selectedFarmID = farm['fid'];
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
                    child: Text(
                      selectedTypeFarm.length > 5
                          ? '${selectedTypeFarm.substring(0, 5)}...'
                          : selectedTypeFarm,
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
                                _buildTypeOption(''),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(selectedType.isNotEmpty
                          ? selectedType
                          : "เลือกประเภท"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDistanceAscending = !isDistanceAscending;
                        });
                      },
                      child: Text('ระยะทาง ${isDistanceAscending ? '↓' : '↑'}'),
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
                  child: const Text('ค้นหา'),
                ),
              ),

              const SizedBox(height: 20),

              // แสดงรายการของ Tractor ที่ได้จาก API
              if (tractorsList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tractorsList.length,
                  itemBuilder: (context, index) {
                    return _buildTractorItem(tractorsList[index]);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
