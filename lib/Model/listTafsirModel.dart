// To parse this JSON data, do
//
//     final tafsirQuran = tafsirQuranFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TafsirQuran tafsirQuranFromJson(String str) => TafsirQuran.fromJson(json.decode(str));

String tafsirQuranToJson(TafsirQuran data) => json.encode(data.toJson());

class TafsirQuran {
    int nomor;
    String nama;
    String namaLatin;
    int jumlahAyat;
    String tempatTurun;
    String arti;
    String deskripsi;
    Map<String, String> audioFull;
    List<Tafsir> tafsir;
    SuratSenya suratSelanjutnya;
    SuratSenya suratSebelumnya;

    TafsirQuran({
        required this.nomor,
        required this.nama,
        required this.namaLatin,
        required this.jumlahAyat,
        required this.tempatTurun,
        required this.arti,
        required this.deskripsi,
        required this.audioFull,
        required this.tafsir,
        required this.suratSelanjutnya,
        required this.suratSebelumnya,
    });

    factory TafsirQuran.fromJson(Map<String, dynamic> json) => TafsirQuran(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
        tempatTurun: json["tempatTurun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: Map.from(json["audioFull"]).map((k, v) => MapEntry<String, String>(k, v)),
        tafsir: List<Tafsir>.from(json["tafsir"].map((x) => Tafsir.fromJson(x))),
        suratSelanjutnya: SuratSenya.fromJson(json["suratSelanjutnya"]),
        suratSebelumnya: SuratSenya.fromJson(json["suratSebelumnya"]),
    );

    Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull": Map.from(audioFull).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "tafsir": List<dynamic>.from(tafsir.map((x) => x.toJson())),
        "suratSelanjutnya": suratSelanjutnya.toJson(),
        "suratSebelumnya": suratSebelumnya.toJson(),
    };
}

class SuratSenya {
    int nomor;
    String nama;
    String namaLatin;
    int jumlahAyat;

    SuratSenya({
        required this.nomor,
        required this.nama,
        required this.namaLatin,
        required this.jumlahAyat,
    });

    factory SuratSenya.fromJson(Map<String, dynamic> json) => SuratSenya(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
    );

    Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
    };
}

class Tafsir {
    int ayat;
    String teks;

    Tafsir({
        required this.ayat,
        required this.teks,
    });

    factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        ayat: json["ayat"],
        teks: json["teks"],
    );

    Map<String, dynamic> toJson() => {
        "ayat": ayat,
        "teks": teks,
    };
}
