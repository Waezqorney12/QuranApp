import 'package:al_quran/AppBar/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailJuz extends StatelessWidget {
  int nomorJuz;
  DetailJuz({super.key, required this.nomorJuz});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return Container(
        color: Colors.white,
        child: Center(
          child: poppinText(context, nomorJuz.toString(), FontWeight.bold, 14, Colors.black, 14),
        ),
      );
    },);
  }
}