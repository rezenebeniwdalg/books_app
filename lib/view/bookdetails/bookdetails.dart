import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Bookdetails extends StatelessWidget {
  const Bookdetails({super.key,this.author,this.thumbnail,this.title});
  final  thumbnail;
final title;
final author;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
        
        children: [
         Image(image: NetworkImage(thumbnail,scale: 5)),
         Text(title),
         Text(author),
        //  PDFView()
        ],
        ),
      ),

    );
  }
}