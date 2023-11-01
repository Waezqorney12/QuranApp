import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Model/detailSurahModel.dart';
import 'package:al_quran/Model/listSurahModel.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/Service/SongService.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class DetailSurah extends StatefulWidget {
  late int? nomorSurah;

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
  bool sebelum = false;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailClass>(
      future: ServiceClass().getDetailSurah(nomor: widget.nomorSurah),
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

        return _getAyat(context, surah);
      },
    );
  }

  Scaffold _getAyat(BuildContext context, DetailClass surah) {
    return Scaffold(
      bottomNavigationBar: PreferredSize(
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
                    onTap: (surah.suratSebelumnya is bool)? (){} : () {
                      setState(() {
                        if (surah.suratSebelumnya is Map<String, dynamic>) {
                          final surahSebelumnya =
                              SuratSenya.fromJson(surah.suratSebelumnya);
                          final nomorSurahSebelumnya = surahSebelumnya.nomor;
                          widget.nomorSurah = nomorSurahSebelumnya;
                        } 
                      });
                    },
                    child: (surah.suratSebelumnya is bool) 
                    ? const SizedBox() 
                    : const Icon(Icons.arrow_left,color: Colors.white,size: 40,),
                  ),

                  const Spacer(),

                  InkWell(
                      onTap: (surah.suratSelanjutnya is bool) 
                      ? (){} 
                      : () {
                        setState(() {
                        if (surah.suratSelanjutnya is Map<String, dynamic>) {
                          final surahSelanjutnya = SuratSenya.fromJson(surah.suratSelanjutnya);
                          final nomorSurahSelanjutnya = surahSelanjutnya.nomor;
                          widget.nomorSurah = nomorSurahSelanjutnya;
                        } 
                        });
                      },
                      child: (surah.suratSelanjutnya is bool) 
                      ? const SizedBox() 
                      : const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 40,
                      ))
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
              return _ayat(context: context, ayat: ayat, surah: surah
                  // surats: surats
                  );
            },
          ),
        ),
      ),
    );
  }

  Padding _ayat(
      {required BuildContext context,
      required Ayat ayat,
      required DetailClass surah}) {
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
                  Song().playAudio(ayat.audio["05"]);
                }, Icons.play_arrow_outlined),
                _buttonIcon(() {
                  Song().stopAudio(ayat.audio["05"]);
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
            Song().playAudio(surah.audioFull["05"]);
          },
        ),
        IconButton(
          icon: const Icon(Icons.stop_rounded),
          onPressed: () {
            Song().stopAudio(surah.audioFull["05"]);
          },
        ),
      ],
    );
  }
}
