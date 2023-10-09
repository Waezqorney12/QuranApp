import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/library_asset/color.dart';

import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon/assetz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ListNiatSholat extends StatefulWidget {
  const ListNiatSholat({super.key});

  @override
  State<ListNiatSholat> createState() => ListNiatSholatState();
}

class ListNiatSholatState extends State<ListNiatSholat> {
  List dataNiat = [];
  bool _costumIcon = false;

  getData() async {
    await ServiceClass().getServiceSholat().then((value) {
      setState(() {
        dataNiat = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("Ini Sholat: $dataNiat");
  }

  @override
  Widget build(BuildContext context) {
    return _listMethod(context);
  }

  SizedBox _listMethod(BuildContext context) {
    return SizedBox(
      height: Dimensions.height50(context),
      width: Dimensions.widht50(context),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.widht10(context),
                  vertical: Dimensions.height10(context)),
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: Dimensions.widht15(context)),
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
                                    dataNiat[index].id.toString(),
                                    FontWeight.w500,
                                    14,
                                    Colors.white,
                                    14),
                              ),
                            ),
                            SizedBox(
                                width: Dimensions.widht36(context),
                                height: Dimensions.height36(context),
                                child: Image.asset(
                                    assetDart.boxNomor))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.widht200(context),
                      child: poppinText(
                        context,
                        dataNiat[index].name,
                        FontWeight.w500,
                        16,
                        Colors.white,
                        16,
                      ),
                    ),
                  ],
                ),
                trailing: _costumIcon
                    ? const Icon(Icons.arrow_drop_down_circle)
                    : const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.widht20(context),
                        vertical: Dimensions.height10(context)),
                    child: Column(
                      children: [
                        Text(
                          dataNiat[index].arabic,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize:
                                  20 / MediaQuery.textScaleFactorOf(context),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Dimensions.height20(context),
                        ),
                        poppinText(context, dataNiat[index].latin,
                            FontWeight.w500, 16, PaletWarna.unguMuda, 16),
                        SizedBox(
                          height: Dimensions.height20(context),
                        ),
                        poppinText(context, dataNiat[index].terjemahan,
                            FontWeight.w500, 16, PaletWarna.unguTeks, 16),
                      ],
                    ),
                  ),
                ],
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _costumIcon = expanded;
                    _costumIcon = true;
                  });
                  setState(() {
                    _costumIcon = false;
                  });
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
          itemCount: dataNiat.length),
    );
  }
}
