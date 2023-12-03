import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      listIcon(context, Icons.book, "Asmaul Husna" , voidCallback: ()=> Navigator.pushReplacementNamed(context, '/asmaulhusna')),
      listIcon(context, Icons.info_outline_rounded, "Tentang Aplikasi"),
      listIcon(context, Icons.call, "Hubungi Kami"),
    ]),
  );
}

ListTile listIcon(BuildContext context, IconData icon, String teks, {VoidCallback? voidCallback}) {
  return ListTile(
    shape: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.2))),
    title: InkWell(
      onTap: voidCallback,
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
                PaletWarna.unguTeks.withOpacity(0.8))
          ),
        ],
      ),
    ),
  );
}

Text poppinText(BuildContext context, String fontText, FontWeight fontWeight,
    double fontSizeText, Color colors,  {TextAlign? align}) {
  return Text(
    
    fontText,
    style: GoogleFonts.poppins(
      fontWeight: fontWeight,
      fontSize: fontSizeText/ MediaQuery.textScaleFactorOf(context),
      color: colors,
    )
  );
}
  Text poppingTextNoColor(BuildContext context, String text,
      FontWeight fontWeight, double fontSize, double copyFontSize) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontWeight: fontWeight, fontSize: fontSize / MediaQuery.textScaleFactorOf(context))
    );
  }
