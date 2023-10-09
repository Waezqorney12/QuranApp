import 'package:al_quran/SurahPage/Surah.dart';
import 'package:al_quran/SholatPage/Sholat.dart';
import 'package:al_quran/SimpanPage/Simpan.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'library_asset/dimensions.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  bool onClick = false;

  final screen = const [Surah(), Sholat(), Simpan()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screen;
    setState(() {
      onClick = true;
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
      backgroundColor: PaletWarna.background,
      body: screen[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: PaletWarna.navigation,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeOutBack,
        animationDuration: const Duration(milliseconds: 1500),
        height: 70,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Container(
            child: (_currentIndex == 0)
                ? SizedBox(
                    height: Dimensions.height30(context),
                    width: Dimensions.widht30(context),
                    child: Image.asset("assets/png/Bewarna/SurahColor.png"),
                  )
                : Image.asset("assets/png/TidakBewarna/Surah.png"),
          ),
          Container(
            child: (_currentIndex == 1)
                ? SizedBox(
                    height: Dimensions.height30(context),
                    width: Dimensions.widht30(context),
                    child: Image.asset("assets/png/Bewarna/SholatColor.png"))
                : Image.asset("assets/png/TidakBewarna/Sholat.png"),
          ),
          Container(
            child: (_currentIndex == 2)
                ? SizedBox(
                    height: Dimensions.height30(context),
                    width: Dimensions.widht30(context),
                    child: Image.asset("assets/png/Bewarna/SimpanColor.png"))
                : Image.asset("assets/png/TidakBewarna/Simpan.png"),
          )
        ],
      ),
    );
  }
}
