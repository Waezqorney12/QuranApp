

import 'package:al_quran/common/component/AppBar.dart';
import 'package:al_quran/data/Service/ServiceClass.dart';
import 'package:al_quran/common/constant/color.dart';
import 'package:al_quran/common/constant/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AsmaulHusnaPage extends StatelessWidget {
  const AsmaulHusnaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarClass(teks: "Asmaul Husna"),
      backgroundColor: PaletWarna.background,
      body: FutureBuilder(
        future: ServiceClass().getAsmaulHusna(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }else if (!snapshot.hasData|| snapshot.data!.isEmpty) {
            return setText(context,"Tidak ada data", 16, PaletWarna.unguTeks, FontWeight.bold);
          }else if(snapshot.hasError){
            setText(context,"Terjadi Error: ${snapshot.hasError}", 16, PaletWarna.unguTeks, FontWeight.bold);
          }
          final data = snapshot.data!;
          return GridView.builder(
            itemCount: data.length,
            gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.widht10(context),vertical: Dimensions.height10(context)),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: PaletWarna.unguTeks, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                    color: PaletWarna.navigation,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      setText(context, data[index]["arab"], 20, PaletWarna.putihTua, FontWeight.bold),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.height5(context)),
                        child: setText(context, data[index]["latin"], 14, PaletWarna.unguTeks, FontWeight.normal),
                      ),
                      setText(context, data[index]["arti"], 14, PaletWarna.unguMuda, FontWeight.normal,tex: TextAlign.center)
                    ],
                  )),
                );
              
            },
          );
        },
      ),
    );
  }

  Widget setText(BuildContext context, String teks, double size, Color color, FontWeight fontWeight,{TextAlign? tex}){
    return Center(
      child: Text(
        textAlign: tex,
        teks,
        style: GoogleFonts.poppins(fontSize: size/MediaQuery.textScaleFactorOf(context), color: color, fontWeight: fontWeight),
      ),
    );
  }
}
