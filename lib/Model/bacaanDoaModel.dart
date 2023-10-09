import 'package:meta/meta.dart';
import 'dart:convert';

List<BacaanDoa> bacaanDoaFromJson(String str) => List<BacaanDoa>.from(json.decode(str).map((x) => BacaanDoa.fromJson(x)));

String bacaanDoaToJson(List<BacaanDoa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BacaanDoa {
    String id;
    String doa;
    String ayat;
    String latin;
    String artinya;

    BacaanDoa({
        required this.id,
        required this.doa,
        required this.ayat,
        required this.latin,
        required this.artinya,
    });

    factory BacaanDoa.fromJson(Map<String, dynamic> json) => BacaanDoa(
        id: json["id"],
        doa: json["doa"],
        ayat: json["ayat"],
        latin: json["latin"],
        artinya: json["artinya"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "doa": doa,
        "ayat": ayat,
        "latin": latin,
        "artinya": artinya,
    };
}
