// import 'dart:js_interop';

import 'package:books_app/view/login/login.dart';
import 'package:books_app/view/searchscr/searchscr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScr extends StatefulWidget {
  const HomeScr({super.key,this.emailid});
  final  emailid;

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
   final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
  
      appBar: AppBar(

        leading: Builder(builder: (context)=>Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(Icons.menu,size: 35,)
            // Image.asset("assets/weblogo.png",scale: 1,),
            // child: SvgPicture.asset("assets/audible-svgrepo-com.svg")
            ),
        ),),
        centerTitle: true,
        title: Image.asset("assets/logo1.png"),
        // title: Text("ONBOOKS",style: TextStyle(fontWeight: FontWeight.w900),),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScr()));
          },icon: Icon(Icons.search,size: 30,),),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child:
             Builder(builder: (context)=>
             InkWell(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
             ),
          )
        ],
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top: 38,bottom: 20,left: 10),
        child: Drawer(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                DrawerHeader(
                  
                  child: Container(
                  color: Colors.amber,
                )),
                Container(
                  child: Text("data"),
                )
              ],
            ),
          ),
        ),
      ),
      endDrawer: Padding(
        padding: const EdgeInsets.only(top: 80,bottom: 200,right: 10),
        
        child: Drawer(
         backgroundColor: Colors.amberAccent,
        
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          width: MediaQuery.sizeOf(context).width * .8,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                child: UserAccountsDrawerHeader(
                  
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                  currentAccountPicture: CircleAvatar(radius: 20, backgroundImage: NetworkImage("https://images.pexels.com/photos/2295744/pexels-photo-2295744.jpeg?auto=compress&cs=tinysrgb&w=400"),),
                  accountName: Text(user!.uid.toString(),style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),),
                   accountEmail: Text(user!.email.toString(),style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold)))
                 ),
              Center(child: Text("data")),
              IconButton(onPressed: ()async{
          await FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Login()), (route) => false);
        }, icon: Icon(Icons.logout))
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/introbg.jpg",),fit: BoxFit.cover)),
      )
    );
  }
}