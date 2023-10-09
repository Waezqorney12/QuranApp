import 'package:al_quran/AppBar/AppBar.dart';
import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Simpan extends StatefulWidget {
  const Simpan({super.key});

  @override
  State<Simpan> createState() => _SimpanState();
}

class _SimpanState extends State<Simpan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarClass(),
      drawer: const DrawerClass(),
      backgroundColor: PaletWarna.background,
      
      body: Center(
        child: Text(
          " Simpan ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
