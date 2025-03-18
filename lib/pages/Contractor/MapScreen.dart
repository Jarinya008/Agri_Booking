// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class MapScreen extends StatefulWidget {
//   final double farmLat;
//   final double farmLng;

//   const MapScreen({
//     Key? key,
//     required this.farmLat,
//     required this.farmLng,
//   }) : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _mapController;
//   Position? _currentPosition;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   String _travelInfo = "";

//   final String _apiKey =
//       "AIzaSyCjle5TSSjk8BnEI_mBrwAtVxrefVCMJAU"; // 🔥 ใส่ API Key ของคุณ

//   late BitmapDescriptor arrowIcon;

//   @override
//   void initState() {
//     super.initState();
//     _loadArrowIcon();
//     _getCurrentLocation();
//   }

//   Future<void> _loadArrowIcon() async {
//     arrowIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(24, 24)),
//       'assets/arrow_icon.png', // 📌 เพิ่มไฟล์ลูกศรใน assets
//     );
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return;

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever) return;
//     }

//     Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 5,
//       ),
//     ).listen((Position position) {
//       setState(() {
//         _currentPosition = position;
//         _updateMap();
//       });

//       _mapController?.animateCamera(
//         CameraUpdate.newLatLng(
//           LatLng(position.latitude, position.longitude),
//         ),
//       );
//     });
//   }

//   void _updateMap() async {
//     if (_currentPosition == null) return;

//     _markers.clear();
//     _polylines.clear();

//     _markers.add(
//       Marker(
//         markerId: const MarkerId("me"),
//         position:
//             LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//         infoWindow: const InfoWindow(title: "ตำแหน่งของคุณ"),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       ),
//     );

//     _markers.add(
//       Marker(
//         markerId: const MarkerId("farm"),
//         position: LatLng(widget.farmLat, widget.farmLng),
//         infoWindow: const InfoWindow(title: "ตำแหน่งฟาร์ม"),
//       ),
//     );

//     await _getPolyline();
//     setState(() {});
//   }

//   Future<void> _getPolyline() async {
//     if (_currentPosition == null) return;

//     String url =
//         "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${widget.farmLat},${widget.farmLng}&mode=driving&key=$_apiKey";

//     final response = await http.get(Uri.parse(url));
//     final data = json.decode(response.body);

//     if (data['routes'].isNotEmpty) {
//       polylineCoordinates.clear();
//       String encodedPolyline = data['routes'][0]['overview_polyline']['points'];

//       List<PointLatLng> decodedPoints =
//           PolylinePoints().decodePolyline(encodedPolyline);
//       polylineCoordinates =
//           decodedPoints.map((e) => LatLng(e.latitude, e.longitude)).toList();

//       // 🔵 วาด Polyline
//       _polylines.add(
//         Polyline(
//           polylineId: const PolylineId("route"),
//           color: Colors.blue,
//           width: 5,
//           points: polylineCoordinates,
//         ),
//       );

//       _addArrowMarkers(); // ✅ เพิ่มลูกศร

//       if (data['routes'][0]['legs'].isNotEmpty) {
//         var leg = data['routes'][0]['legs'][0];
//         String distance = leg['distance']['text'];
//         String duration = leg['duration']['text'];
//         setState(() {
//           _travelInfo = "📍 ระยะทาง: $distance | ⏳ เวลาถึง: $duration";
//         });
//       }

//       setState(() {});
//     }
//   }

//   void _addArrowMarkers() {
//     for (int i = 0; i < polylineCoordinates.length - 1; i += 5) {
//       double bearing = _calculateBearing(
//         polylineCoordinates[i],
//         polylineCoordinates[i + 1],
//       );

//       _markers.add(
//         Marker(
//           markerId: MarkerId("arrow_$i"),
//           position: polylineCoordinates[i],
//           icon: arrowIcon,
//           rotation: bearing,
//         ),
//       );
//     }
//   }

//   double _calculateBearing(LatLng start, LatLng end) {
//     double lat1 = start.latitude * pi / 180;
//     double lat2 = end.latitude * pi / 180;
//     double lonDiff = (end.longitude - start.longitude) * pi / 180;

//     double y = sin(lonDiff) * cos(lat2);
//     double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lonDiff);
//     return (atan2(y, x) * 180 / pi + 360) % 360;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("🚗 GPS นำทางแบบเรียลไทม์")),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//             },
//             initialCameraPosition: CameraPosition(
//               target: LatLng(widget.farmLat, widget.farmLng),
//               zoom: 14,
//             ),
//             markers: _markers,
//             polylines: _polylines,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//           ),
//           Positioned(
//             top: 10,
//             left: 10,
//             right: 10,
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 _travelInfo,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:geolocator/geolocator.dart';

