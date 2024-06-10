import 'dart:developer';

import 'package:books_app/view/bookdetails/bookdetails.dart';
import 'package:books_app/view/homescr/card/book%20_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class All_tab_scr extends StatefulWidget {
  const All_tab_scr({super.key,this.email_id});
  final email_id;

  @override
  State<All_tab_scr> createState() => _All_tab_scrState();
}

class _All_tab_scrState extends State<All_tab_scr> {
 String? bookurl;
  final user = FirebaseAuth.instance.currentUser;

  CollectionReference CollectionRef = FirebaseFirestore.instance.collection("books");
  List<Map<String, dynamic>> pdfdata = [];


//
void getpdf()async
{
final pdfres = await FirebaseFirestore.instance.collection("books").get();
pdfdata= pdfres.docs.map((e)=> e.data()).toList();
setState(() {
  
});
// void getpdffav(){
// 
  // Query<Map<String, dynamic>> CollectionRef = FirebaseFirestore.instance.collection("books").where("title", isEqualTo: "try");
// }

}
@override
void initState(){
  super.initState();
  getpdf();
  // getpdffav();
  }
  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
      
      body: 
      
      StreamBuilder(stream: CollectionRef.snapshots(),builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(child: Text("something wrong"),);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
      return Container

                             (
                              
                               decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/introbg.jpg",),fit: BoxFit.cover),),
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Expanded(
                                    
                                    child:   GridView.builder(
                                      shrinkWrap: true,
                                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing: 10,mainAxisSpacing: 45),
                                                    itemCount:snapshot.data!.docs.length ,
                                                    itemBuilder: (context, index){
                                                    return Book_card
                                                    (
thumbnail: snapshot.data!.docs[index]['image'] ,
title: snapshot.data!.docs[index]['title'],
author: snapshot.data!.docs[index]['auth'],
bookfile:snapshot.data!.docs[index]['file'] ,
bookid: snapshot.data!.docs[index].id,
email_id: user!.email,


                                                    );
                                                  }
                                                  ),  
                                    
                                  ),
                                  SizedBox(height: 40,)
                                ],
                              ),
                              );
         }, ));
  }
}