// ignore_for_file: must_be_immutable

import 'dart:math' as math;

import 'package:al_quran/AppBar/AppBar.dart';
import 'package:al_quran/AppBar/Drawer.dart';
import 'package:al_quran/library_asset/color.dart';
import 'package:al_quran/library_asset/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class CompasClass extends StatefulWidget {
  String? provinsi;
  String? kecamatan;
  String? negara;
  CompasClass({super.key,  this.provinsi, this.kecamatan, this.negara});

  @override
  State<CompasClass> createState() => _CompasClassState();
}

class _CompasClassState extends State<CompasClass> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    _fetchPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: PaletWarna.putihTeks,
          appBar:AppBarClass(teks: "Compass Page"),
          body: Builder(builder: (context) {
            if (_hasPermissions) {
              return Column(
                children: <Widget>[
                  Expanded(child: _buildCompass()),
                ],
              );
            } else{
                return Text(
                  "Data tidak Tersedia",
                  style: GoogleFonts.poppins(
                      color: PaletWarna.putihTeks,
                      fontSize: 20 / MediaQuery.textScaleFactorOf(context)),
                );
            }
          })
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        double? direction = snapshot.data!.heading;
        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }
        return Column(
          children: [
            SizedBox(height: Dimensions.height30(context),),
            Center(
              child: poppinText(context, "Arah Kiblat", FontWeight.bold, 16, PaletWarna.background)
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.widht30(context),
                    vertical: Dimensions.height30(context)),
                alignment: Alignment.center,
                
                child: Transform.rotate(
                  angle: (direction * (math.pi / 180) * -1),
                  child: Image.asset("assets/png/TidakBewarna/compassNoColor.png"),
                ),
              
            ),
            Center(
              child: poppinText(context, widget.kecamatan.toString(), FontWeight.normal, 16, PaletWarna.background)
            ),
            Center(
              child: poppinText(context, widget.provinsi.toString(), FontWeight.bold, 16, PaletWarna.background)
            ),
            Center(
              child: poppinText(context, widget.negara.toString(), FontWeight.bold, 16, PaletWarna.background)
            ),
          ],
        );
      },
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }
}
