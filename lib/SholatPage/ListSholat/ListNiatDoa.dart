import 'dart:math';

import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Model/bacaanDoaModel.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/Widget/class_expansion.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon_image/assetz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListNiatDoa extends StatefulWidget {
  const ListNiatDoa({super.key});

  @override
  State<ListNiatDoa> createState() => _ListNiatDoaState();
}

class _ListNiatDoaState extends State<ListNiatDoa> {
  List<bool> isExpandedList = [];
  List<ExpansionColor> isExpansion = [];


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpansionColor(),
      child: SizedBox(
        height: Dimensions.height50(context),
        width: Dimensions.widht50(context),
        child: FutureBuilder<List<BacaanDoa>>(
            future: ServiceClass().getDoa(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Terjadi Error tidak diketahui, lebih lanjut: $e",
                    style: GoogleFonts.montserrat(
                        fontSize: 20 / MediaQuery.textScaleFactorOf(context)),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "Data gagal dimuat atau kosong, lebih lanjut: $e",
                    style: GoogleFonts.montserrat(
                        fontSize: 20 / MediaQuery.textScaleFactorOf(context)),
                  ),
                );
              } else {
                final dataBacaanDoa = snapshot.data!;
                isExpandedList =
                    List.generate(dataBacaanDoa.length, (index) => false);
                    isExpansion =
                    List.generate(dataBacaanDoa.length, (index) => ExpansionColor());
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.widht10(context),
                            vertical: Dimensions.height10(context)),
                        child:ExpansionTile(
                            onExpansionChanged: (bool expanded) {
                              
                              isExpandedList[index] = expanded;
                              isExpansion[index].isGrey = expanded;
                            },
                            title: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: Dimensions.widht15(context)),
                                  child: SizedBox(
                                          height: Dimensions.height36(context),
                                          width: Dimensions.widht36(context),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          child: Center(
                                              child: poppinText(context,dataBacaanDoa[index].id,FontWeight.w500,14,Colors.white)),
                                        ),
                                        Image.asset(assetDart.boxNomor)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: Dimensions.widht200(context),
                                    child: poppinText(
                                        context,
                                        dataBacaanDoa[index].doa,
                                        FontWeight.w500,
                                        16,
                                        Colors.white))
                              ],
                            ),
                            trailing: Consumer<ExpansionColor>(
                              builder: (context, expansionColor, _) {
                                return isExpandedList[index]
                                    ? Icon(Icons.arrow_drop_down_circle,
                                        color: isExpansion[index].isColor)
                                    : Icon(Icons.arrow_drop_down,
                                        color: isExpansion[index].isColor);
                              },
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.widht20(context)),
                                child: Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.end,
                                      dataBacaanDoa[index].ayat,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20 /
                                              MediaQuery.textScaleFactorOf(
                                                  context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.height15(context)),
                                      child: Text(
                                        dataBacaanDoa[index].latin,
                                        style: GoogleFonts.poppins(
                                            color: PaletWarna.unguMuda,
                                            fontSize: 16 /
                                                MediaQuery.textScaleFactorOf(
                                                    context),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                      dataBacaanDoa[index].artinya,
                                      style: GoogleFonts.poppins(
                                          color: PaletWarna.unguTeks,
                                          fontSize: 16 /
                                              MediaQuery.textScaleFactorOf(
                                                  context),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: .5,
                        color: Colors.grey.withOpacity(.5),
                      );
                    },
                    itemCount: dataBacaanDoa.length);
              }
            }),
      ),
    );
  }
}
