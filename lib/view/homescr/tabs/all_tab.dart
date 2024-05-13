import 'dart:developer';

import 'package:books_app/view/bookdetails/bookdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class All_tab_scr extends StatefulWidget {
  const All_tab_scr({super.key});

  @override
  State<All_tab_scr> createState() => _All_tab_scrState();
}

class _All_tab_scrState extends State<All_tab_scr> {
 String? bookurl;

  CollectionReference CollectionRef = FirebaseFirestore.instance.collection("books");
  List<Map<String, dynamic>> pdfdata = [];

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
                              child: Expanded(
                                child:   ListView.builder(
                  itemCount:snapshot.data!.docs.length ,
                  itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                     
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Bookdetails(thumbnail:snapshot.data!.docs[index]['image'] ,title:snapshot.data!.docs[index]['title'] ,author: snapshot.data!.docs[index]['auth'],)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Color.fromARGB(126, 0, 0, 0),borderRadius: BorderRadius.circular(15)),
                        height: 200,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                                child: Image.network(snapshot.data!.docs[index]['image'],fit: BoxFit.fitHeight,scale: 8,),
                              ),
                            ),
                            
                            Text(snapshot.data!.docs[index]['title']),
                            Text(snapshot.data!.docs[index]['auth']),
                            ElevatedButton(onPressed: (){}, child: )
                            // PDFView()
                          ],
                        ),
                      ),
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
                  );
                }
                ),  
                                
                              ),
                              );
         }, ));
  }
}