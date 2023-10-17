import 'dart:developer';

import 'package:al_quran/AppBar/AppBar.dart';
import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon_image/assetz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:al_quran/Model/detailJuzModel.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

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
                appBar: AppBarClass(teks: "Juz ${detailJuz.juz}",images: assetDart.search,),
                backgroundColor: PaletWarna.background,
                body: ListView.separated(
                    itemBuilder: (context, index) {
                      Id id = Id.fromJson(detailVerses[index]["tafsir"]["id"]);
                      Texts texts = Texts.fromJson(detailVerses[index]["text"]);
                      Transliteration transliteration =
                          Transliteration.fromJson(
                              detailVerses[index]["text"]["transliteration"]);
                      Numbers numbers =
                          Numbers.fromJson(detailVerses[index]["number"]);
                      Translation translation = Translation.fromJson(
                          detailVerses[index]["translation"]);

                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: PaletWarna.navigation,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            builder: (context) {
                              return SizedBox(
                                height: 400,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                        top: -30,
                                        left: 50,
                                        right: 50,
                                        child: Container(
                                          height: Dimensions.height50(context),
                                          width: Dimensions.widht50(context),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: PaletWarna.unguTuaTerang),
                                          child: Center(
                                            child: poppinText(
                                                context,
                                                "Page: ${detailVerses[index]["meta"]["page"]}",
                                                FontWeight.bold,
                                                20,
                                                PaletWarna.putihTeks,
                                                20),
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.height40(context)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.widht10(
                                                    context)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  size: 30,
                                                  Icons.play_arrow_outlined,
                                                  color: PaletWarna.unguIcon,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.widht10(
                                                      context),
                                                ),
                                                poppinText(
                                                    context,
                                                    "Play Muratal",
                                                    FontWeight.normal,
                                                    16,
                                                    PaletWarna.putihTeks,
                                                    16)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: Dimensions.height15(
                                                    context),
                                                horizontal: Dimensions.widht10(
                                                    context)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  size: 30,
                                                  Icons.share_outlined,
                                                  color: PaletWarna.unguIcon,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.widht10(
                                                      context),
                                                ),
                                                poppinText(
                                                    context,
                                                    "Share Ayat",
                                                    FontWeight.normal,
                                                    16,
                                                    PaletWarna.putihTeks,
                                                    16)
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Title(
                                                      color:
                                                          PaletWarna.background,
                                                      child: poppinText(
                                                          context,
                                                          "Tafsir Ayat: ${numbers.inSurah}",
                                                          FontWeight.bold,
                                                          16,
                                                          PaletWarna.background,
                                                          16)),
                                                  content: SizedBox(
                                                      height: Dimensions.height450(context),
                                                      width: Dimensions.widht315(context),
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        children: [
                                                          poppinText(
                                                              context,
                                                              id.long,
                                                              FontWeight.normal,
                                                              16,
                                                              PaletWarna
                                                                  .background,
                                                              16),
                                                        ],
                                                      )),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: poppinText(
                                                            context,
                                                            "Close",
                                                            FontWeight.bold,
                                                            16,
                                                            PaletWarna
                                                                .background,
                                                            16)),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.widht10(
                                                          context)),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    size: 30,
                                                    Icons.book_outlined,
                                                    color: PaletWarna.unguIcon,
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.widht10(
                                                        context),
                                                  ),
                                                  poppinText(
                                                      context,
                                                      "Tafsir Ayat",
                                                      FontWeight.normal,
                                                      16,
                                                      PaletWarna.putihTeks,
                                                      16)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.widht20(context)),
                                      child: Container(
                                        width: Dimensions.widht36(context),
                                        height: Dimensions.height36(context),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: PaletWarna.unguTuaTerang
                                              .withOpacity(.7),
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
                                      child: Column(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: Dimensions.height15(context),
                                              right:
                                                  Dimensions.widht15(context)),
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
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.height15(context)),
                                          child: SizedBox(
                                            width: Dimensions.widht326(context),
                                            child: poppinText(
                                                context,
                                                transliteration.en.toString(),
                                                FontWeight.normal,
                                                16,
                                                PaletWarna.unguMuda
                                                    .withOpacity(.85),
                                                16),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  Dimensions.height15(context)),
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

  Future<void> playAudio(
    String? audioUrl,
  ) async {
    AudioPlayer player = AudioPlayer();
    if (audioUrl != null) {
      try {
        await player.setUrl(audioUrl);
        await player.play();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui ${e.message}",
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui ${e.message}",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui $e",
        );
      }

      // Catching errors during playback (e.g. lost network connection)
      player.playbackEventStream.listen((event) {},
          onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          Get.defaultDialog(
            title: "Error",
            middleText: "Error tidak diketahui ${e.message}",
          );
        } else {
          Get.defaultDialog(
            title: "Error",
            middleText: "Error tidak diketahui $e",
          );
        }
      });
    }
  }
}
