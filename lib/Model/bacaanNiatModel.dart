

import 'dart:convert';
List<NiatDoa> niatDoaFromJson(String str) => List<NiatDoa>.from(json.decode(str).map((x) => NiatDoa.fromJson(x)));

String niatDoaToJson(List<NiatDoa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NiatDoa {
  final int id;
  final String name;
  final String arabic;
  final String latin;
  final String terjemahan;

  NiatDoa(
      {required this.id,
      required this.name,
      required this.arabic,
      required this.latin,
      required this.terjemahan});

  factory NiatDoa.fromJson(Map<String, dynamic> json) {
    return NiatDoa(
        id: json["id"],
        name: json["name"],
        arabic: json["arabic"],
        latin: json["latin"],
        terjemahan: json["terjemahan"]);
  }

  Map<String, dynamic> toJson()=>{
    "id":id,
    "name": name,
    "arabic":arabic,
    "latin":latin,
    "terjemahan":terjemahan
  };
}
