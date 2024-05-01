import 'package:books_app/view/homescr/homescr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
   void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScr()));
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset( "assets/audible-svgrepo-com.svg",semanticsLabel: "logo",colorFilter: ColorFilter.mode(Colors.deepPurpleAccent, BlendMode.srcIn),height: 200,),),
    );
  }
}