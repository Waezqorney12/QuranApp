import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Model/bacaanNiatModel.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon/assetz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ListNiat extends StatelessWidget {
  const ListNiat({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height50(context),
      width: Dimensions.widht50(context),
      child: FutureBuilder<List<NiatDoa>>(
        future: ServiceClass().getServiceNiat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Terjadi kesalahan: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Data tidak tersedia"),
            );
          } else {
            final dataBacaanNiat = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.widht10(context),
                    vertical: Dimensions.height10(context),
                  ),
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: Dimensions.widht15(context),
                          ),
                          child: SizedBox(
                            width: Dimensions.widht36(context),
                            height: Dimensions.height36(context),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: Dimensions.height36(context),
                                  width: Dimensions.widht36(context),
                                  child: Center(
                                    child: poppinText(
                                      context,
                                      dataBacaanNiat[index].id.toString(),
                                      FontWeight.w500,
                                      14,
                                      Colors.white,
                                      14,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: Dimensions.height36(context),
                                    width: Dimensions.widht36(context),
                                    child: Image.asset(
                                        assetDart.boxNomor)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.widht200(context),
                          child: poppinText(
                            context,
                            dataBacaanNiat[index].name,
                            FontWeight.w500,
                            16,
                            Colors.white,
                            16,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.widht20(context),
                          vertical: Dimensions.height10(context),
                        ),
                        child: Column(
                          children: [
                            Text(
                              dataBacaanNiat[index].arabic,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize:
                                    20 / MediaQuery.textScaleFactorOf(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height20(context),
                            ),
                            poppinText(
                              context,
                              dataBacaanNiat[index].latin,
                              FontWeight.w500,
                              16,
                              PaletWarna.unguMuda,
                              16,
                            ),
                            SizedBox(
                              height: Dimensions.height20(context),
                            ),
                            poppinText(
                              context,
                              dataBacaanNiat[index].terjemahan,
                              FontWeight.w500,
                              16,
                              PaletWarna.unguTeks,
                              16,
                            ),
                          ],
                        ),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      
          
                    
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: .5,
                  color: Colors.grey.withOpacity(.5),
                );
              },
              itemCount: dataBacaanNiat.length,
            );
          }
        },
      ),
    );
  }
}
