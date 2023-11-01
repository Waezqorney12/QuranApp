import 'dart:convert';

DetailClass detailClassFromJson(String str) => DetailClass.fromJson(json.decode(str));

class DetailClass {
    int nomor;
    String nama;
    String namaLatin;
    int jumlahAyat;
    String tempatTurun;
    String arti;
    String deskripsi;
    Map<String, String> audioFull;
    List<Ayat> ayat;
    dynamic suratSelanjutnya;
    dynamic suratSebelumnya;

    DetailClass({
        required this.nomor,
        required this.nama,
        required this.namaLatin,
        required this.jumlahAyat,
        required this.tempatTurun,
        required this.arti,
        required this.deskripsi,
        required this.audioFull,
        required this.ayat,
        required this.suratSelanjutnya,
        required this.suratSebelumnya,
    });

    factory DetailClass.fromJson(Map<String, dynamic> json) => DetailClass(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
        tempatTurun: json["tempatTurun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: Map.from(json["audioFull"]).map((k, v) => MapEntry<String, String>(k, v)),
        ayat: List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x))),
        suratSelanjutnya: json["suratSelanjutnya"] ?? false,
        suratSebelumnya: json["suratSebelumnya"] ?? false,
    );
}

class Ayat {
    int nomorAyat;
    String teksArab;
    String teksLatin;
    String teksIndonesia;
    Map<String, String> audio;

    Ayat({
        required this.nomorAyat,
        required this.teksArab,
        required this.teksLatin,
        required this.teksIndonesia,
        required this.audio,
    });

    factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        nomorAyat: json["nomorAyat"],
        teksArab: json["teksArab"],
        teksLatin: json["teksLatin"],
        teksIndonesia: json["teksIndonesia"],
        audio: Map.from(json["audio"]).map((k, v) => MapEntry<String, String>(k, v)),
    );
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
}
