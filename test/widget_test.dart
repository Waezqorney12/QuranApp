// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:al_quran/Model/detailSurahModel.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:al_quran/main.dart';

void main() async {
  group('ServiceClass tests', () {
    test('getDetailJuz returns valid data', () async {
      final service = ServiceClass();
      final nomor = 30; // Sesuaikan dengan nomor yang sesuai dengan data tes Anda

      final detailJuz = await service.getDetailJuz(nomor: nomor);

      expect(detailJuz, isNotNull);
      expect(detailJuz.juz, isNotNull);
      expect(detailJuz.juzStartInfo, isNotNull);
      expect(detailJuz.juzEndInfo, isNotNull);

      // Tambahkan pengujian lebih lanjut sesuai dengan kebutuhan Anda
    });
  });
}
