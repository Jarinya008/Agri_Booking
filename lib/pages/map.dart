import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final Function(double lat, double lng) onLocationSelected;

  const MapPage({super.key, required this.onLocationSelected});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _controller;
  LatLng? _selectedLocation;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _confirmLocation() {
    if (_selectedLocation != null) {
      widget.onLocationSelected(
          _selectedLocation!.latitude, _selectedLocation!.longitude);
      _controller.animateCamera(
        CameraUpdate.newLatLng(_selectedLocation!),
      ); // เลื่อนแผนที่ไปที่ตำแหน่งที่เลือก
      Navigator.pop(context); // ปิดหน้า MapPage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณาปักหมุดที่แผนที่')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เลือกตำแหน่ง')),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(13.7563, 100.5018), // กำหนดตำแหน่งเริ่มต้น
                zoom: 12,
              ),
              onTap: _onTap,
              markers: _selectedLocation != null
                  ? {
                      Marker(
                        markerId: MarkerId('selected_location'),
                        position: _selectedLocation!,
                      ),
                    }
                  : {},
            ),
          ),
          ElevatedButton(
            onPressed: _confirmLocation,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('ยืนยันตำแหน่ง'),
          ),
        ],
      ),
    );
  }
}
