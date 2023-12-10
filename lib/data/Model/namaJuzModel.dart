import 'dart:convert';


List<namaJuz> namaJuzFromJson(String str)=>
  List<namaJuz>.from(jsonDecode(str).map((x) => namaJuz.fromJson(x)));

//Jika ingin mengirim POST
String namaJuzToJson(List<namaJuz> data) =>
  jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class namaJuz {
  final int id;
  final String ket;

  namaJuz({required this.id, required this.ket});

  factory namaJuz.fromJson(Map<String, dynamic> json) {
    return namaJuz(id: json["id"], ket: json["ket"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "ket": ket};
}
