import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCarPage extends StatefulWidget {
  final int usermid; // เปลี่ยนจาก Map เป็น int เพราะ mid เป็นเลขไอดี
  final String imgbbApiKey = "a051ad7a04e7037b74d4d656e7d667e9";
  // เพิ่ม parameter usermid ใน constructor
  const AddCarPage(
      {super.key,
      required this.usermid}); // ใช้ constructor ที่ส่ง usermid เข้าไป

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  File? _selectedImage;
  String? _selectedCarType;
  List<Map<String, dynamic>> _carTypes = [];
  List<int> _selectedTyIds = []; // เก็บ tyid ที่เลือก
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _newTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCarTypes();
  }

  Future<void> _fetchCarTypes() async {
    const String url =
        "http://projectnodejs.thammadalok.com/AGribooking/contractor/type/tracts";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("API Response: ${data["type_tracts"]}"); // เช็คโครงสร้างข้อมูล

        if (data["type_tracts"] is List) {
          setState(() {
            _carTypes = List<Map<String, dynamic>>.from(
              (data["type_tracts"] as List).map((item) {
                if (item is Map<String, dynamic>) {
                  return item; // ถ้าข้อมูลตรงตามโครงสร้าง ให้ใช้ได้เลย
                } else {
                  return {
                    "tyid": null,
                    "name_type_tract": item.toString()
                  }; // แปลงเป็น Map<String, dynamic>
                }
              }),
            );
          });
        }
      } else {
        print("Error loading data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // ฟังก์ชันสำหรับอัปโหลดภาพไปยัง ImgBB (ถ้าต้องการ)
  Future<String?> _uploadImageToImgBB(File imageFile) async {
    final Uri url = Uri.parse('https://api.imgbb.com/1/upload');
    final request = http.MultipartRequest('POST', url);
    request.fields['key'] = widget.imgbbApiKey;
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseData);
        if (jsonResponse['status'] == 200) {
          return jsonResponse['data']['url']; // ส่ง URL ของภาพที่อัปโหลดกลับ
        }
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
    return null;
  }

  // ฟังก์ชันสำหรับแสดงภาพที่เลือกใน CircleAvatar
  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey[200],
      backgroundImage: _selectedImage != null
          ? FileImage(_selectedImage!)
          : null, // แสดงรูปที่เลือก
      child: _selectedImage == null
          ? const Icon(
              Icons.person, // ไอคอนรูปคน
              size: 40, // ขนาดไอคอน
              color: Colors.green, // สีไอคอน
            )
          : null, // ไม่แสดงไอคอนถ้ามีภาพ
    );
  }

  void _addNewType() {
    String newType = _newTypeController.text.trim();

    if (newType.isNotEmpty) {
      // ตรวจสอบว่ามีชื่อประเภทนี้อยู่ใน _carTypes หรือไม่
      bool isAlreadyExist =
          _carTypes.any((type) => type["name_type_tract"] == newType);

      if (isAlreadyExist) {
        print("ประเภทนี้มีอยู่แล้ว");
      } else {
        setState(() {
          _carTypes
              .add({"tyid": _carTypes.length + 1, "name_type_tract": newType});
          _newTypeController.clear(); // ล้างค่าหลังจากเพิ่มข้อมูล
        });
      }
    } else {
      print("กรุณากรอกชื่อประเภทก่อนเพิ่ม");
    }
  }

  Future<void> _submitData() async {
    const String url =
        "http://projectnodejs.thammadalok.com/AGribooking/contractor/insert/tract";

    // ตรวจสอบว่าไม่ให้ข้อมูลว่าง
    if (_nameController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _selectedTyIds.isEmpty) {
      print("กรุณากรอกข้อมูลให้ครบ");
      return;
    }
    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl =
          await _uploadImageToImgBB(_selectedImage!); // ส่งภาพไปที่ ImgBB
    }
    // ข้อมูลที่จะส่งเป็น JSON
    Map<String, dynamic> requestData = {
      'name_tract': _nameController.text, // ชื่อรถ
      'amount': _amountController.text, // จำนวนรถ
      'price': _priceController.text, // ราคาต่อพื้นที่
      'mid': widget.usermid.toString(), // รหัสผู้ใช้
      // ตรวจสอบให้ name_type_tract เป็น Array
      'name_type_tract': _carTypes
          .where((type) => _selectedTyIds.contains(type["tyid"]))
          .map((type) => type["name_type_tract"])
          .toList(), // ให้เป็น Array ของ string
      'image': imageUrl ?? "" // URL ของภาพ
    };

    // พิมพ์ข้อมูลก่อนส่ง
    print("Data to be sent:");
    print("Name: ${_nameController.text}");
    print("Amount: ${_amountController.text}");
    print("Price: ${_priceController.text}");
    print("User ID (mid): ${widget.usermid}");
    print(
        "Selected Types (name_type_tract): ${jsonEncode(requestData['name_type_tract'])}");
    print("Image URL: ${jsonEncode(requestData['image'])}");

    // ส่งคำขอแบบ JSON
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // ใช้ header เป็น 'application/json'
        body: jsonEncode(requestData), // ส่งข้อมูลแบบ JSON
      );

      if (response.statusCode == 201) {
        print("เพิ่มข้อมูลสำเร็จ");
        Navigator.pop(context); // กลับหน้าก่อนหน้า
      } else {
        print("เกิดข้อผิดพลาด: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลรถ',
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
            Center(
              child: GestureDetector(
                onTap: _pickImage, // เมื่อคลิกจะเลือกภาพจากแกลเลอรี่
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : null, // ไม่มี backgroundImage ถ้าไม่มีการเลือกภาพ
                  child: _selectedImage == null
                      ? const Icon(
                          Icons.person, // ไอคอนรูปคน
                          size: 40, // ขนาดไอคอน
                          color: Colors.green, // สีไอคอน
                        )
                      : null, // ไม่แสดงไอคอนเมื่อมีการเลือกภาพ
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('เพิ่มรูปรถ', style: TextStyle(color: Colors.black)),
            const SizedBox(height: 30),
            _buildTextField('ชื่อรถ', _nameController),
            _buildMultiSelectDropdown('ประเภทรถ'),
            _buildTextField('ราคาต่อพื้นที่จ้างงาน', _priceController),
            _buildTextField('จำนวนรถ', _amountController),
            const SizedBox(height: 20),
            _buildNewTypeInput(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('ยกเลิก', Colors.red, () {
                  Navigator.pop(context);
                }),
                _buildButton('ยืนยัน', Colors.green, _submitData),
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

  Widget _buildMultiSelectDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Wrap(
            children: _carTypes.map((type) {
              bool isSelected = _selectedTyIds.contains(type["tyid"]);
              return ChoiceChip(
                label: Text(type["name_type_tract"]),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedTyIds.add(type["tyid"]);
                    } else {
                      _selectedTyIds.remove(type["tyid"]);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
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
          onPressed: _addNewType,
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
