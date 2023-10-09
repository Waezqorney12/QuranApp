import 'package:al_quran/AppBar/AppBar.dart';
import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/Model/detailHadisModel.dart';
import 'package:al_quran/Service/ServiceClass.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailHadist extends StatefulWidget {
  int nomorHadist;
  String namaBuku;
  DetailHadist({super.key, required this.nomorHadist, required this.namaBuku});

  @override
  State<DetailHadist> createState() => _DetailHadistState();
}

class _DetailHadistState extends State<DetailHadist> {
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailHadis>(
      future: ServiceClass().getHadist(widget.namaBuku, widget.nomorHadist),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Scaffold(
              backgroundColor: PaletWarna.background,
              body: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    poppinText(context, "Mohon Tunggu", FontWeight.w500, 16, PaletWarna.unguMuda, 16)
                  ],
                ),
              ),
            ),
          );
        }else if (snapshot.hasError) {
          // Menampilkan pesan kesalahan
          return Scaffold(
            backgroundColor: PaletWarna.background,
            body: Center(
              child: Text("Terjadi kesalahan: ${snapshot.error}"),
            ),
          );
        }else if(!snapshot.hasData){
          return Scaffold(
            backgroundColor: PaletWarna.background,
            body: Center(
              child: poppinText(context, "Data tidak ditemukan", FontWeight.w500, 16, PaletWarna.unguMuda, 16),
            ),
          );
        }
        DetailHadis hadis = snapshot.data!;
        
      return _getHadist(context: context, dataHadist: hadis.data.contents);
    });
  }

  Scaffold _getHadist({required BuildContext context, required Contents dataHadist, }) {
    return Scaffold(
    body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: dataHadist.number,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
        return Column(
          children: [
            poppinText(context, dataHadist.id, FontWeight.w500, 16, PaletWarna.unguMuda, 16),
          ],
        );
      },),
    )
  );
  }
}
