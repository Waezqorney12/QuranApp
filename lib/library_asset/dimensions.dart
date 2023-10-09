import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Dimensions{
  //Rumus = Total Tinggi atau Lebar / Ukuran yang diinginkan

  //ScreenHeight dan ScreenWidht itu mengambil Height dan Widht sesuai dengan yang device yang dipakai
  //Layar Samsung A33

  //Tinggi Layar: 805.3
  //Lebar Layar: 384.0
  static double screenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static double screenWidht(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static double textScale(BuildContext context){
    return MediaQuery.of(context).textScaleFactor;
  }


// Ukuran Tinggi
  static double height4(BuildContext context){
    return screenHeight(context)/201.325;
  }
  static double height5(BuildContext context){
    return screenHeight(context)/161.06;
  }
  static double height10(BuildContext context){
  return screenHeight(context)/80.53;
  }
  static double height15(BuildContext context){
    return screenHeight(context)/53.67;
  }
  static double height20(BuildContext context){
    return screenHeight(context)/40.26;
  }
  static double height24(BuildContext context){
    return screenHeight(context)/33.55;
  }
  static double height30(BuildContext context){
    return screenHeight(context)/26.84;
  }
  static double height36(BuildContext context){
    return screenHeight(context)/22.37;
  }
  static double height40(BuildContext context){
    return screenHeight(context)/20.13;
  }
  static double height45(BuildContext context){
    return screenHeight(context)/17.89;
  }
  static double height50(BuildContext context){
    return screenHeight(context)/16.106;
  }
  static double height60(BuildContext context){
    return screenHeight(context)/13.42;
  }
  static double height80(BuildContext context){
    return screenHeight(context)/10.07;
  }
  static double height88(BuildContext context){
    return screenHeight(context)/9.099;
  }
  static double height100(BuildContext context){
    return screenHeight(context)/3.84;
  }
  static double height131(BuildContext context){
    return screenHeight(context)/6.147;
  }
    static double height280(BuildContext context){
    return screenHeight(context)/2.87;
  }
  static double height450(BuildContext context){
    return screenHeight(context)/1.8;
  }

// Ukuran Lebar
  static double widht3(BuildContext context){
    return screenWidht(context)/128;
  }
  static double widht4(BuildContext context){
    return screenWidht(context)/96;
  }
  static double widht5(BuildContext context){
    return screenWidht(context)/76.8;
  }
  static double widht10(BuildContext context){
    return screenWidht(context)/38.4;
  }
  static double widht15(BuildContext context){
    return screenWidht(context)/25.6;
  }
  static double widht17(BuildContext context){
    return screenWidht(context)/22.9;
  }
  static double widht20(BuildContext context){
    return screenWidht(context)/19.2;
  }
  static double widht24(BuildContext context){
    return screenWidht(context)/16.0;
  }
  static double widht30(BuildContext context){
    return screenWidht(context)/12.8;
  }
  static double widht36(BuildContext context){
    return screenWidht(context)/10.67;
  }
  static double widht50(BuildContext context){
    return screenWidht(context)/7.68;
  }
  static double widht100(BuildContext context){
    return screenWidht(context)/3.84;
  }
  static double widht110(BuildContext context){
    return screenWidht(context)/3.49;
  }
  static double widht145(BuildContext context){
    return screenWidht(context)/2.64;
  }
  static double widht150(BuildContext context){
    return screenWidht(context)/2.56;
  }
  static double widht162(BuildContext context){
    return screenWidht(context)/2.37;
  }
  static double widht185(BuildContext context){
    return screenWidht(context)/2.08;
  }
  static double widht200(BuildContext context){
    return screenWidht(context)/1.92;
  }
  static double widht315(BuildContext context){
    return screenWidht(context)/1.22;
  }
  static double widht326(BuildContext context){
    return screenWidht(context)/1.1779;
  }
  static double widht336(BuildContext context){
    return screenWidht(context)/1.143;
  }
  

// Ukuran Font
  static double font14(BuildContext context){
    return textScale(context) * 10.77;
  }
  static double font16(BuildContext context){
    return textScale(context) * 12.30;
  }
  static double font18(BuildContext context){
    return textScale(context) * 13.85;
  }
  static double font20(BuildContext context){
    return textScale(context) * 13.58;
  }
  static double font24(BuildContext context){
    return textScale(context) * 18.46;
  }
  static double font28(BuildContext context){
    return textScale(context) * 21.54;
  }
}