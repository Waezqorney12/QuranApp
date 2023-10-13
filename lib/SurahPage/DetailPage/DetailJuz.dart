import 'dart:developer';

import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:al_quran/Model/detailJuzModel.dart';

class DetailJuzs extends StatelessWidget {
  dynamic nomorJuz;
  DetailJuzs({super.key, required this.nomorJuz});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailJuz>(
      future: ServiceClass().getDetailJuz(nomor: nomorJuz),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: PaletWarna.background,
            body: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: PaletWarna.unguMuda,
                  ),
                  poppinText(context, "Mohon Tunggu", FontWeight.bold, 14,
                      PaletWarna.unguTeks, 14),
                ],
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: PaletWarna.background,
            body: Center(
              child: poppinText(context, "Data tidak ada", FontWeight.bold, 14,
                  PaletWarna.unguTeks, 14),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: PaletWarna.background,
            body: Center(
              child: poppinText(context, "Error tidak diketahui",
                  FontWeight.bold, 14, PaletWarna.unguTeks, 14),
            ),
          );
        }
        DetailJuz detailJuz = snapshot.data!;
        List<Map<String, dynamic>> detailVerses = detailJuz.verses;

        return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                  ),
                )
              ];
            },
            body: Scaffold(
              backgroundColor: PaletWarna.background,
              body: ListView.separated(
                  itemBuilder: (context, index) {
                   
                      return poppinText(
                          context,
                          "${detailVerses[index]["text"].toString()}\n", // Mengakses properti inQuran
                          FontWeight.bold,
                          14,
                          Colors.white,
                          14);
                    
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.withOpacity(.5),
                    );
                  },
                  itemCount: detailJuz.totalVerses),
            ));
      },
    );
  }
}
