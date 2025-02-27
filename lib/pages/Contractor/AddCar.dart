import 'package:flutter/material.dart';
import 'dart:io'; // Import this for File type (image picking)
import 'package:image_picker/image_picker.dart'; // Import image picker

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  File? _selectedImage; // Variable to hold the selected image
  String? _selectedCarType; // Variable to hold the selected car type

  // List of car types to show in the dropdown
  final List<String> _carTypes = ['เก๋ง', 'กระบะ', 'มอเตอร์ไซค์', 'ตู้'];

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // You can change to camera if needed
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ข้อมูลรถ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
            Center(
              child: GestureDetector(
                onTap: _pickImage, // Image selection on tap
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!) // Display selected image
                      : null, // No image selected
                  child: _selectedImage == null
                      ? const Icon(
                          Icons.person, // Icon when no image is selected
                          size: 40,
                          color: Colors.green,
                        )
                      : null, // No icon when an image is selected
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'เพิ่มรูปรถ',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 30),
            _buildTextField('ชื่อรถ'),
            _buildDropdown('ประเภทรถ'),
            _buildTextField('ราคาต่อพื้นที่จ้างงาน'),
            _buildTextField('จำนวนรถ'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('ยกเลิก', Colors.red, () {
                  Navigator.pop(context); // Close or reset
                }),
                _buildButton('ยืนยัน', Colors.green, () {
                  // Add your submission logic here
                  print('ข้อมูลรถถูกยืนยัน');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black, // สีของ label
            fontSize: 16, // ขนาดตัวอักษรของ label
          ),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[300],
          floatingLabelBehavior:
              FloatingLabelBehavior.auto, // ขยับ label ขึ้นเมื่อกรอกข้อมูล
        ),
      ),
    );
  }

  // Dropdown for selecting car type
  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedCarType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black, // สีของ label
            fontSize: 16, // ขนาดตัวอักษรของ label
          ),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[300],
        ),
        items: _carTypes
            .map((carType) => DropdownMenuItem<String>(
                  value: carType,
                  child: Text(carType),
                ))
            .toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedCarType = newValue;
          });
        },
        hint: const Text('เลือกประเภทรถ'),
      ),
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
