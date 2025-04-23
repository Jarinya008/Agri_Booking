import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeContractorPage extends StatefulWidget {
  HomeContractorPage({super.key});

  @override
  _HomeContractorPageState createState() => _HomeContractorPageState();
}

class _HomeContractorPageState extends State<HomeContractorPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // ข้อมูลจำลอง
  final Map<DateTime, List<Map<String, String>>> _events = {
    DateTime(2025, 4, 24): [
      {"title": "งานติดตั้ง", "details": "ติดตั้งระบบไฟฟ้า"},
      {"title": "งานตรวจสอบ", "details": "ตรวจสอบคุณภาพงาน"}
    ],
    DateTime(2025, 4, 25): [
      {"title": "ประชุมโครงการ", "details": "ประชุมที่สำนักงานใหญ่"}
    ],
    DateTime(2025, 4, 30): [
      {"title": "งานซ่อมแซม", "details": "ซ่อมหลังคารั่ว"}
    ],
  };

  void _showEventDetails(String title, String details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(details),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ปิด"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ตารางงานผู้รับเหมา"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: (day) {
                return _events[_normalizeDate(day)] ?? [];
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _selectedDay != null &&
                      _events.containsKey(_normalizeDate(_selectedDay!))
                  ? ListView.builder(
                      itemCount: _events[_normalizeDate(_selectedDay!)]!.length,
                      itemBuilder: (context, index) {
                        var event =
                            _events[_normalizeDate(_selectedDay!)]![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          elevation: 3,
                          child: ListTile(
                            title: Text(
                              event["title"]!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading:
                                const Icon(Icons.event, color: Colors.blue),
                            onTap: () => _showEventDetails(
                                event["title"]!, event["details"]!),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("ไม่มีงานในวันนี้",
                          style: TextStyle(fontSize: 18, color: Colors.grey))),
            ),
          ],
        ),
      ),
    );
  }
}
