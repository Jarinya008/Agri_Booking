import 'package:flutter/material.dart';

class EditCarPage extends StatefulWidget {
  const EditCarPage({super.key});

  @override
  _EditCarPageState createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _newTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลรถ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange[200],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // รูปภาพรถ
            Center(
              child: GestureDetector(
                onTap: () {
                  // ฟังก์ชันเลือกรูปภาพจะมาในภายหลัง
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.image, size: 40, color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('เลือกรูปรถ', style: TextStyle(color: Colors.black)),
            const SizedBox(height: 30),

            // ฟอร์มกรอกข้อมูล
            _buildTextField('ชื่อรถ', _nameController),
            _buildTextField('จำนวนรถ', _amountController),
            _buildTextField('ราคาต่อพื้นที่จ้างงาน', _priceController),

            const SizedBox(height: 30),

            // เพิ่มประเภทใหม่
            _buildNewTypeInput(),
            const SizedBox(height: 30),

            // ปุ่มยืนยันและยกเลิก
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('ยกเลิก', Colors.red, () {
                  Navigator.pop(context);
                }),
                _buildButton('ยืนยัน', Colors.green, () {
                  // ฟังก์ชันยืนยันจะมาในภายหลัง
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[300],
        ),
      ),
    );
  }

  Widget _buildNewTypeInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _newTypeController,
            decoration: const InputDecoration(
              labelText: 'เพิ่มประเภทรถใหม่',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.green),
          onPressed: () {
            // ฟังก์ชันเพิ่มประเภทใหม่จะมาในภายหลัง
          },
        ),
      ],
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
