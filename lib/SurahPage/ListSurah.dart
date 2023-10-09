import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/SurahPage/DetailPage/DetailSurah.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon/assetz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/listSurahModel.dart';

class ListSurah extends StatelessWidget {
  const ListSurah({super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: ServiceClass().getSurahList(),
        initialData: [],
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "Data tidak dapat ditemukan",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16 / MediaQuery.textScaleFactorOf(context)),
              ),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withOpacity(.2),
                    height: 5,
                  ),
              itemCount: snapshot.data!.length);
        }));
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      Padding(
        padding: EdgeInsets.only(
            top: Dimensions.height15(context),
            bottom: Dimensions.height5(context)),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailSurah(
                      nomorSurah: surah.nomor,
                    )));
          },
          child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.widht5(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                    SizedBox(
                      height: Dimensions.height36(context),
                      width: Dimensions.widht36(context),
                      child: Center(
                        child: Text(
                          "${surah.nomor}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                14 / MediaQuery.textScaleFactorOf(context),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: Dimensions.height36(context),
                        width: Dimensions.widht36(context),
                        child:
                            Image.asset(assetDart.boxNomor))
                  ]),
                  SizedBox(
                    width: Dimensions.widht10(context),
                  ),
                  SizedBox(
                    height: Dimensions.height50(context),
                    width: Dimensions.widht150(context),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              surah.namaLatin,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    16 / MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              surah.tempatTurun.name,
                              style: GoogleFonts.poppins(
                                color: PaletWarna.unguTeks,
                                fontSize:
                                    12 / MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.widht5(context),
                                  right: Dimensions.widht5(context)),
                              child: Container(
                                width: Dimensions.widht5(context),
                                height: Dimensions.height5(context),
                                decoration: BoxDecoration(
                                    color: PaletWarna.titikIcon,
                                    shape: BoxShape.circle),
                              ),
                            ),
                            Text(
                              "${surah.jumlahAyat} Ayat",
                              style: GoogleFonts.poppins(
                                color: PaletWarna.unguTeks,
                                fontSize:
                                    12 / MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    surah.nama,
                    style: GoogleFonts.amiri(
                        color: PaletWarna.unguIcon,
                        fontWeight: FontWeight.bold,
                        fontSize: 20 / MediaQuery.textScaleFactorOf(context)),
                  ),
                ],
              )),
        ),
      );
}
