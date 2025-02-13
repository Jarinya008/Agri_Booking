// To parse this JSON data, do
//
//     final getAllTracts = getAllTractsFromJson(jsonString);

import 'dart:convert';

List<GetAllTracts> getAllTractsFromJson(String str) => List<GetAllTracts>.from(
    json.decode(str).map((x) => GetAllTracts.fromJson(x)));

String getAllTractsToJson(List<GetAllTracts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllTracts {
  int mid;
  String username;
  String phone;
  String image;
  String contact;
  String address;
  double lat;
  double lng;
  int mtype;
  int tid;
  String nameTract;
  int amount;
  String price;
  String tractImage;
  int rate;
  String typeNameTract;

  GetAllTracts({
    required this.mid,
    required this.username,
    required this.phone,
    required this.image,
    required this.contact,
    required this.address,
    required this.lat,
    required this.lng,
    required this.mtype,
    required this.tid,
    required this.nameTract,
    required this.amount,
    required this.price,
    required this.tractImage,
    required this.rate,
    required this.typeNameTract,
  });

  factory GetAllTracts.fromJson(Map<String, dynamic> json) => GetAllTracts(
        mid: json["mid"],
        username: json["username"],
        phone: json["phone"],
        image: json["image"],
        contact: json["contact"],
        address: json["address"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        mtype: json["mtype"],
        tid: json["tid"],
        nameTract: json["name_tract"],
        amount: json["amount"],
        price: json["price"],
        tractImage: json["tract_image"],
        rate: json["rate"],
        typeNameTract: json["type_name_tract"],
      );

  Map<String, dynamic> toJson() => {
        "mid": mid,
        "username": username,
        "phone": phone,
        "image": image,
        "contact": contact,
        "address": address,
        "lat": lat,
        "lng": lng,
        "mtype": mtype,
        "tid": tid,
        "name_tract": nameTract,
        "amount": amount,
        "price": price,
        "tract_image": tractImage,
        "rate": rate,
        "type_name_tract": typeNameTract,
      };
}
