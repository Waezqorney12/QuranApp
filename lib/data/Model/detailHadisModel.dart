// To parse this JSON data, do
//
//     final detailHadis = detailHadisFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DetailHadis detailHadisFromJson(String str) => DetailHadis.fromJson(json.decode(str));

class DetailHadis {
    final DataHadist data;
    final bool error;

    DetailHadis({
        required this.data,
        required this.error,
    });

    factory DetailHadis.fromJson(Map<String, dynamic> json) => DetailHadis(
        data: DataHadist.fromJson(json) ,
        error: json["error"] ?? false,
    );

}

class DataHadist {
    final String name;
    final String id;
    final int available;
    final Contents contents;

    DataHadist({
        required this.name,
        required this.id,
        required this.available,
        required this.contents,
    });

    factory DataHadist.fromJson(Map<String, dynamic> json) => DataHadist(
        name: json["name"],
        id: json["id"],
        available: json["available"],
        contents: Contents.fromJson(json["contents"]),
    );


}

class Contents {
    final int number;
    final String arab;
    final String id;

    Contents({
        required this.number,
        required this.arab,
        required this.id,
    });

    factory Contents.fromJson(Map<String, dynamic> json) => Contents(
        number: json["number"],
        arab: json["arab"],
        id: json["id"],
    );

}
