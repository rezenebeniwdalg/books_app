import 'dart:developer';

import 'package:books_app/controller/recentcontroller.dart';
import 'package:books_app/view/bookdetails/bookread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Bookdetails extends StatefulWidget {
  const Bookdetails({super.key,this.email_id,this.author,this.thumbnail,this.title,this.bookfile,this.bookid});
  final  thumbnail;
final title;
final author;
final bookfile;
final bookid;
final email_id;

  @override
  State<Bookdetails> createState() => _BookdetailsState();
}

class _BookdetailsState extends State<Bookdetails> {

void addrecent({
required String title,
required String author,
required String url,
required String image,
  })async{
await box.add({
'title': title,
'author': author,
'url': url,
'image': image,

});

setState(() {
  recentcontroller.recentlistkeys = box.keys.toList().reversed.toList();
});

// reverselist = recentlistkeys.reversed.toList();
  }



  var box = Hive.box('recent');
bool fav=false;
 void _favourite(
  {
    required String userid,
    required String value
  }
  ) {
    setState(()  {
      fav = !fav;
      if (fav==true) {

       CollectionRef.add({"userid": widget.email_id ,"title": widget.title, "auth":widget.author, "image":widget.thumbnail ?? "","file": widget.bookfile ?? ""});
        log('added to favourites');
              } else if(fav==false) {
          deleteDocumentByField(userid,value) ;    
       log('removed from favourites');
      }
    });
  }

CollectionReference CollectionRef = FirebaseFirestore.instance.collection("favourites");

removefav(id){
  FirebaseFirestore.instance.collection("favourites").doc().delete();
  
}
Future<void> deleteDocumentByField(String userid, dynamic value,) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection("favourites");

    QuerySnapshot querySnapshot = await collectionRef.where("title", isEqualTo: value).where("userid", isEqualTo: userid).get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
        print('Document with "title" = $value deleted');
      }
    } else {
      print('No document found with "title" = $value');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
        
        children: [
          Row(
            children: [
 Image(image: NetworkImage(widget.thumbnail,),height: 200,width: 200,),
 SizedBox(width: 20),
 Column(
children: [
   Text(widget.title),
         Text(widget.author),
],
 ),
 SizedBox(width: 20,),
 Tooltip(
  message: 'add-to-fav',
   child: IconButton(onPressed: (){
   _favourite(userid: widget.email_id,value: widget.title);
  
   
   }, icon: Icon( (fav == true)? Icons.favorite_rounded :Icons.favorite_border_outlined)),
 )
            ],
          ),
         
        
          ElevatedButton(onPressed: (){
           
            addrecent(title: widget.title, author: widget.author, url: widget.bookfile,image: widget.thumbnail );

            Navigator.push(context, MaterialPageRoute(builder: (context)=> bookread(bookfile: widget.bookfile,title_: widget.title,)));
          }, 
                            child: Text("READ")  
                            )
        //  SfPdfVie
        //  PDFView()
        ],
        ),
      ),

    );
  }
}