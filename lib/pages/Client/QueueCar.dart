import 'dart:convert';
import 'package:app_agri_booking/pages/Client/Queue.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QueueCarScreen extends StatefulWidget {
  final int mid;

  final dynamic tractData;
  final int fid;
  const QueueCarScreen(
      {super.key,
      required this.tractData,
      required this.mid,
      required this.fid});

  @override
  _QueueCarScreenState createState() => _QueueCarScreenState();
}

class _QueueCarScreenState extends State<QueueCarScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.tractData);
    print(widget.mid);
    print(widget.fid);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 9, minute: 0);

  String selectedAddress =
      "ที่นา 1 250/5 บ้านนดี อยู่ติดสวนลำไยบ้านดี \nตำบลบ้านแท่น อำเภอบ้านแท่น จังหวัดชัยภูมิ";

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _navigateToSelectLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectLocationScreen()),
    );
    if (result != null) {
      setState(() {
        selectedAddress = result;
      });
    }
  }

  Future<void> submitQueueData() async {
    const String apiUrl =
        "http://projectnodejs.thammadalok.com/AGribooking/client/insert/queue"; // เปลี่ยนเป็น URL จริงของ API

// แปลง DateTime และ TimeOfDay ให้อยู่ในรูปแบบที่ต้องการ
    String formatDateTime(DateTime date, TimeOfDay time) {
      final DateTime combined =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(combined);
    }

    Map<String, dynamic> requestData = {
      "name_qt": nameController.text,
      "date_start": formatDateTime(startDate, startTime), // ✅ แปลงวันที่เริ่ม
      "detail_qt": detailsController.text,
      "amount_qt": areaController.text,
      "date_end": formatDateTime(endDate, endTime), // ✅ แปลงวันที่สิ้นสุด
      "mid": widget.mid,
      "fid": widget.fid,
      "tid": widget.tractData['tid'],
    };
    print(requestData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ จองคิวสำเร็จ!")),
        );

        // ✅ นำทางไปหน้า QueuePage พร้อมส่ง mid
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QueuePage(mid: widget.mid),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("ข้อมูลไม่ถูกต้องกรุณากรอกใหม่")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("จองคิวรถ"),
        backgroundColor: Colors.amber, // ปรับสีเหลืองตามต้องการ
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("🚜 ${widget.tractData['name_tract']?.toString() ?? '-'}"),
              Text(
                  "📌 ประเภทการจอง:  ${widget.tractData['type_name_tract']?.toString() ?? '-'}"),
              Text("💰 ราคา  ${widget.tractData['price']?.toString() ?? '-'}"),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "ชื่องาน"),
              ),
              TextField(
                controller: areaController,
                decoration:
                    const InputDecoration(labelText: "จำนวนพื้นที่ทำงาน"),
              ),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(labelText: "รายละเอียดงาน"),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("📅 วันและเวลาเริ่ม"),
                        InkWell(
                          onTap: () => _selectDate(context, true),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            child: Text("${startDate.toLocal()}".split(' ')[0]),
                          ),
                        ),
                        InkWell(
                          onTap: () => _selectTime(context, true),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            child: Text(startTime.format(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("📅 วันและเวลาสิ้นสุด"),
                        InkWell(
                          onTap: () => _selectDate(context, false),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            child: Text("${endDate.toLocal()}".split(' ')[0]),
                          ),
                        ),
                        InkWell(
                          onTap: () => _selectTime(context, false),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            child: Text(endTime.format(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 211, 80),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.black54),
                  title: const Text("สถานที่นัดหมาย",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(selectedAddress),
                  trailing:
                      const Icon(Icons.arrow_forward, color: Colors.black54),
                  onTap: _navigateToSelectLocation,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: ElevatedButton(
                onPressed: submitQueueData, // เรียกฟังก์ชันเมื่อกดปุ่ม
                child: const Text("ยืนยัน"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

// หน้าสำหรับเลือกสถานที่
class SelectLocationScreen extends StatelessWidget {
  final List<String> locations = [
    "🚜 ไร่ข้าวโพด บ้านหนองแวง",
    "🌳 สวนลำไย บ้านนาสาร",
    "🏡 บ้านสวน บ้านกลาง",
    "🌾 ไร่ข้าว บ้านดอนคา"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("เลือกสถานที่")),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(locations[index]),
            onTap: () {
              Navigator.pop(context, locations[index]); // ส่งค่ากลับ
            },
          );
        },
      ),
    );
  }
}
