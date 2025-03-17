import 'package:flutter/material.dart';

class QueueCarScreen extends StatefulWidget {
  @override
  _QueueCarScreenState createState() => _QueueCarScreenState();
}

class _QueueCarScreenState extends State<QueueCarScreen> {
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
              const Text("🚜 รถตัดอ้อยขนาดใหญ่ รุ่น CH570"),
              const Text("📌 ประเภทการจอง: รถตัดอ้อย"),
              const Text("💰 ราคา 150 บาท/ไร่"),
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
                  onPressed: () {
                    // ฟังก์ชันยืนยันข้อมูล
                  },
                  child: const Text("ยืนยัน"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
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
