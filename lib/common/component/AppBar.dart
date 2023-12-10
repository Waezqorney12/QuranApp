import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color.dart';
import '../constant/dimensions.dart';

class AppBarClass extends StatefulWidget implements PreferredSizeWidget {
  final String teks;
  final String? images;
  final VoidCallback? voidCallback;
  final Widget? widgets;
  const AppBarClass({super.key,required this.teks, this.images, this.voidCallback, this.widgets});

  @override
  State<AppBarClass> createState() => _AppBarClassState();

  //override merupakan anotasi yang digunakan untuk mengimplementasikan superclass atau warisan class nya dalam hal ini implement preferredWidgetSize
  //Karena mengganti preferredSize nya maka perlu menggunakan override jadi ketika tidak mengganti subclass atau parent class maka tidak usah.
  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppBarClassState extends State<AppBarClass> {
  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: Dimensions.height80(context),
      elevation: 0,
      backgroundColor: PaletWarna.background,
      actions: [
         if (widget.images != null) // Periksa apakah widget.images tidak null
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.widht24(context),
            ),
            child: IconButton(
              iconSize: 24,
              onPressed: widget.voidCallback,
              icon: Image.asset(widget.images!),
            ),
          ),
      ],
      leading: widget.widgets,
      title: Padding(
        padding: EdgeInsets.only(left: Dimensions.widht24(context)),
        child: Text(
          widget.teks,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ).copyWith(
            fontSize: 20 / MediaQuery.textScaleFactorOf(context),
            color: Colors.white, // Sesuaikan warna teks
          ),
        ),
      ),
    );
  }
}