// class MapScreen extends StatefulWidget {
//   final double farmLat;
//   final double farmLng;

//   const MapScreen({Key? key, required this.farmLat, required this.farmLng})
//       : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   List<LatLng> polylineCoordinates = [];
//   Position? _currentPosition;
//   StreamSubscription<Position>? _positionStream;
//   double? distanceKm;
//   double? durationMinutes;

//   @override
//   void initState() {
//     super.initState();
//     _checkGPSPermission();
//     _trackLocation();
//   }

//   @override
//   void dispose() {
//     _positionStream?.cancel();
//     super.dispose();
//   }

//   void _trackLocation() {
//     _positionStream = Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 10,
//       ),
//     ).listen((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });
//       _getRoute();
//     });
//   }

//   Future<void> _checkGPSPermission() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       print("❌ GPS ปิดอยู่ กรุณาเปิด GPS ก่อน");
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       print("⚠️ กำลังขอสิทธิ์...");
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever) {
//         print("🚫 ต้องเปิดสิทธิ์เองใน Settings");
//       }
//     }

//     if (permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always) {
//       print("✅ ได้รับสิทธิ์ GPS แล้ว!");
//     }
//   }

//   Future<void> _getRoute() async {
//     if (_currentPosition == null) return;

//     String url =
//         "https://router.project-osrm.org/route/v1/driving/${_currentPosition!.longitude},${_currentPosition!.latitude};${widget.farmLng},${widget.farmLat}?overview=full&geometries=geojson";

//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       List coordinates = data['routes'][0]['geometry']['coordinates'];
//       double distance = data['routes'][0]['distance'] / 1000; // แปลงเป็นกม.
//       double duration = data['routes'][0]['duration'] / 60; // แปลงเป็นนาที

//       setState(() {
//         polylineCoordinates =
//             coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
//         distanceKm = distance;
//         durationMinutes = duration;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("🚗 นำทางฟรีด้วย OSM")),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: _currentPosition == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : FlutterMap(
//                     options: MapOptions(
//                       initialCenter: LatLng(_currentPosition!.latitude,
//                           _currentPosition!.longitude),
//                       initialZoom: 14,
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate:
//                             "https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}",
//                         subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
//                       ),
//                       PolylineLayer(
//                         polylines: [
//                           Polyline(
//                             points: polylineCoordinates,
//                             color: Colors.blue,
//                             strokeWidth: 4.0,
//                           ),
//                         ],
//                       ),
//                       MarkerLayer(
//                         markers: [
//                           Marker(
//                             width: 40,
//                             height: 40,
//                             point: LatLng(_currentPosition!.latitude,
//                                 _currentPosition!.longitude),
//                             child: const Icon(Icons.person_pin_circle,
//                                 color: Colors.blue, size: 40),
//                           ),
//                           Marker(
//                             width: 40,
//                             height: 40,
//                             point: LatLng(widget.farmLat, widget.farmLng),
//                             child: const Icon(Icons.location_pin,
//                                 color: Colors.red, size: 40),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "📍 รายละเอียดเส้นทาง",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text("🟢 จุดเริ่มต้น: ตำแหน่งปัจจุบัน"),
//                   const Text("🔴 จุดหมาย: ฟาร์ม"),
//                   const SizedBox(height: 10),
//                   Text(
//                       "🛣️ ระยะทาง: ${distanceKm?.toStringAsFixed(2) ?? '...'} กม."),
//                   Text(
//                       "⏳ เวลาเดินทาง: ${durationMinutes?.toStringAsFixed(0) ?? '...'} นาที"),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  final double farmLat;
  final double farmLng;

  const MapScreen({Key? key, required this.farmLat, required this.farmLng})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _routeCoords = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _markers.add(Marker(
        markerId: const MarkerId("current"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
      _markers.add(Marker(
        markerId: const MarkerId("farm"),
        position: LatLng(widget.farmLat, widget.farmLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });

    _getRoute(); // ดึงเส้นทางจาก Google Directions API

    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude), 14));
  }

  Future<void> _getRoute() async {
    if (_currentPosition == null) return;

    String url = "https://routes.googleapis.com/directions/v2:computeRoutes";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": "YOUR_GOOGLE_MAPS_API_KEY",
        "X-Goog-FieldMask": "routes.polyline.encodedPolyline"
      },
      body: jsonEncode({
        "origin": {
          "location": {
            "latLng": {
              "latitude": _currentPosition!.latitude,
              "longitude": _currentPosition!.longitude
            }
          }
        },
        "destination": {
          "location": {
            "latLng": {"latitude": widget.farmLat, "longitude": widget.farmLng}
          }
        },
        "travelMode": "DRIVE"
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["routes"] != null && data["routes"].isNotEmpty) {
        String encodedPolyline =
            data["routes"][0]["polyline"]["encodedPolyline"];
        List<LatLng> routeCoords = _decodePolyline(encodedPolyline);

        setState(() {
          _routeCoords = routeCoords;
          _polylines.clear();
          _polylines.add(Polyline(
            polylineId: const PolylineId("route"),
            color: Colors.blue,
            width: 5,
            points: routeCoords,
          ));
        });

        _mapController?.animateCamera(
          CameraUpdate.newLatLngBounds(_getLatLngBounds(routeCoords), 50),
        );
      } else {
        print("No routes found.");
      }
    } else {
      print("Error: ${response.statusCode}");
      print(response.body);
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += deltaLng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  LatLngBounds _getLatLngBounds(List<LatLng> points) {
    double south = points.first.latitude;
    double north = points.first.latitude;
    double west = points.first.longitude;
    double east = points.first.longitude;

    for (LatLng point in points) {
      if (point.latitude < south) south = point.latitude;
      if (point.latitude > north) north = point.latitude;
      if (point.longitude < west) west = point.longitude;
      if (point.longitude > east) east = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🚗 Google Maps Navigation")),
      body: Column(
        children: [
          // ครึ่งจอแรก: Google Maps
          Expanded(
            flex: 1, // กำหนดให้ครึ่งหนึ่งของจอ
            child: _currentPosition == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      zoom: 14,
                    ),
                    mapType: MapType.satellite, // 🌍 ใช้แผนที่ดาวเทียม
                    markers: _markers,
                    polylines: _polylines,
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                  ),
          ),

          Expanded(
            flex: 1, // ครึ่งหนึ่งของจอ
            child: Container(
              color: Colors.white, // พื้นหลังสีขาว
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                // ทำให้เลื่อนได้
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // หัวข้อหลัก
                    const Text(
                      "งานตัดอ้อย",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "รถตัดอ้อยขนาดใหญ่ รุ่น CH570",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    Text(
                      "ประเภท รถตัดอ้อย",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),

                    const Divider(thickness: 1, color: Colors.grey),
                    const SizedBox(height: 16),

                    // เวลางาน
                    const Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.black54),
                        SizedBox(width: 8),
                        Text("3/9/2024 09.00 → 3/9/2024 19.00",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // สถานที่
                    const Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.black54),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "ตำบลนาคำ อำเภอนาคำ จังหวัดสงขลา\n16/50 บ้านนาคำ ที่ติดถนนตรงข้ามร้านขายของชำ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // เบอร์โทรศัพท์ + ปุ่มดูข้อมูลผู้จ้าง
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.black54),
                        const SizedBox(width: 8),
                        const Text("0958888888",
                            style: TextStyle(fontSize: 16)),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                            'assets/images/Logo.png'), // เปลี่ยนเป็น URL หรือ NetworkImage ได้
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        "สมชาย มงคล", // ชื่อผู้จ้าง
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "095-888-8888", // เบอร์โทรศัพท์
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text("ปิด"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("ข้อมูลผู้จ้าง"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // จำนวนไร่
                    const Row(
                      children: [
                        Icon(Icons.agriculture, color: Colors.black54),
                        SizedBox(width: 8),
                        Text("จำนวน 14 ไร่", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Text(
                      "รายละเอียดงาน ตัดอ้อย 14 ไร่ ต้องการงานที่เร็ว",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),

                    const Divider(thickness: 1, color: Colors.grey),
                    const SizedBox(height: 16),

                    // ค่าจ้าง
                    const Row(
                      children: [
                        Icon(Icons.monetization_on, color: Colors.black54),
                        SizedBox(width: 8),
                        Text("150 บาท/ไร่", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.black,
                            ),
                            child: const Text("กำลังเดินทาง"),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward,
                              color: Colors.black54),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("กำลังทำงาน"),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward,
                              color: Colors.black54),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("ทำงานเสร็จเรียบร้อย"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
