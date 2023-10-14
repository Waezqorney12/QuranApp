import 'package:al_quran/AppBar/AppBar.dart';
import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/SholatPage/ListSholat/ListNiatDoa.dart';
import 'package:al_quran/SholatPage/ListSholat/ListNiat.dart';
import 'package:al_quran/SholatPage/ListSholat/ListNiatSholat.dart';
import 'package:al_quran/SholatPage/ListSholat/ListHadist.dart';
import 'package:al_quran/geolocator/getCurrentPosition.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:al_quran/library_asset/icon/assetz.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Sholat extends StatefulWidget {
  const Sholat({Key? key}) : super(key: key);

  @override
  _SholatState createState() => _SholatState();
}

class _SholatState extends State<Sholat> {
  bool isLoading = false;

  String pronvisi = "";
  String kecamatan = "";
  String jalan = "";

  String? subuh;
  String? fajr;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;

  double latitude = 0;
  double langitude = 0;

  final dates = DateFormat("EEEEE, dd MMM yyyy").format(DateTime.now());
  final time = DateFormat("hh:mm a").format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDone();
    setState(() {
      dates;
      time;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarClass(teks: "Sholat Page",),
      drawer: const DrawerClass(),
      backgroundColor: PaletWarna.background,
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.widht20(context),
            vertical: Dimensions.height15(context),
          ),
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: _boxJadwal(context),
                    ),
                    SliverAppBar(
                      shape: Border(
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(.3), width: 2),
                          top: BorderSide(
                              color: Colors.grey.withOpacity(.3), width: 2)),
                      pinned: true,
                      backgroundColor: PaletWarna.background,
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(0),
                          child: TabBar(
                              unselectedLabelColor: Colors.grey.withOpacity(.5),
                              indicatorColor: PaletWarna.unguIcon,
                              tabs: [
                                _tabs(context, "Sholat Wajib", FontWeight.w600,
                                    16, 16),
                                _tabs(context, "Niat", FontWeight.w600, 16, 16),
                                _tabs(
                                    context, "Hadist", FontWeight.w600, 16, 16),
                                _tabs(context, "Doa", FontWeight.w600, 16, 16),
                              ])),
                    )
                  ],
              body: const TabBarView(children: [
                ListNiatSholat(),
                ListNiat(),
                ListHadist(),
                ListNiatDoa()
              ])),
        ),
      ),
    );
  }

  Column _boxJadwal(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Dimensions.widht336(context),
          height: Dimensions.height88(context),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: PaletWarna.unguFresh),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _jadwalSholat(assetDart.subuh, "Subuh", subuh.toString()),
              _jadwalSholat(assetDart.dzuhur, "Dzuhur", dzuhur.toString()),
              _jadwalSholat(assetDart.ashar, "Ashar", ashar.toString()),
              _jadwalSholat(assetDart.maghrib, "Maghrib", maghrib.toString()),
              _jadwalSholat(assetDart.isya, "Isya", isya.toString()),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height5(context),
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.widht5(context)),
          child: Row(
            children: [
              Container(
                width: Dimensions.widht336(context) / 2,
                height: Dimensions.height88(context),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    ),
                    color: PaletWarna.unguFresh),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.widht10(context),
                        right: Dimensions.widht10(context),
                      ),
                      child: Container(
                        width: Dimensions.widht36(context),
                        height: Dimensions.height36(context),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(Icons.calendar_month,
                            size: 24, color: PaletWarna.unguIcon),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: Dimensions.height10(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            poppinText(
                              context,
                              time,
                              FontWeight.bold,
                              12,
                              Colors.white,
                              12,
                            ),
                            poppinText(
                              context,
                              dates,
                              FontWeight.w400,
                              12,
                              Colors.white,
                              12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Dimensions.widht5(context),
              ),
              Container(
                width: Dimensions.widht162(context),
                height: Dimensions.height88(context),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                    ),
                    color: PaletWarna.unguFresh),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height10(context)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.widht10(context),
                          right: Dimensions.widht10(context),
                        ),
                        child: Container(
                          width: Dimensions.widht36(context),
                          height: Dimensions.height36(context),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.place,
                              size: 24, color: PaletWarna.unguIcon),
                        ),
                      ),
                      Expanded(
                        child: isLoading
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Dimensions.height5(context),
                                  ),
                                  poppinText(
                                    context,
                                    pronvisi,
                                    FontWeight.bold,
                                    12,
                                    PaletWarna.unguTua,
                                    12,
                                  ),
                                  poppinText(
                                    context,
                                    kecamatan,
                                    FontWeight.w500,
                                    10,
                                    Colors.white,
                                    10,
                                  ),
                                  poppinText(
                                    context,
                                    jalan,
                                    FontWeight.w400,
                                    10,
                                    Colors.white,
                                    10,
                                  ),
                                ],
                              )
                            : Center(
                                child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height10(context),
                                        bottom: Dimensions.height10(context)),
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: PaletWarna.unguMuda,
                                      ),
                                    ),
                                  ),
                                  poppinText(context, "Mohon Tunggu",
                                      FontWeight.bold, 10, Colors.white, 10)
                                ],
                              )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
              top: Dimensions.height40(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                poppinText(context, "Kumpulan Doa, Niat beserta artinya",
                    FontWeight.bold, 18, Colors.white, 18)
              ],
            )),
        SizedBox(
          height: Dimensions.height15(context),
        ),
      ],
    );
  }

  Widget _jadwalSholat(String images, String nama, String waktu) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Dimensions.height30(context),
          width: Dimensions.widht30(context),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Image.asset(images),
        ),
        poppinText(context, nama, FontWeight.w500, 14, Colors.white, 14),
        poppinText(
            context, waktu, FontWeight.w500, 12, PaletWarna.teksWaktu, 12)
      ],
    );
  }

  Tab _tabs(BuildContext context, String teks, FontWeight fontWeight,
      double fontSize, double copyFontSize) {
    return Tab(
        child: poppingTextNoColor(
            context, teks, fontWeight, fontSize, copyFontSize));
  }

  void loadDone() async {
    getLocation();
    getSholatTime();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = true;
      });
    });
  }

  void getSholatTime() async {
    Position position = await getCurrentLocation();
    setState(() {
      
        latitude = position.latitude;
        langitude = position.longitude;
      
    });
    tz.initializeTimeZones();

    final location = tz.getLocation('Asia/Jakarta');

    DateTime date = tz.TZDateTime.from(DateTime.now(), location);
    Coordinates coordinates = Coordinates(latitude, langitude);

    CalculationParameters params = CalculationMethod.Singapore();
    params.madhab = Madhab.Shafi;
    PrayerTimes prayerTimes =
        PrayerTimes(coordinates, date, params, precision: true);

    setState(() {
      subuh = DateFormat("hh:mm a")
          .format(tz.TZDateTime.from(prayerTimes.fajrafter!, location))
          .toString();
      fajr = DateFormat("hh:mm a")
          .format(tz.TZDateTime.from(prayerTimes.fajr!, location))
          .toString();
      dzuhur = DateFormat("hh:mm a")
          .format(tz.TZDateTime.from(prayerTimes.dhuhr!, location))
          .toString();
      ashar = DateFormat("hh:mm a")
          .format(tz.TZDateTime.from(prayerTimes.asr!, location))
          .toString();
      maghrib = DateFormat("hh:mm a")
          .format(tz.TZDateTime.from(prayerTimes.maghrib!, location))
          .toString();
      isya = DateFormat("hh:mm a")
          .format(tz.TZDateTime.from(prayerTimes.isha!, location))
          .toString();
    });
  }

  Future getLocation() async {
    try {
      Position position = await getCurrentLocation();
      setState(() {
        
        latitude = position.latitude;
        langitude = position.longitude;
      });

      Map<String, String> kabupatenAwal =
          await getKabupaten(latitude, langitude);
      setState(() {
        pronvisi = kabupatenAwal["administrativeArea"] ?? " Data Kosong ";
        kecamatan = kabupatenAwal["locality"] ?? " Data Kosong ";
        jalan = kabupatenAwal["street"] ?? "Data Kosong";
      });
    } catch (e) {
      throw 'Terjadi error yaitu $e';
    }
  }
}
