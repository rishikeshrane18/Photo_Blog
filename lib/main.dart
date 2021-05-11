import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restraunt_app/welcome_page.dart';
//import 'package:restraunt_app/welcome_page.dart';
import 'home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
   debugShowCheckedModeBanner: false,
   title: "flutter-app",
   theme: new ThemeData(
   ),
   home: new WelcomePage(),
 ),
 );
}

// void main() => runApp(new MaterialApp(
//   debugShowCheckedModeBanner: false,
//   title: "flutter-app",
//   theme: new ThemeData(
//   ),
//   home: new HomePage(),
// ),
// );