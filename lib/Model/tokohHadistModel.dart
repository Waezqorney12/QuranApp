import 'dart:convert';

List<TokohHadist> tokohHadistFromJson(String str)=>List<TokohHadist>.from(jsonDecode(str).map((x) => TokohHadist.fromJson(x)));

String tokohHadistToJson(List<TokohHadist> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));
class TokohHadist {
  final int nomor;
  final String name;
  final String id;
  final int available;

  TokohHadist({required this.nomor,required this.name, required this.id, required this.available});

  factory TokohHadist.fromJson(Map<String, dynamic> json) {
    return TokohHadist(
        nomor: json["nomor"],
        name: json["name"], 
        id: json["id"], 
        available: json["available"]);
  }

  Map<String, dynamic> toJson() =>
      {
        "nomor": nomor,
        "name": name, 
        "id": id, 
        "available": available};
}
