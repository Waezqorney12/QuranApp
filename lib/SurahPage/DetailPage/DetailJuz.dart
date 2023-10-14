import 'dart:developer';

import 'package:al_quran/AppBar/AppBar.dart';
import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: PaletWarna.unguMuda,
                  ),
                  SizedBox(
                    height: Dimensions.height5(context),
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
                appBar: AppBarClass(teks: "Juz ${detailJuz.juz}"),
                backgroundColor: PaletWarna.background,
                body: ListView.separated(
                    itemBuilder: (context, index) {
                      Texts texts = Texts.fromJson(detailVerses[index]["text"]);
                      Transliteration transliteration =
                          Transliteration.fromJson(
                              detailVerses[index]["text"]["transliteration"]);
                      Numbers numbers =
                          Numbers.fromJson(detailVerses[index]["number"]);
                      Translation translation = Translation.fromJson(detailVerses[index]["translation"]);
                      return GestureDetector(
                        onTap: (){
                          showModalBottomSheet(
                            context: context, 
                            backgroundColor: PaletWarna.backgroundNavigation,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                            builder: (context) {
                            return SizedBox(
                              height: 400,
                              child: Column(
                                children: [
                                  Row(
                                    children: [],
                                  )
                                ],
                              ),
                            );
                          },);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: Dimensions.widht30(context),
                            left: Dimensions.widht30(context),
                            bottom: Dimensions.height5(context),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Dimensions.height5(context),
                              ),
                              Container(
                                width: Dimensions.widht326(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: PaletWarna.navigation,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.widht20(context)),
                                      child: Container(
                                        width: Dimensions.widht36(context),
                                        height: Dimensions.height36(context),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: PaletWarna.unguTuaTerang.withOpacity(.7),
                                        ),
                                        child: Center(
                                          child: poppinText(
                                            context,
                                            numbers.inSurah.toString(),
                                            FontWeight.bold,
                                            14,
                                            Colors.white,
                                            14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                    Expanded(
                                      child: Column(
                                        children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: Dimensions.height15(context),right: Dimensions.widht15(context)),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: poppinText(
                                              context,
                                              texts.arab.toString(),
                                              FontWeight.bold,
                                              22,
                                              Colors.white,
                                              22,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: Dimensions.height15(context)),
                                          child: SizedBox(
                                              width: Dimensions.widht326(context),
                                              child: poppinText(
                                                  context,
                                                  transliteration.en.toString(),
                                                  FontWeight.normal,
                                                  16,
                                                  PaletWarna.unguMuda.withOpacity(.85),
                                                  16),
                                                  ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: Dimensions.height15(context)),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: poppinText(
                                              context,
                                              translation.id.toString(),
                                              FontWeight.normal,
                                              16,
                                              PaletWarna.unguTeks,
                                              16,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 0,
                        color: Colors.white,
                      );
                    },
                    itemCount: detailJuz.totalVerses)));
      },
    );
  }
}
