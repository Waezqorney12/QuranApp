import 'package:al_quran/Model/detailSurahModel.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';


class DatabaseManager {
  static Future createTable(sql.Database database) async {
    return await database.execute("""CREATE TABLE bookmark(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      surah TEXT NOT NULL,
      nomorAyat INTEGER NOT NULL,
      index_ayat INTEGER NOT NULL,
      last_read INTEGER NOT NULL
      )
      """);
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase(
      "bookmarks.db",
      version: 1,
      onCreate: (sql.Database database, version) async{
        return await createTable(database);
      },
    );
  }

  static Future<int> createBookmark(DetailClass surah,Ayat ayat,int indexAyat,bool lastRead) async{
    final db = await DatabaseManager.db();
    final data = {
      "surah": surah.namaLatin,
      "nomorAyat": ayat.nomorAyat,
      "index_ayat": indexAyat,
      "last_read": lastRead == true ? 1 : 0
    };
    final id = await db.insert("bookmark", data, conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getBookmark() async{
    final db = await DatabaseManager.db();
    return db.query("bookmark", orderBy: "id");
  }

  static Future<void> deleteBookmark(int id) async{
    final db = await DatabaseManager.db();
    try {
      await db.delete("bookmark", where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went error: $e");
    }
  }
}
