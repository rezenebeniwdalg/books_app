import 'dart:developer';

import 'package:books_app/view/bookdetails/bookdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class All_tab_scr extends StatefulWidget {
  const All_tab_scr({super.key});

  @override
  State<All_tab_scr> createState() => _All_tab_scrState();
}

class _All_tab_scrState extends State<All_tab_scr> {
 String? bookurl;

  CollectionReference CollectionRef = FirebaseFirestore.instance.collection("books");
  List<Map<String, dynamic>> pdfdata = [];


//
void getpdf()async
{
final pdfres = await FirebaseFirestore.instance.collection("books").get();
pdfdata= pdfres.docs.map((e)=> e.data()).toList();
setState(() {
  
});

}
@override
void initState(){
  super.initState();
  getpdf();
  }
  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
      
      body: StreamBuilder(stream: CollectionRef.snapshots(),builder: (context, snapshot){
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
                                  Expanded(
                                    child:   ListView.builder(
                                                    itemCount:snapshot.data!.docs.length ,
                                                    itemBuilder: (context, index){
                                                    return InkWell(
                                                      onTap: () {
                                                       
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Bookdetails(thumbnail:snapshot.data!.docs[index]['image'] ,title:snapshot.data!.docs[index]['title'] ,author: snapshot.data!.docs[index]['auth'],bookfile:snapshot.data!.docs[index]['file'] ,)));
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          children: [
                                                            // SizedBox(height: 10,),
                                                            Container(
                                                              height: 160,
                                                              width: 400,
                                                              child: Stack(
                                                                children: <Widget>[
                                                                   Positioned(
                                                                    bottom: 0,
                                                                    left: 0,
                                                                    right: 0,
                                                                     child: Container(
                                                                      decoration: BoxDecoration(color: Color.fromARGB(205, 255, 255, 255),borderRadius: BorderRadius.circular(29),boxShadow: [BoxShadow(offset:Offset(0, 20),blurRadius: 33,color: Colors.grey.withOpacity(.84) )]),
                                                                      height: 140,
                                                                      width: double.infinity,
                                                                      child: Row(
                                                                        children: [
                                                                                                      //                             Padding(
                                                                                                      // padding: const EdgeInsets.all(8.0),
                                                                                                      // child: Image.network(snapshot.data!.docs[index]['image'],fit: BoxFit.fitHeight,width: 150,),
                                                                                                      //                             ),
                                                                          Column(
                                                                                                      children: [
                                                                          //                               Text(snapshot.data!.docs[index]['title'].toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.deepOrange),),
                                                                          // Text(snapshot.data!.docs[index]['auth']),
                                                                                                      ],
                                                                          )
                                                                          // Text(snapshot.data!.docs[index]['title']),
                                                                          // Text(snapshot.data!.docs[index]['auth']),
                                                                          // ElevatedButton(onPressed: (){}, 
                                                                          // child: SfPdfViewer.network(snapshot.data!.docs[index]['file'])  
                                                                          // )
                                                                          // PDFView()
                                                                        ],
                                                                                                                          
                                                                                                                                       ),
                                                                                                                          ),
                                                                   ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(snapshot.data!.docs[index]['image'],fit: BoxFit.fitHeight,width: 120,)),
  ),
                Positioned(
                  top: 65,
                  left: 150,
                  child: Column(children: [
    Text(snapshot.data!.docs[index]['title'].toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.deepOrange),),
                  

                                                                                                                         ]
                                                                                                                         ,)
                                                                                                                         ),
   Positioned(
                  top: 95,
                  left: 150,
                  child: Column(children: [
   
                  Text(snapshot.data!.docs[index]['auth']),

                                                                                                                         ]
                                                                                                                         ,)
                                                                                                                         ),
 Positioned(
                  top: 45,
                 right: 20,
                  child: Column(children: [
    
                 IconButton(onPressed: (){

 }, icon: Icon(Icons.favorite_border_outlined))

                                                                                                                         ]
                                                                                                                         ,)
                                                                                                                         )
                                                            
                                                            
                                                                ]
                                                                ),
                                                            ),
                                                                 
                                                            
                                
                                                          ],
                                                        ),
                                                      
                                                      // child: ListTile(
                                                       
                                                      //   leading: Image.network(snapshot.data!.docs[index]['image']),
                                                      //   title: Text(snapshot.data!.docs[index]['title']),
                                                      //   subtitle: Text(snapshot.data!.docs[index]['auth']),
                                                        
                                                        
                                                      //       //                       trailing: Row(
                                                      //       //                         mainAxisSize: MainAxisSize.min,
                                                      //       //                         children: [
                                                      //       //                         //   IconButton(onPressed: (){
                                                      //       //                         //   log(snapshot.data!.docs[index].id);
                                                      //       //                         //   CollectionRef.doc(snapshot.data!.docs[index].id).update({"title":title.text,"author":author.text,
                                                      //       //                         //   "url":url ?? ""
                                                      //       //                         //   });
                                                      //       //                         //   name.clear();
                                                      //       //                         //   ph.clear();
                                                      //       //                         // }, icon: Icon(Icons.edit)),
                                                      //       //                         IconButton(onPressed: (){
                                                      //       // CollectionRef.doc(snapshot.data!.docs[index].id).delete();
                                                            
                                                            
                                                      //       //                         }, icon: Icon(Icons.delete))],
                                                          
                                                      //       //                       ),
                                                      // ),
                                                     ) );
                                                  }
                                                  ),  
                                    
                                  ),
                                  SizedBox(height: 50,)
                                ],
                              ),
                              );
         }, ));
  }
}