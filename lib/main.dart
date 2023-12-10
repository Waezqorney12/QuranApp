import 'package:al_quran/presentation/AsmaulPage/AsmaulHusna.dart';
import 'package:al_quran/presentation/DashboardPage/Dashboard.dart';
import 'package:al_quran/presentation/SplashScreenPage/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(
    showHome: showHome,
  ));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showHome ? const Dashboard() : const SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => const Dashboard(),
        '/asmaulhusna' : (BuildContext context) => const AsmaulHusnaPage()
      },
    );
  }
}

