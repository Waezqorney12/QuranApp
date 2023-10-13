
DetailJuz detailJuzFromJson(String str)=> detailJuzFromJson(str);
class DetailJuz {
  int juz;
  int juzStartSurahNumber;
  int juzEndSurahNumber;
  String juzStartInfo;
  String juzEndInfo;
  int totalVerses;
  List<Map<String, dynamic>> verses; // Mengubah tipe menjadi List<Map<String, dynamic>>

  DetailJuz(
      {required this.juz,
      required this.juzStartSurahNumber,
      required this.juzEndSurahNumber,
      required this.juzStartInfo,
      required this.juzEndInfo,
      required this.totalVerses,
      required this.verses});

  factory DetailJuz.fromJson(Map<String, dynamic> json) {
    return DetailJuz(
        juz: json["juz"],
        juzStartSurahNumber: json["juzStartSurahNumber"],
        juzEndSurahNumber: json["juzEndSurahNumber"],
        juzStartInfo: json["juzStartInfo"],
        juzEndInfo: json["juzEndInfo"],
        totalVerses: json["totalVerses"],
        verses: List<Map<String, dynamic>>.from(json["verses"].map((x) => x))); // Mengubah jenis penguraian
  }
}


class Verses {
  List<Numbers> number;
  List<Meta> meta;
  List<Texts> text;
  List<Translation> translation;
  List<Audio> audio;
  List<Tafsirz> tafsirz;

  Verses(
      {required this.number,
      required this.meta,
      required this.text,
      required this.translation,
      required this.audio,
      required this.tafsirz});

  factory Verses.fromJson(Map<String, dynamic> json) {
    return Verses(
        number: List<Numbers>.from(json["number"].map((x) => Numbers.fromJson(x))),
        meta: List<Meta>.from(json["meta"].map((x) => Meta.fromJson(x))),
        text: List<Texts>.from(json["text"].map((x)=>Texts.fromJson(x))),
        translation: List<Translation>.from(json["translation"].map((x)=>Translation.fromJson(x))),
        audio: List<Audio>.from(json["audio"].map((x)=>Audio.fromJson(x))),
        tafsirz: List<Tafsirz>.from(json["tafsir"].map((x) => Tafsirz.fromJson(x))));
  }
}

class Numbers {
    int inQuran;
    int inSurah;

    Numbers({
        required this.inQuran,
        required this.inSurah,
    });

    factory Numbers.fromJson(Map<String, dynamic> json) => Numbers(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
    );

    Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
    };
}

class Meta {
  int juz;
  int page;
  int manzil;
  int ruku;
  int hizQuarter;
  Sajda sajda;

  Meta(
      {required this.juz,
      required this.page,
      required this.manzil,
      required this.ruku,
      required this.hizQuarter,
      required this.sajda});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizQuarter: json["hizQuarter"],
        sajda: Sajda.fromJson(json));
  }
}

class Texts {
  String arab;
  Transliteration transliteration;

  Texts({
    required this.arab, 
    required this.transliteration});

  factory Texts.fromJson(Map<String, dynamic> json) {
    return Texts(
        arab: json["arab"], 
        transliteration: Transliteration.fromJson(json));
  }
}

class Translation {
  String en;
  String id;

  Translation({
    required this.en, 
    required this.id});

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      en: json["en"], 
      id: json["id"]);
  }
}

class Audio {
  String primary;
  List secondary;

  Audio({
    required this.primary, 
    required this.secondary});

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
        primary: json["primary"],
        secondary: List<String>.from(json["secondary"])
        );
  }
}

class Tafsirz {
  Id id;

  Tafsirz({required this.id});

  factory Tafsirz.fromJson(Map<String, dynamic> json) {
    return Tafsirz(
      id: Id.fromJson(json));
  }
}

class Sajda {
  bool recommended;
  bool obligatory;

  Sajda({
    required this.recommended, 
    required this.obligatory});

  factory Sajda.fromJson(Map<String, dynamic> json) {
    return Sajda(
        recommended: json["recommended"] ?? false, 
        obligatory: json["obligatory"] ?? false);
  }
}

class Transliteration {
  String en;

  Transliteration({required this.en});

  factory Transliteration.fromJson(Map<String, dynamic> json) {
    return Transliteration(
      en: json["en"]);
  }
}

class Id {
  String short;
  String long;

  Id({required this.short, required this.long});

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      short: json["short"], 
      long: json["long"]);
  }
}
