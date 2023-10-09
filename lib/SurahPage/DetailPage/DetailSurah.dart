import 'dart:convert';

import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Model/detailSurahModel.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class DetailSurah extends StatefulWidget {
  late  int? nomorSurah;

  DetailSurah({
    Key? key,
    this.nomorSurah,
  }) : super(key: key);

  @override
  _DetailSurahState createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
// Inisialisasi status pemutaran audio
  final player = AudioPlayer();

  
  Future<DetailClass> _getDetailSurah() async {
    final url =
        Uri.parse("https://equran.id/api/v2/surat/${widget.nomorSurah}");
    final res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

        print(" Ini parseData: $data");
    // DetailClass datas = DetailClass.fromJson(data);
    return DetailClass.fromJson(data);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logger = Logger();

    return FutureBuilder<DetailClass>(
      future: _getDetailSurah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan loading spinner
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Menampilkan pesan kesalahan
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text("Terjadi kesalahan: ${snapshot.error}"),
            ),
          );
        } else if (!snapshot.hasData) {
          // Menampilkan tampilan ketika data masih kosong
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text("Data tidak tersedia"),
            ),
          );
        }

        // Data berhasil diambil, lanjutkan dengan menampilkan konten
        DetailClass surah = snapshot.data!;
        if (surah.suratSebelumnya is SuratSenya &&
            surah.suratSelanjutnya is SuratSenya) {
          final surahSebelumya = surah.suratSebelumnya as SuratSenya;
          final nomorSurahSebelumnya = surahSebelumya.nomor;
          final surahSelanjutnya = surah.suratSelanjutnya as SuratSenya;
          final nomorSurahSelanjutnya = surah.nomor;
        }
        return _getAyat(context, surah);
      },
    );
  }

  Scaffold _getAyat(BuildContext context, DetailClass surah) {
    return Scaffold(
      bottomNavigationBar:
          PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Material(
              elevation: 3,
              child: Container(
                height: Dimensions.height50(context),
                width: MediaQuery.of(context).size.width,
                color: PaletWarna.backgroundNavigation,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          if (surah.suratSebelumnya["nomor"] < 1) {
                            surah.suratSebelumnya = 0;
                            widget.nomorSurah = 1;
                          } else {
                            widget.nomorSurah = surah.suratSebelumnya["nomor"] ;
                          player.dispose();
                          }
                          
                        });
                      },
                      child: const Icon(Icons.arrow_left,color: Colors.white,size:40,)),
                    const Spacer(),
                    InkWell(
                      onTap: (){
                        setState(() {
                          widget.nomorSurah = surah.suratSelanjutnya["nomor"] ;
                          player.dispose();
                        });
                      },
                      child: const Icon(Icons.arrow_right,color: Colors.white,size:40,))
                  ],
                ),
              ),
            )),
      appBar: appBar(context: context, surah: surah),
      backgroundColor: PaletWarna.background,
      body: Center(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: _detail(context: context, surah: surah),
            ),
          ],
          body: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.white.withOpacity(.1),
              );
            },
            itemCount: surah.jumlahAyat,
            itemBuilder: (context, index) {
              final Ayat ayat = surah.ayat[index];
              return _ayat(
                context: context,
                ayat: ayat,
                surah: surah
                // surats: surats
              );
            },
          ),
        ),
      ),
    );
  }

  Padding _ayat({required BuildContext context, required Ayat ayat, required DetailClass surah}) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.widht30(context),
        left: Dimensions.widht30(context),
        bottom: Dimensions.height5(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: Dimensions.height5(context),
          ),
          Container(
            width: Dimensions.widht326(context),
            height: Dimensions.height50(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PaletWarna.navigation,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.widht15(context)),
                  child: Container(
                    width: Dimensions.widht36(context),
                    height: Dimensions.height36(context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: PaletWarna.unguIcon,
                    ),
                    child: Center(
                      child: poppinText(
                        context,
                        ayat.nomorAyat.toString(),
                        FontWeight.w500,
                        10,
                        Colors.white,
                        10,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                _buttonIcon(
                  () {},
                  Icons.share_outlined,
                ),
                _buttonIcon(() {
                  _playAudio(ayat.audio["05"]);
                }, Icons.play_arrow_outlined),
                _buttonIcon(() {
                  _stopAudio(ayat.audio["05"]);
                }, Icons.bookmark_outline),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height24(context)),
          _teksAyat(
            context,
            ayat,
            ayat.teksArab,
            FontWeight.bold,
            Colors.white,
            TextAlign.end,
            24,
            padding: EdgeInsets.only(bottom: Dimensions.height20(context)),
          ),
          SizedBox(
            width: Dimensions.widht326(context),
            child: _teksAyat(
              context,
              ayat,
              ayat.teksLatin,
              FontWeight.normal,
              PaletWarna.unguMuda,
              TextAlign.start,
              18,
              padding: EdgeInsets.only(bottom: Dimensions.height10(context)),
            ),
          ),
          SizedBox(
            width: Dimensions.widht326(context),
            child: _teksAyat(
              context,
              ayat,
              ayat.teksIndonesia,
              FontWeight.normal,
              PaletWarna.unguTeks,
              TextAlign.start,
              18,
            ),
          ),
          
        ],
      ),
    );
  }

  Padding _teksAyat(
    BuildContext context,
    Ayat ayat,
    String teks,
    FontWeight fontWeight,
    Color color,
    TextAlign textAlign,
    double fontSize, {
    EdgeInsetsGeometry? padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        teks,
        style: GoogleFonts.amiri(
          color: color,
          fontSize: fontSize / MediaQuery.textScaleFactorOf(context),
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      ),
    );
  }
  

  IconButton _buttonIcon(
    VoidCallback? buttonAction,
    IconData icons,
  ) {
    return IconButton(
      onPressed: buttonAction,
      icon: Icon(
        icons, // Gunakan isPlaying di sini
        color: PaletWarna.unguIcon,
      ),
    );
  }

  Widget _detail({required BuildContext context, required DetailClass surah}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.height40(context)),
      child: Column(
        children: [
          Container(
            width: Dimensions.widht326(context),
            height: Dimensions.height280(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [PaletWarna.unguMuda, PaletWarna.unguTuaTerang],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child:
                      Image.asset("assets/png/Bewarna/QuranOpacityColor.png"),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height20(context),
                      ),
                      poppinText(
                        context,
                        surah.namaLatin,
                        FontWeight.w500,
                        22,
                        Colors.white,
                        22,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Dimensions.height4(context),
                          bottom: Dimensions.height10(context),
                        ),
                        child: poppinText(
                          context,
                          "The Opening",
                          FontWeight.w500,
                          16,
                          Colors.white,
                          16,
                        ),
                      ),
                      Divider(
                        indent: 50,
                        endIndent: 50,
                        color: Colors.white.withOpacity(.5),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Dimensions.height10(context),
                          bottom: Dimensions.height10(context),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            poppinText(
                              context,
                              surah.tempatTurun,
                              FontWeight.w500,
                              14,
                              Colors.white,
                              14,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.widht3(context),
                              ),
                              child: Container(
                                height: Dimensions.height5(context),
                                width: Dimensions.widht5(context),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(.8),
                                ),
                              ),
                            ),
                            poppinText(
                              context,
                              "${surah.jumlahAyat} Ayat",
                              FontWeight.w500,
                              14,
                              Colors.white,
                              14,
                            ),
                          ],
                        ),
                      ),
                      Image.asset("assets/png/Bewarna/BismillahColor.png"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar({required BuildContext context, required DetailClass surah}) {
    return AppBar(
      toolbarHeight: Dimensions.height80(context),
      elevation: 0,
      backgroundColor: PaletWarna.background,
      title: Padding(
        padding: EdgeInsets.only(left: Dimensions.widht24(context)),
        child: Text(
          surah.namaLatin,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ).copyWith(
            fontSize: 20 / MediaQuery.textScaleFactorOf(context),
            color: Colors.white, // Sesuaikan warna teks
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.play_arrow_outlined),
          onPressed: () {
            _playAudio(surah.audioFull["05"]);
          },
        ),
        IconButton(
          icon: const Icon(Icons.stop_rounded),
          onPressed: () {},
        ),
      ],
    );
  }
Future<void> _playAudio(String? audioUrl, ) async {
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
  Future<void> _stopAudio(String? audioUrl, ) async {
    if (audioUrl != null) {
      try {
        await player.setUrl(audioUrl);
        await player.stop();
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
