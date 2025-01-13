// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   final Function(double lat, double lng) onLocationSelected;

//   const MapPage({super.key, required this.onLocationSelected});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController _controller;
//   LatLng? _selectedLocation;

//   void _onMapCreated(GoogleMapController controller) {
//     _controller = controller;
//   }

//   void _onTap(LatLng location) {
//     setState(() {
//       _selectedLocation = location;
//     });
//   }

//   void _confirmLocation() {
//     if (_selectedLocation != null) {
//       // ส่งค่าผ่าน Navigator.pop ไปยังหน้าที่เรียกใช้
//       Navigator.pop(context, _selectedLocation);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('กรุณาปักหมุดที่แผนที่')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('เลือกตำแหน่ง')),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(13.7563, 100.5018), // กำหนดตำแหน่งเริ่มต้น
//                 zoom: 12,
//               ),
//               onTap: _onTap,
//               markers: _selectedLocation != null
//                   ? {
//                       Marker(
//                         markerId: MarkerId('selected_location'),
//                         position: _selectedLocation!,
//                       ),
//                     }
//                   : {},
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _confirmLocation,
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             child: const Text('ยืนยันตำแหน่ง'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   final Function(double lat, double lng) onLocationSelected;

//   const MapPage({super.key, required this.onLocationSelected});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController _controller;
//   LatLng? _selectedLocation;

//   void _onMapCreated(GoogleMapController controller) {
//     _controller = controller;
//   }

//   void _onTap(LatLng location) {
//     setState(() {
//       _selectedLocation = location;
//     });
//   }

//   void _confirmLocation() {
//     if (_selectedLocation != null) {
//       // ส่งค่าผ่าน Navigator.pop ไปยังหน้าที่เรียกใช้
//       Navigator.pop(context, _selectedLocation); // ส่ง LatLng กลับไป
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('กรุณาปักหมุดที่แผนที่')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('เลือกตำแหน่ง')),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(13.7563, 100.5018), // กำหนดตำแหน่งเริ่มต้น
//                 zoom: 12,
//               ),
//               onTap: _onTap,
//               markers: _selectedLocation != null
//                   ? {
//                       Marker(
//                         markerId: MarkerId('selected_location'),
//                         position: _selectedLocation!,
//                       ),
//                     }
//                   : {},
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _confirmLocation,
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             child: const Text('ยืนยันตำแหน่ง'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.7563, 100.5018), // กรุงเทพฯ
    zoom: 12.0,
  );

  static const CameraPosition _kLake = CameraPosition(
    target: LatLng(13.729, 100.523), // ตำแหน่งใหม่
    zoom: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('ไปยังตำแหน่ง'),
        icon: const Icon(Icons.place),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
