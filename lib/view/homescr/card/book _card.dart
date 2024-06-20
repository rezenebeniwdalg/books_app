import 'package:books_app/controller/favcontroller.dart';
import 'package:books_app/view/bookdetails/bookdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Book_card extends StatefulWidget {
  const Book_card({super.key,this.email_id,this.author,this.bookfile,this.bookid,this.thumbnail,this.title});
  final  email_id;
  final  thumbnail;
  final  title;
   final author;
    final bookfile;
     final  bookid;


  @override
  State<Book_card> createState() => _Book_cardState();
}

class _Book_cardState extends State<Book_card> {

// void func(){
//    context.read<favcontroller>().isfav(
//                   context: context,
//                   email_id: widget.email_id,
//                   author: widget.author,
//                   bookfile: widget.bookfile,
//                   bookid: widget.bookid,
//                   thumbnail: widget.thumbnail,
//                 ).then((value)async{
//                   if(value == true){
//                     isfav = true;
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("Book is already added to your favorite"),
//                       ),
//                     );
//                   }
//                   else{
//                     isfav = false;
                   
                   
//                   }
//                 });

// }


  List<Map<String, dynamic>> pdfdata = [];
  void getpdf()async
{
final pdfres = await FirebaseFirestore.instance.collection("books").get();
pdfdata= pdfres.docs.map((e)=> e.data()).toList();
setState(() {
  
});
}
 CollectionReference CollectionRef = FirebaseFirestore.instance.collection("books");
     final user = FirebaseAuth.instance.currentUser;
    //  bool? isfav;

  @override
  Widget build(BuildContext context) {
   
    return Container(
      
      child: InkWell(
            onTap: () {

                // context.read<favcontroller>().isfav(
                //   context: context,
                //   email_id: widget.email_id,
                //   author: widget.author,
                //   bookfile: widget.bookfile,
                //   bookid: widget.bookid,
                //   thumbnail: widget.thumbnail,
                // ).then((value)async{
                //   if(value == true){
                //     isfav = true;
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content: Text("Book is already added to your favorite"),
                //       ),
                //     );
                //   }
                //   else{
                //     isfav = false;
                //   }
                // });


               Navigator.push(context, MaterialPageRoute(builder: (context)=> Bookdetails(
                email_id: widget.email_id,
                thumbnail: widget.thumbnail,
                title:widget.title ,
                author: widget.author,
                bookfile:widget.bookfile,
                bookid: widget.bookid,
              //  isFavorite: isfav,
               )
               )
               );
              },
              child:  
              Column(
                children: [
                  Container(
                    height: 140,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      // color: const Color.fromARGB(255, 223, 29, 29),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    child: 
                   widget.thumbnail != null
                    ? Image.network(
                        widget.thumbnail!,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return 
                          ColorFiltered(
            colorFilter: ColorFilter.matrix(<double>[
              0.2126, 0.7152, 0.0722, 0, 0,  // red contribution
              0.2126, 0.7152, 0.0722, 0, 0,  // green contribution
              0.2126, 0.7152, 0.0722, 0, 0,  // blue contribution
              0, 0, 0, 1, 0,                // alpha
            ]),
            child: 
                          Image.asset("assets/weblogo.png", height: 150, fit: BoxFit.cover));
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      )
                    : Image.asset("assets/weblogo.png", height: 150, fit: BoxFit.cover),
                    ),
                    
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                      color: Color.fromARGB(194, 255, 255, 255),
                        boxShadow: [
                              BoxShadow(offset: Offset(0, 10),
                              blurRadius: 33,
                               color: Color.fromARGB(255, 92, 91, 91),
                               )
                             
                            ]
                  
                    ),
child:  Column(
  children: [
    RichText(
  text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              
                              children: [
                                TextSpan(text: widget.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                                
                              ]
                            )),
                            RichText(
  text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              
                              children: [
                                TextSpan(text: widget.author,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                
                              ]
                            )),
  ],
)
                  ),
                ],
              )
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
                                                            // SizedBox(height: 10,),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Container(
              //     // width: double.infinity,
              //     height: 280,
              //     width: 202,
              //     // decoration: BoxDecoration(color: Color.fromARGB(205, 255, 255, 255),borderRadius: BorderRadius.circular(29),boxShadow: [BoxShadow(offset:Offset(0, 10),blurRadius: 10,color: Colors.grey.withOpacity(.84) )]),
              //   child: Stack(
              //     children: <Widget>[
              //         Positioned(
              //           top: 10,
              //           bottom: 0,
              //           left: 0,
              //           right: 0,
              //           child: Container(
              //             height: 250,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(29),
              //               boxShadow: [
              //                 BoxShadow(offset: Offset(0, 10),
              //                 blurRadius: 33,
              //                  color: const Color.fromARGB(255, 132, 131, 131),
              //                  )
                             
              //               ]
              //               ),
              //           ),
              //         ),
              //         ClipRRect(
              //       borderRadius: BorderRadius.circular(20),
              //       child: 
              //       widget.thumbnail !=null ? 
              //       Image.network(widget.thumbnail,height: 150,fit: BoxFit.cover,)
              //       : Image.asset("assets/weblogo.png")
              //       ),
              //       Positioned(
                      
              //         child: Column(
              //           children: [ Container(
              //           height: 85,
              //           width: 202,
              //           child: Column(
              //             children: [
              //               RichText(text: TextSpan(
              //                 style: TextStyle(color: Colors.black),
              //                 children: [
              //                   TextSpan(text: widget.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              //                   TextSpan(text: widget.author,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              //                 ]
              //               ))
              //             ],
              //           ),

              //       )
              //           ]
              //       )
              //     )

              //     ],
              //     ),




              //   // child: Column(
              //   // children: [
              //   //   //  ClipRRect(
              //   //   //   borderRadius: BorderRadius.circular(20),
              //   //   //   child: 
              //   //   //   widget.thumbnail !=null ? 
              //   //   //   Image.network(widget.thumbnail,fit: BoxFit.cover,width: double.infinity,height: 130,)
              //   //   //   : Image.asset("assets/weblogo.png")
              //   //   //   ),
              //   // // Container(
              //   // // decoration: BoxDecoration(color: Color.fromARGB(140, 255, 77, 0),borderRadius: BorderRadius.circular(20),boxShadow: [BoxShadow(offset:Offset(0, 20),blurRadius: 20,color: Colors.grey.withOpacity(.84) )]),
              //   // // height: 50,
              //   // // width: double.infinity,
              //   // // child: Column(
              //   // //   children: [
              //   // //     Text(widget.title.toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: const Color.fromARGB(255, 255, 255, 255)),),
              //   // //      Text(widget.author,style: TextStyle(fontWeight: FontWeight.w900,color: const Color.fromARGB(255, 255, 255, 255)),),
              //   // //   ],
              //   // // ),
                
              //   // // ),
                          
                 
                 
                    
                         
              //   //     ]
              //   // ),
              //   ),
              // ),
                       
      ),
    );
  }
}