import 'dart:convert';
import 'package:app_agri_booking/config.dart';
import 'package:app_agri_booking/model/GetAllTracts.dart';
import 'package:app_agri_booking/pages/Client/Detail.dart';
import 'package:app_agri_booking/pages/Client/Search.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class HomeClientPage extends StatefulWidget {
  final dynamic userData;

  const HomeClientPage({super.key, required this.userData});

  @override
  State<HomeClientPage> createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  int? selectedFarmId;
  List<Map<String, dynamic>> farms = [];

  @override
  void initState() {
    super.initState();
    fetchFarms();
  }

  Future<void> fetchFarms() async {
    final response = await http.get(
      Uri.parse(
        "http://projectnodejs.thammadalok.com/AGribooking/client/farms/${widget.userData['mid']}",
      ),
    );

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final farmList = (decodedData['farms'] as List)
          .map((farm) => {
                'fid': farm['fid'],
                'name_farm': farm['name_farm'],
              })
          .toList();
      setState(() {
        farms = farmList;
        if (farms.isNotEmpty) {
          selectedFarmId = farms.first['fid'];
        }
      });
    } else {
      throw Exception("Failed to load farms");
    }
  }

  Future<List<GetAllTracts>> fetchData() async {
    final response = await http.get(Uri.parse(ApiConfig.getAllTractsList));

    if (response.statusCode == 200) {
      return getAllTractsFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://www.vervaet.nl/dbupload/_p34_hydro.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNHzaUcniTqXfWLOpa5HfWV_eTQAdBjHPNKg&s',
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 214, 169),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                'assets/images/Logo.png',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(fontSize: 14.0, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'ค้นหา :ชื่อรถ,ประเภทรถ,ราคา,จังหวัด,อำเภอ',
                  hintStyle:
                      const TextStyle(fontSize: 14.0, color: Colors.grey),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                              mid: widget.userData['mid'], userData: {}),
                        ),
                      );
                    },
                    child: const Icon(Icons.search),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                          mid: widget.userData['mid'],
                          userData: widget.userData),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 100.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: imageUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: farms.isEmpty
                  ? const CircularProgressIndicator()
                  : DropdownButtonFormField<int>(
                      value: selectedFarmId,
                      items: farms.map((farm) {
                        return DropdownMenuItem<int>(
                          value: farm['fid'],
                          child: Text(farm['name_farm'] ?? "ไม่ทราบชื่อ"),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedFarmId = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'เลือกไร่นาของคุณ',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 8.0),
              child: Text(
                'รถที่ให้บริการ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
            FutureBuilder<List<GetAllTracts>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<GetAllTracts> tracts = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tracts.length,
                    itemBuilder: (context, index) {
                      final tract = tracts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    child: Image.network(
                                      (tract.image != null &&
                                              tract.image.isNotEmpty)
                                          ? tract.image
                                          : 'https://www.forest.go.th/training/wp-content/uploads/sites/17/2015/03/noimages.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tract.nameTract,
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'ประเภทรถ : ${tract.typeNameTract}',
                                        style: const TextStyle(fontSize: 11.0),
                                      ),
                                      Text(
                                        'ที่อยู่ : ${tract.address}',
                                        style: const TextStyle(fontSize: 11.0),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'ราคา : ',
                                            style: TextStyle(fontSize: 11.0),
                                          ),
                                          Text(
                                            tract.price,
                                            style: const TextStyle(
                                              fontSize: 11.0,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'ระยะทาง : 50 กิโลเมตร',
                                        style: const TextStyle(fontSize: 11.0),
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          width: 150.0,
                                          height: 35.0,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              final fidToSend =
                                                  selectedFarmId ?? 0;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                    tid: tract.tid,
                                                    mid: widget.userData['mid'],
                                                    fid: fidToSend,
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 46, 210, 51),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            child: const Text(
                                              'รายละเอียดเพิ่มเติม',
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
