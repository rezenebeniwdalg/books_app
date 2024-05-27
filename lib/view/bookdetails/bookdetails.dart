import 'dart:developer';

import 'package:books_app/controller/recentcontroller.dart';
import 'package:books_app/view/bookdetails/bookread.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Bookdetails extends StatefulWidget {
  const Bookdetails({super.key,this.author,this.thumbnail,this.title,this.bookfile});
  final  thumbnail;
final title;
final author;
final bookfile;

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
 IconButton(onPressed: (){

 }, icon: Icon(Icons.favorite_border_outlined))
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