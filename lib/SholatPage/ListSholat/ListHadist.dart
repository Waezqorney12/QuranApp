import 'dart:math';

import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Model/tokohHadistModel.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/SholatPage/DetailPage/DetailHadist.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon/assetz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListHadist extends StatefulWidget {
  const ListHadist({super.key});

  @override
  State<ListHadist> createState() => _ListHadistState();
}

class _ListHadistState extends State<ListHadist> {
  bool _costumIcon = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print( ServiceClass().getHadist("bukhari", 1));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  TextEditingController nomorHadist = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height50(context),
      width: Dimensions.widht50(context),
      child: FutureBuilder<List<TokohHadist>>(
        future: ServiceClass().getTokoh(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: poppinText(
                  context,
                  "Terjadi kesalahan, berikut: ${snapshot.error}",
                  FontWeight.bold,
                  20,
                  Colors.white,
                  20),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: poppinText(
                  context,
                  "Data kosong dan tidak bisa diakses, coba lagi nanti",
                  FontWeight.bold,
                  20,
                  Colors.white,
                  20),
            );
          } else {
            final dataTokohs = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.widht10(context),
                      vertical: Dimensions.widht10(context),
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Row(
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
                                            dataTokohs[index].nomor.toString(),
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
                                          child:
                                              Image.asset(assetDart.boxNomor)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: Dimensions.widht200(context),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinText(
                                        context,
                                        dataTokohs[index].name,
                                        FontWeight.w500,
                                        16,
                                        Colors.white,
                                        16,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height5(context),
                                      ),
                                      poppinText(
                                        context,
                                        "Jumlah Hadist: ${dataTokohs[index].available.toString()}",
                                        FontWeight.w500,
                                        14,
                                        PaletWarna.unguTeks,
                                        14,
                                      ),
                                    ],
                                  )),
                            ],
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
                              Row(
                                children: [
                                  Container(
                                    height: Dimensions.height40(context),
                                    width: Dimensions.widht200(context) - 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.white70),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.widht10(context),
                                          top: Dimensions.height10(context)),
                                      child: TextFormField(
                                        controller: nomorHadist,
                                        keyboardType: TextInputType.number,
                                        maxLength: 4,
                                        style: TextStyle(
                                          color: PaletWarna.putihTeks,
                                          // Atur gaya teks lainnya jika diperlukan
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Masukkan nomor hadist",
                                          hintStyle: GoogleFonts.poppins(
                                            color: PaletWarna.unguMuda
                                                .withOpacity(.5),
                                            fontSize: 12,
                                          ),
                                          counterText:
                                              '', // Ini akan menghilangkan teks "0/4"
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.widht10(context),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                            if (nomorHadist.text.isEmpty) {
                                          Fluttertoast.showToast(
                                            msg: "Nomor tidak boleh kosong",
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                        }else if(nomorHadist.text.isNotEmpty){
                                          int nomorParse = int.parse(nomorHadist.text);
                                          if (nomorParse > dataTokohs[index].available) {
                                            Fluttertoast.showToast(
                                            msg: "Nomor tidak boleh melebihi jumlah hadist",
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                          }else{
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailHadist(
                                                nomorHadist: int.parse(nomorHadist.text),
                                                namaBuku: dataTokohs[index].id,
                                              ),
                                            ));
                                        }
                                        }
                                      });
                                    },
                                    child: Container(
                                        height: Dimensions.height40(context),
                                        width:
                                            Dimensions.widht100(context) - 15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: poppinText(
                                              context,
                                              "Submit",
                                              FontWeight.bold,
                                              14,
                                              PaletWarna.unguTua,
                                              14),
                                        ),
                                      ),
                                    ),
                                
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                      onExpansionChanged: (value) {},
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: .5,
                    color: Colors.grey.withOpacity(.5),
                  );
                },
                itemCount: dataTokohs!.length);
          }
        },
      ),
    );
  }
}
