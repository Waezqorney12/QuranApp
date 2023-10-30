import 'dart:convert';

import 'package:al_quran/Model/bacaanDoaModel.dart';
import 'package:al_quran/Model/bacaanNiatModel.dart';
import 'package:al_quran/Model/bacaanSholatModel.dart';
import 'package:al_quran/Model/detailHadisModel.dart';
import 'package:al_quran/Model/detailJuzModel.dart';
import 'package:al_quran/Model/detailSurahModel.dart';
import 'package:al_quran/Model/listSurahModel.dart';
import 'package:al_quran/Model/namaJuzModel.dart';
import 'package:al_quran/Model/tokohHadistModel.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:al_quran/Model/listTafsirModel.dart';
import 'package:logger/logger.dart';

class ServiceClass {
  Logger log = Logger();
  Future<List> getServiceSholat() async {
    List dataBacaanSholat = [];

    final json = await rootBundle.loadString("assets/datas/listSholat.json");
    List dataJson = jsonDecode(json);

    dataJson.map((value) {
      dataBacaanSholat.add(bacaanSholat.fromJson(value));
    }).toList();

    return dataBacaanSholat;
  }

  Future<List<NiatDoa>> getServiceNiat() async {
    List<NiatDoa> dataBacaanNiat = [];

    final json =
        await rootBundle.loadString("assets/datas/listNiatSholat.json");
    List dataJson = jsonDecode(json);

    dataJson.map((value) {
      dataBacaanNiat.add(NiatDoa.fromJson(value));
    }).toList();

    return dataBacaanNiat;
  }

  Future<List<BacaanDoa>> getDoa() async {
    List<BacaanDoa> bacaanDoas = [];

    final data = await rootBundle.loadString("assets/datas/listDoa.json");

    List parseData = jsonDecode(data);

    parseData.map((value) {
      bacaanDoas.add(BacaanDoa.fromJson(value));
    }).toList();

    return bacaanDoas;
  }

  Future<List<TokohHadist>> getTokoh() async {
    List<TokohHadist> tokohHadist = [];

    final url =
        await rootBundle.loadString("assets/datas/listTokohHadist.json");

    List data = jsonDecode(url);

    data.map((value) {
      tokohHadist.add(TokohHadist.fromJson(value));
    }).toList();

    return tokohHadist;
  }

  Future<List<namaJuz>> getNamaJuz() async {
    List<namaJuz> data = [];
    final url = await rootBundle.loadString("assets/datas/listAyatJuz.json");

    List dataParse = jsonDecode(url);
    dataParse
        .map((value) => {
              data.add(namaJuz.fromJson(value)),
            })
        .toList();

    return data;
  }

  Future<List<Surah>> getSurahList() async {
    final data = await rootBundle.loadString("assets/datas/listSurah.json");

    return surahFromJson(data);
  }

  Future<TafsirQuran> getTafsirQuran() async {
    final url = Uri.parse("https://equran.id/api/v2/tafsir/1");
    final data = await http.get(url);
    
    Map<String, dynamic> parseData = (jsonDecode(data.body)as Map<String, dynamic>)["data"] ;
    
    return TafsirQuran.fromJson(parseData);
  }
  
  Future<DetailHadis> getHadist(String buku, int nomor) async{
    final url = Uri.parse("https://api.hadith.gading.dev/books/$buku/$nomor");
    final data = await http.get(url);

    Map<String, dynamic> parseData = (jsonDecode(data.body) as Map<String, dynamic>)["data"];

    return DetailHadis.fromJson(parseData);
  }


  Future<DetailClass> getDetailSurah({required dynamic nomor}) async {
    final url =
        Uri.parse("https://equran.id/api/v2/surat/$nomor");
    final res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

        print(" Ini parseData: $data");
    // DetailClass datas = DetailClass.fromJson(data);
    return DetailClass.fromJson(data);
  }

  
  Future<DetailJuz> getDetailJuz({required dynamic nomor}) async {
  final url = Uri.parse("https://api.quran.gading.dev/juz/$nomor");
  final data = await http.get(url);

  Map<String, dynamic> parseData = (jsonDecode(data.body) as Map<String, dynamic>)["data"];
  return DetailJuz.fromJson(parseData);
}

  Future  getAsmaulHusna() async {
    
    final url = await http.get(Uri.parse("https://asmaul-husna-api.vercel.app/api/all"));
    List parse = jsonDecode(url.body)["data"];
    
    return parse;
  // List<AsmaulHusna> dataKita = [];
  // final url = await rootBundle.loadString("assets/datas/asmaulHusna.json");

  // List data = jsonDecode(url);
  // print(data);
  // data.map((e) => {
  //   dataKita.add(AsmaulHusna.fromJson(e))
  // }).toList();

  // return dataKita;

}

}
