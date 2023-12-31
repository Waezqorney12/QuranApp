import 'package:al_quran/common/component/AppBar.dart';
import 'package:al_quran/common/component/Drawer.dart';
import 'package:al_quran/data/SQFLITE/bookmark.dart';
import 'package:al_quran/common/constant/color.dart';
import 'package:al_quran/common/constant/dimensions.dart';
import 'package:al_quran/common/constant/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Simpan extends StatefulWidget {
  const Simpan({super.key});

  @override
  State<Simpan> createState() => _SimpanState();
}

class _SimpanState extends State<Simpan> {
  List<Map<String, dynamic>> listBookmark = [];

  void getData() async {
    final data = await DatabaseManager.getBookmark();
    setState(() {
      listBookmark = data;
    });
  }

  void showData() async {}
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarClass(
          teks: "Save Page",
        ),
        drawer: const DrawerClass(),
        backgroundColor: PaletWarna.background,
        body: ListView.builder(
          itemCount: listBookmark.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.widht15(context),
                              vertical: Dimensions.height15(context)),
                          child: SizedBox(
                            height: Dimensions.height36(context),
                            width: Dimensions.widht36(context),
                            child: Image.asset(assetDart.lastRead)
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            poppinText(context, listBookmark[index]["surah"], FontWeight.bold, 16, Colors.white),
                            poppinText(context, "Nomor Ayat: ${listBookmark[index]["nomorAyat"].toString()}", FontWeight.w400, 16, Colors.white)
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            );
          },
        ));
  }
}
