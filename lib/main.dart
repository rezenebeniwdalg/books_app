import 'package:books_app/view/splashscr/splashscr.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(BooksApp());
}
class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}