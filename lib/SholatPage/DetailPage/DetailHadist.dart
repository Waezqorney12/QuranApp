import 'package:al_quran/AppBar/AppBar.dart';
import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Model/detailHadisModel.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon_image/assetz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailHadist extends StatefulWidget {
  int nomorHadist;
  String namaBuku;
  DetailHadist({super.key, required this.nomorHadist, required this.namaBuku});

  @override
  State<DetailHadist> createState() => _DetailHadistState();
}

class _DetailHadistState extends State<DetailHadist> {
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailHadis>(
        future: ServiceClass().getHadist(widget.namaBuku, widget.nomorHadist),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Scaffold(
                backgroundColor: PaletWarna.background,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      poppinText(context, "Mohon Tunggu", FontWeight.w500, 16,
                          PaletWarna.unguMuda, 16)
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Menampilkan pesan kesalahan
            return Scaffold(
              backgroundColor: PaletWarna.background,
              body: Center(
                child: Text("Terjadi kesalahan: ${snapshot.error}"),
              ),
            );
          } else if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: PaletWarna.background,
              body: Center(
                child: poppinText(context, "Data tidak ditemukan",
                    FontWeight.w500, 16, PaletWarna.unguMuda, 16),
              ),
            );
          }
          DetailHadis hadis = snapshot.data!;

          return _getHadist(
              context: context, dataHadist: hadis.data.contents, hadiss: hadis);
        });
  }

  Scaffold _getHadist(
      {required BuildContext context,
      required Contents dataHadist,
      required DetailHadis hadiss}) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: Dimensions.height80(context),
          elevation: 0,
          backgroundColor: PaletWarna.background,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: Dimensions.widht24(context),
              ),
              child: IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: Image.asset("assets/png/TidakBewarna/Search.png"),
              ),
            ),
          ],
          title: Padding(
            padding: EdgeInsets.only(left: Dimensions.widht24(context)),
            child: Text(
              "Hadist Page",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ).copyWith(
                fontSize: 20 / MediaQuery.textScaleFactorOf(context),
                color: Colors.white, // Sesuaikan warna teks
              ),
            ),
          ),
        ),
        backgroundColor: PaletWarna.background,
        body: Center(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.widht30(context),
                        vertical: Dimensions.height10(context)),
                    child: Container(
                      height: Dimensions.height100(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.purple.withOpacity(.3)),
                      child: Image.asset(assetDart.gambarHadist),
                    ),
                  ),
                ],
              ))
            ],
            body: ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.widht30(context)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          poppinText(context, hadiss.data.name, FontWeight.bold,
                              16, PaletWarna.unguTeks, 16),
                          poppinText(context, " No.${dataHadist.number.toString()}",
                              FontWeight.bold, 16, PaletWarna.unguTeks, 16),
                        ],
                      ),
                      _teksAyat(context,dataHadist,dataHadist.arab,FontWeight.bold,PaletWarna.putihTeks,TextAlign.end,20,
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height20(context))),
                      poppinText(context, dataHadist.id, FontWeight.w500, 16,
                          PaletWarna.unguTeks.withOpacity(.8), 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Padding _teksAyat(
    BuildContext context,
    Contents dataHadist,
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
}
