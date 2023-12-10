import 'package:al_quran/common/component/AppBar.dart';
import 'package:al_quran/common/component/Drawer.dart';
import 'package:al_quran/presentation/SurahPage/ListJuz.dart';
import 'package:al_quran/presentation/SurahPage/ListSurah.dart';
import 'package:al_quran/data/SQFLITE/bookmark.dart';
import 'package:al_quran/common/constant/color.dart';
import 'package:al_quran/common/constant/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:al_quran/common/constant/image.dart';

class Surah extends StatefulWidget {
  const Surah({super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  final logger = Logger();
  List <Map<String, dynamic>> bookmark = []; 

  void fetchData() async{
    final data = await DatabaseManager.getBookmark();
    if (data.isNotEmpty) {
      final lastBookmark = data.last;
    setState(() {
        bookmark = [lastBookmark];
    });
    }
  }
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: PaletWarna.background,
        drawer: const DrawerClass(),
        // APP BAR
        appBar: const AppBarClass(
          teks: "Quran App", ),
        body: DefaultTabController(
          length: 2,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.widht24(context)),
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverToBoxAdapter(
                        child: greetings(context),
                      ),
                      SliverAppBar(
                        shape: Border(
                          top: BorderSide(
                            color: Colors.grey.withOpacity(.2),
                            width: 1.5,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(.2),
                            width: 1.5,
                          ),
                        ),
                        automaticallyImplyLeading: false,
                        pinned: true,
                        backgroundColor: PaletWarna.background,
                        bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(0),
                            child: TabBar(
                                indicatorColor: PaletWarna.unguIcon,
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.white,
                                tabs: [
                                  _tabs(context, "Surah", FontWeight.w600, 16,
                                      16),
                                  _tabs(
                                      context, "Juz", FontWeight.w600, 16, 16),
                                ])),
                      )
                    ],
                body: const TabBarView(children: [
                  ListSurah(),
                  ListJuz(),
                ])),
          ),
        ));
  }

  ListTile listIcon(BuildContext context, IconData icon, String teks) {
    return ListTile(
      shape: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.2))),
      title: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Icon(
                  icon,
                  color: PaletWarna.unguIcon,
                )),
            Expanded(
              child: poppinText(context, teks, FontWeight.w500, 16,
                  PaletWarna.unguTeks.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }

  Tab _tabs(BuildContext context, String teks, FontWeight fontWeight,
      double fontSize, double copyFontSize) {
    return Tab(
        child: poppingTextNoColor(
            context, teks, fontWeight, fontSize, copyFontSize));
  }

  

  Column greetings(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: Dimensions.height24(context),
              bottom: Dimensions.height15(context)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.widht5(context)),
                    child: Text("Assalamualaikum",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: PaletWarna.unguTeks.withOpacity(0.8),
                        ).copyWith(
                            fontSize:
                                18 / MediaQuery.textScaleFactorOf(context))),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.widht5(context)),
                    child: Text("Waezqorney",
                        style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: PaletWarna.putihTeks)
                            .copyWith(
                                fontSize: 24 /
                                    MediaQuery.textScaleFactorOf(context))),
                  ),
                ],
              ),
              Stack(
                children: [
                  //BOX QURAN LASTREAD
                  boxQuran(context),
                  imageQuran(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Positioned imageQuran() {
    return Positioned(
        right: 0,
        bottom: 0,
        child: Image.asset(assetDart.Quran)
        );
  }

  Container boxQuran(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height24(context)),
      width: Dimensions.widht326(context),
      height: Dimensions.height131(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors: [PaletWarna.unguMuda, PaletWarna.unguTuaTerang],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: Dimensions.height20(context),
          ),
          Row(
            children: [
              SizedBox(
                width: Dimensions.widht20(context),
              ),
              Image.asset(assetDart.lastRead),
              SizedBox(
                width: Dimensions.widht5(context),
              ),
              Text("Last Read",
                  style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)
                      .copyWith(
                          fontSize:
                              14 / MediaQuery.textScaleFactorOf(context))),
            ],
          ),
          SizedBox(
            height: Dimensions.height20(context),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: Dimensions.widht20(context)),
                  child: Text(
                    bookmark.isNotEmpty ? bookmark[0]["surah"] : "No Boorkmark",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0, // Ukuran font dasar
                      color: Colors.white,
                    ).copyWith(
                        fontSize: 18.0 / MediaQuery.textScaleFactorOf(context)),
                  )),
            ],
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: Dimensions.widht20(context)),
                  child: Text(
                    "Nomor Ayat: ${bookmark.isNotEmpty ? bookmark[0]["nomorAyat"] : " Not found"}",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 0, 
                      color: Colors.white,
                    ).copyWith(
                        fontSize: 10.0 / MediaQuery.textScaleFactorOf(context)),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
