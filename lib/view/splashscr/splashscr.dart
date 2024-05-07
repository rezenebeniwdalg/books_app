import 'package:books_app/view/botnavbar/navbar.dart';
import 'package:books_app/view/homescr/homescr.dart';
import 'package:books_app/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key,this.isalreadylogged = false});
 final bool isalreadylogged;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
   void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      if(widget.isalreadylogged){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBarScreen(),
          ));
      }else{
 Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
      }
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/weblogo.png",scale: 1.5,),
        // child: SvgPicture.asset( "assets/audible-svgrepo-com.svg",semanticsLabel: "logo",colorFilter: ColorFilter.mode(Colors.deepPurpleAccent, BlendMode.srcIn),height: 200,),
        ),
    );
  }
}