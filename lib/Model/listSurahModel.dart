// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<Surah> surahFromJson(String str) =>
    List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

String surahToJson(List<Surah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surah {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  TempatTurun tempatTurun;
  String arti;
  String deskripsi;
  Map<String, String> audioFull;

  Surah(
      {required this.nomor,
      required this.nama,
      required this.namaLatin,
      required this.jumlahAyat,
      required this.tempatTurun,
      required this.arti,
      required this.deskripsi,
      required this.audioFull});
  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      nomor: json["nomor"],
      nama: json["nama"],
      namaLatin: json["namaLatin"],
      jumlahAyat: json["jumlahAyat"],
      tempatTurun: tempatTurunValues.map[json["tempatTurun"]]!,
      arti: json["arti"],
      deskripsi: json["deskripsi"],
      audioFull: Map.from(json["audioFull"])
          .map((key, value) => MapEntry<String, String>(key, value)),
    );
  }

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurunValues.reverse["tempatTurun"],
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull": Map.from(audioFull)
            .map((key, value) => MapEntry<String, dynamic>(key, value))
      };
}

enum TempatTurun { MADINAH, MEKAH }

final tempatTurunValues =
    EnumValues({"Madinah": TempatTurun.MADINAH, "Mekah": TempatTurun.MEKAH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((key, value) => MapEntry(value, key));
    return reverseMap;
  }
}
