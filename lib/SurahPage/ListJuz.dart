import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Model/namaJuzModel.dart';
import 'package:al_quran/SurahPage/DetailPage/DetailJuz.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:al_quran/library_asset/icon_image/assetz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:al_quran/Service/ServiceClass.dart';

class ListJuz extends StatefulWidget {
  const ListJuz({super.key});

  @override
  State<ListJuz> createState() => _ListJuzState();
}

class _ListJuzState extends State<ListJuz> {
  int nomors = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<namaJuz>>(
      future: ServiceClass().getNamaJuz(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: poppinText(context, "Data tidak ada", FontWeight.bold, 20,
                            Colors.white, 20),
          );
        }else if(snapshot.hasError){
          return Center(
            child: poppinText(context, "Data error atau sedang tidak tersedia", FontWeight.bold, 20,
                            Colors.white, 20),
          );
        }
        final namajuz = snapshot.data ;
        return ListView.separated(
            itemBuilder: (context, index) {
              int nomor = nomors + index;
              
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJuzs(nomorJuz: nomor,),));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height10(context),
                            horizontal: Dimensions.widht10(context)),
                        child: SizedBox(
                            width: Dimensions.widht36(context),
                            height: Dimensions.height36(context),
                            child: Stack(
                              children: [
                                Center(
                                    child: poppinText(
                                        context,
                                        nomor.toString(),
                                        FontWeight.w500,
                                        14,
                                        PaletWarna.putihTeks,
                                        14)),
                                Center(
                                  child: Image.asset(assetDart.boxNomor),
                                )
                              ],
                            )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          poppinText(context, "Juz $nomor", FontWeight.bold, 16,
                              Colors.white, 16),
                          poppinText(context, namajuz[index].ket, FontWeight.w400, 14, Colors.white, 14)
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey.withOpacity(.2),
                height: 2,
              );
            },
            itemCount: namajuz!.length);
      },
    );
  }
}
