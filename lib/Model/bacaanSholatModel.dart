
import 'dart:convert';

List<bacaanSholat> bacaanSholatFromJson(String str) => List<bacaanSholat>.from(json.decode(str).map((x) => bacaanSholat.fromJson(x)));

String bacaanSholatToJson(List<bacaanSholat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// ignore: camel_case_types
class bacaanSholat {
  final int id;
  final String name;
  final String arabic;
  final String latin;
  final String terjemahan;

  bacaanSholat(
      {required this.id,
      required this.name,
      required this.arabic,
      required this.latin,
      required this.terjemahan});

  factory bacaanSholat.fromJson(Map<String, dynamic> json) {
    return bacaanSholat(
        id: json["id"],
        name: json["name"],
        arabic: json["arabic"],
        latin: json["latin"],
        terjemahan: json["terjemahan"]);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name" : name,
    "arabic" : arabic,
    "latin" : latin,
    "terjemahan" : terjemahan
  };
}
