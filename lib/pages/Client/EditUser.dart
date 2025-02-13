import 'package:flutter/material.dart';

class edituser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลส่วนตัว'),
        backgroundColor: Colors.orange[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.orange[100],
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      //ใส่รูปโปรไฟล์
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
                        _buildTextField('ชื่อผู้ใช้', 'Jarinya', false),
                        _buildTextField('Email', 'jaja55@gmail.com', false),
                        _buildTextField('เบอร์โทร', '0822222222', false),
                        _buildTextField('ข้อมูลการติดต่อเพิ่มเติม',
                            'แอดไลน์ที่ @jj666', false,
                            maxLines: 3),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                ),
                                icon: const Icon(Icons.location_on,
                                    color: Colors.black),
                                label: const Text('GPS',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        _buildTextField(
                            'ที่อยู่',
                            'บ้านเลขที่ 1/11 บ้านขามเปี้ยง ต. ขามเปี้ยง อ. กันทรวิชัย จ. มหาสารคาม',
                            false,
                            maxLines: 3),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
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

  Widget _buildTextField(String label, String value, bool isEditable,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: TextEditingController(text: value),
        readOnly: !isEditable,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
