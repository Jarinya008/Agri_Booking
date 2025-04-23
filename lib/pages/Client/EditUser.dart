import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController contactController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    // ข้อมูลจำลอง
    nameController = TextEditingController(text: 'สมชาย ใจดี');
    emailController = TextEditingController(text: 'somchai@example.com');
    phoneController = TextEditingController(text: '0812345678');
    contactController =
        TextEditingController(text: 'ติดต่อญาติใกล้ชิด 0899999999');
    addressController = TextEditingController(
        text: '123/4 ถนนสุขใจ แขวงสุขสันต์ เขตบางกรวย กรุงเทพฯ');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    contactController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลส่วนตัว'),
        backgroundColor: Colors.orange[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.orange[100],
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: const [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/Logo.png'),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTextField('ชื่อผู้ใช้',
                            TextEditingController(text: 'สมชาย ใจดี')),
                        _buildTextField('Email',
                            TextEditingController(text: 'somchai@example.com')),
                        _buildTextField('เบอร์โทร',
                            TextEditingController(text: '0812345678')),
                        _buildTextField(
                            'ข้อมูลการติดต่อเพิ่มเติม',
                            TextEditingController(
                                text: 'ติดต่อญาติใกล้ชิด 0899999999'),
                            maxLines: 3),
                        const SizedBox(height: 8.0),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                          ),
                          icon: const Icon(Icons.location_on,
                              color: Colors.black),
                          label: const Text('GPS',
                              style: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(height: 8.0),
                        _buildTextField(
                            'ที่อยู่',
                            TextEditingController(
                                text:
                                    '123/4 ถนนสุขใจ แขวงสุขสันต์ เขตบางกรวย กรุงเทพฯ'),
                            maxLines: 3),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('ยกเลิก',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('ยืนยัน',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
      ),
    );
  }
}
