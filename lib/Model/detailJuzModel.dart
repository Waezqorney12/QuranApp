class DetailJuz {
  int juz;
  int juzStartSurahNumber;
  int juzEndSurahNumber;
  String juzStartInfo;
  String juzEndInfo;
  int totalVerses;
  Verses verses;
  DetailJuz({required this.juz,required this.juzStartSurahNumber,required this.juzEndSurahNumber, required this.juzStartInfo, required this.juzEndInfo, required this.totalVerses, required this.verses});
}

class Verses{
  Number number;
  Meta meta;
  Texts text;
  Translation translation;
  Audio audio;
  Tafsirz tafsirz;

  Verses({required this.number, required this.meta, required this.text, required this.translation, required this.audio, required this.tafsirz});
}

class Number{
  int inQuran;
  int inSurah;

  Number({required this.inQuran, required this.inSurah});
}
class Meta{
  int juz;
  int page;
  int manzil;
  int ruku;
  int hizQuarter;
  Sajda sajda;

  Meta({ required this.juz, required this.page, required this.manzil, required this.ruku, required this.hizQuarter, required this.sajda});
}
class Texts{
  String arab;
  Transliteration transliteration;
  Texts({required this.arab, required this.transliteration});
}
class Translation{
  String en;
  String id;
  Translation({required this.en, required this.id});
}
class Audio{
  String primary;
  Secondary secondary;
  Audio({required this.primary, required this.secondary});
}
class Tafsirz{
  Id id;
  Tafsirz({required this.id});
}
class Sajda{
  bool recommended;
  bool obligatory;

  Sajda({required this.recommended, required this.obligatory});

  factory Sajda.fromJson(Map<String, dynamic> json){
    return Sajda(recommended: json["recommended"], obligatory: json["obligatory"]);
  }
}
class Secondary{

}
class Transliteration{

}
class Id{

}