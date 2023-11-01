import 'package:al_quran/AsmaulHusna.dart';
import 'package:al_quran/Dashboard.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon_image/assetz.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(
    showHome: showHome,
  ));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: showHome ? const Dashboard() : const SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => const Dashboard(),
        '/asmaulhusna' : (BuildContext context) => const AsmaulHusnaPage()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = PageController(initialPage: 0);

  final logger = Logger();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: PaletWarna.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: [
                  _pageView(
                      context,
                      Image.asset(assetDart.splashPertama),
                      "Hadist Hadist Pilihan",
                      "Hadist dari para ulama \n Disertai arti dalam bahasa indonesia"),
                  _pageView(
                      context,
                      Image.asset(assetDart.splashKedua),
                      "Tata Cara Sholat",
                      "Tata cara sholat yang benar \n Disertai kumpulan doa sholat"),
                  _pageViewButton(
                      context,
                      SvgPicture.asset(assetDart.splashKetiga),
                      "Al-Qur'an Indonesia",
                      "Belajar Al-Qur'an \n Dilengkapi latin dan artinya"),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: ExpandingDotsEffect(activeDotColor: PaletWarna.unguIcon),
              onDotClicked: (index) {
                index = 0;
              },
            )
          ],
        ));
  }

  Container _pageView(
    BuildContext context,
    Widget widgets,
    String judul,
    String konteks,
  ) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.widht30(context),
            vertical: Dimensions.height80(context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              judul,
              style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: PaletWarna.putihTeks)
                  .copyWith(
                      fontSize: 28 / MediaQuery.textScaleFactorOf(context)),
            ),
            SizedBox(
              height: Dimensions.height15(context),
            ),
            Text(
              konteks,
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.poppins(fontSize: 18, color: PaletWarna.unguTeks)
                      .copyWith(
                          fontSize: 18 / MediaQuery.textScaleFactorOf(context)),
            ),
            SizedBox(
              height: Dimensions.height15(context),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: Dimensions.height450(context),
                  width: Dimensions.widht315(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: PaletWarna.backgroundLogo),
                  child: SizedBox(width: 50, height: 50, child: widgets),
                ),
              ],
            ),
          ],
        ));
  }

  Container _pageViewButton(
    BuildContext context,
    Widget widgets,
    String judul,
    String konteks,
  ) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.widht30(context),
            vertical: Dimensions.height80(context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              judul,
              style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: PaletWarna.putihTeks)
                  .copyWith(
                      fontSize: 28 / MediaQuery.textScaleFactorOf(context)),
            ),
            SizedBox(
              height: Dimensions.height15(context),
            ),
            Text(
              konteks,
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.poppins(fontSize: 18, color: PaletWarna.unguTeks)
                      .copyWith(
                          fontSize: 18 / MediaQuery.textScaleFactorOf(context)),
            ),
            SizedBox(
              height: Dimensions.height15(context),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: Dimensions.height450(context),
                  width: Dimensions.widht315(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: PaletWarna.backgroundLogo),
                  child: SizedBox(width: 50, height: 50, child: widgets),
                ),
                Positioned(
                  bottom: -25,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: SizedBox(
                      width: Dimensions.widht185(context),
                      height: Dimensions.height60(context),
                      child: RawMaterialButton(
                        fillColor: PaletWarna.button,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          }
                        },
                        child: Text(
                          "Get Started",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: PaletWarna.hitamTeks)
                              .copyWith(
                                  fontSize: 16 /
                                      MediaQuery.textScaleFactorOf(context)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
