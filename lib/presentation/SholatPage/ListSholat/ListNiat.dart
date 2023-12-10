import 'package:al_quran/common/component/Drawer.dart';
import 'package:al_quran/data/Model/bacaanNiatModel.dart';
import 'package:al_quran/data/Service/ServiceClass.dart';
import 'package:al_quran/common/component/class_expansion.dart';
import 'package:al_quran/common/constant/color.dart';
import 'package:al_quran/common/constant/dimensions.dart';
import 'package:al_quran/common/constant/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListNiat extends StatelessWidget {
  const ListNiat({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<bool> isIcon = [];
    List<ExpansionColor> isColors = [];

    return ChangeNotifierProvider(
      create: (context) => ExpansionColor(),
      child: SizedBox(
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
                
                  isIcon =List.generate(dataBacaanNiat.length, (index) => false);
                  isColors = List.generate(dataBacaanNiat.length, (index) => ExpansionColor());
                
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
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: Dimensions.height36(context),
                                      width: Dimensions.widht36(context),
                                      child: Image.asset(assetDart.boxNomor)),
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
                            ),
                          ),
                        ],
                      ),
                      onExpansionChanged: (bool expanded) {
                        Provider.of<ExpansionColor>(context, listen: false).isGrey = expanded;
                        isColors[index].isGrey = expanded;
                        isIcon[index] = expanded;
                      },
                      trailing: Consumer<ExpansionColor>(
                          builder: (context, expansionColor, _) {
                        return isIcon[index]
                            ? Icon(
                                Icons.arrow_drop_down_circle,
                                color: isColors[index].isColor,
                              )
                            : Icon(
                                Icons.arrow_drop_down,
                                color: isColors[index].isColor,
                              );
                      }),
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
                                  fontSize: 20 /
                                      MediaQuery.textScaleFactorOf(context),
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
                itemCount: dataBacaanNiat.length,
              );
            }
          },
        ),
      ),
    );
  }
}
