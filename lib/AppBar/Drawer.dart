import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../library_asset/color.dart';

class DrawerClass extends StatelessWidget {
  const DrawerClass({super.key});

  @override
  Widget build(BuildContext context) {
    return drawerSurah(context);
  }
}

Drawer drawerSurah(BuildContext context) {
  return Drawer(
    backgroundColor: PaletWarna.background,
    child: ListView(children: [
      listIcon(context, Icons.menu_book_rounded, "Hadis Pilihan"),
      listIcon(context, Icons.book, "Tafsir Al Qur'an"),
      ListTile(
        shape: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.2))),
        title: InkWell(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/png/Bewarna/DoaColor.png"),
                ),
              ),
              Expanded(
                child: poppinText(context, "Doa-doa Al Qur'an", FontWeight.w500,
                    16, PaletWarna.unguTeks.withOpacity(0.8), 16),
              ),
            ],
          ),
        ),
      ),
      // Tentang Aplikasi
      listIcon(context, Icons.info_outline_rounded, "Tentang Aplikasi"),
      listIcon(context, Icons.call, "Hubungi Kami"),
    ]),
  );
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
                PaletWarna.unguTeks.withOpacity(0.8), 16),
          ),
        ],
      ),
    ),
  );
}

Text poppinText(BuildContext context, String fontText, FontWeight fontWeight,
    double fontSizeText, Color colors, double copyFontSize, {TextAlign? align}) {
  return Text(
    
    fontText,
    style: GoogleFonts.poppins(
      
      fontWeight: fontWeight,
      fontSize: fontSizeText,
      color: colors,
    ).copyWith(fontSize: copyFontSize / MediaQuery.textScaleFactorOf(context)),
  );
}
  Text poppingTextNoColor(BuildContext context, String text,
      FontWeight fontWeight, double fontSize, double copyFontSize) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontWeight: fontWeight, fontSize: fontSize)
          .copyWith(
              fontSize: copyFontSize / MediaQuery.textScaleFactorOf(context)),
    );
  }
