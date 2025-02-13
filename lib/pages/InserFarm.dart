import 'package:flutter/material.dart';

class InsertFarmPage extends StatelessWidget {
  const InsertFarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลไร่นา'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'กรุณากรอกข้อมูลไร่นา',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 10),
                _buildTextField('ตำบล'),
                _buildTextField('อำเภอ'),
                _buildTextField('จังหวัด'),
                _buildTextField('รายละเอียดที่อยู่',
                    maxLines: 3, hintText: 'เช่น 16/50 บ้านนาคา ตำบล...'),
                _buildGPSButton(),
                _buildTextField('ที่อยู่', maxLines: 3),
                const SizedBox(height: 20),
                _buildBottomButtons(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1, String? hintText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGPSButton() {
    return Center(
      child: SizedBox(
        width: double.infinity, // ทำให้ปุ่มกว้างเต็มพื้นที่เท่ากับ TextField
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // TODO: เพิ่มฟังก์ชัน GPS
          },
          child: const Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // จัดไอคอนและข้อความไว้กลางปุ่ม
            children: [
              Icon(Icons.location_on, color: Colors.black),
              SizedBox(width: 5), // เว้นช่องว่างระหว่างไอคอนกับข้อความ
              Text(
                'GPS',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ข้าม', style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // TODO: เพิ่มฟังก์ชันยืนยันข้อมูล
            },
            child: const Text('ยืนยัน', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
