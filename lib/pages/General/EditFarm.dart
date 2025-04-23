import 'package:app_agri_booking/pages/General/map.dart';
import 'package:flutter/material.dart';

class EditFarmPage extends StatefulWidget {
  const EditFarmPage({super.key});

  @override
  State<EditFarmPage> createState() => _EditFarmPageState();
}

class _EditFarmPageState extends State<EditFarmPage> {
  late TextEditingController nameController;
  late TextEditingController tumbolController;
  late TextEditingController districtController;
  late TextEditingController provinceController;
  late TextEditingController detailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    tumbolController = TextEditingController();
    districtController = TextEditingController();
    provinceController = TextEditingController();
    detailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    tumbolController.dispose();
    districtController.dispose();
    provinceController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลไร่นา'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'กรุณากรอกข้อมูลไร่นา',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildTextField('ชื่อฟาร์ม', nameController),
            _buildTextField('ตำบล', tumbolController),
            _buildTextField('อำเภอ', districtController),
            _buildTextField('จังหวัด', provinceController),
            _buildTextField(
              'รายละเอียดที่อยู่',
              detailController,
              maxLines: 3,
              hintText: 'เช่น 16/50 บ้านนาคา...',
            ),
            const SizedBox(height: 10),
            _buildGPSButton(context),
            const SizedBox(height: 20),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, String? hintText}) {
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
            controller: controller,
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

  Widget _buildGPSButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // ชิดซ้าย
      children: [
        ElevatedButton.icon(
          onPressed: () {
            _openMapDialog(context); // เรียก dialog popup
          },
          icon: const Icon(Icons.location_on, color: Colors.black),
          label: const Text(
            'เลือกตำแหน่ง GPS',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 250, 231, 87),
            foregroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  void _openMapDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.8,
          child: MapPage(), // ใส่ widget หน้าของคุณที่ต้องการแสดงใน popup
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('กำลังเชื่อมหน้า GPS...')),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // จำลองบันทึกข้อมูล
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
              );
              Navigator.pop(context);
            },
            child: const Text('ยืนยัน', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }
}
