import 'dart:developer';

import 'package:books_app/view/bookdetails/bookdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FavTabScreen extends StatefulWidget {
  const FavTabScreen({super.key, this.email_id});
  final  email_id;

  @override
  State<FavTabScreen> createState() => _FavTabScreenState();
}

class _FavTabScreenState extends State<FavTabScreen> {
  String? bookurl;
  final user = FirebaseAuth.instance.currentUser;

  Query? query;
  List<Map<String, dynamic>> pdfdata = [];

  @override
  void initState() {
    super.initState();
    // getpdf();
    if (user != null) {
      query = FirebaseFirestore.instance.collection('favourites')
      .where("userid", isEqualTo: user!.email);
      
    } else {
      log('User email_id is null');
    }
  }

  // void getpdf() async {
  //   final pdfres = await FirebaseFirestore.instance.collection('books').get();
  //   pdfdata = pdfres.docs.map((e) => e.data()).toList();
  //   setState(() {});
  // }
Future<void> deleteDocumentByField({required String userid,required dynamic value,}) async {
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
      body: query != null
          ? StreamBuilder(
              stream: query!.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/introbg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Bookdetails(
                                      email_id: widget.email_id,
                                      thumbnail: snapshot.data!.docs[index]['image'],
                                      title: snapshot.data!.docs[index]['title'],
                                      author: snapshot.data!.docs[index]['auth'],
                                      bookfile: snapshot.data!.docs[index]['file'],
                                      bookid: snapshot.data!.docs[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
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
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(205, 255, 255, 255),
                                                borderRadius: BorderRadius.circular(29),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 20),
                                                    blurRadius: 33,
                                                    color: Colors.grey.withOpacity(.84),
                                                  )
                                                ],
                                              ),
                                              height: 140,
                                              width: double.infinity,
                                              // child: Row(
                                              //   children: [
                                              //     Column(
                                              //       children: [
                                              //         Text(
                                              //           snapshot.data!.docs[index]['title']
                                              //               .toString()
                                              //               .toUpperCase(),
                                              //           style: TextStyle(
                                              //             fontWeight: FontWeight.w900,
                                              //             fontSize: 20,
                                              //             color: Colors.deepOrange,
                                              //           ),
                                              //         ),
                                              //         Text(snapshot.data!.docs[index]['auth']),
                                                     
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.network(
                                                snapshot.data!.docs[index]['image'],
                                                fit: BoxFit.fitHeight,
                                                width: 120,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 65,
                                            left: 150,
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]['title']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20,
                                                    color: Colors.deepOrange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 95,
                                            left: 150,
                                            child: Column(
                                              children: [
                                                Text(snapshot.data!.docs[index]['auth']),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 45,
                                            right: 20,
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {

                                                     deleteDocumentByField(userid: snapshot.data!.docs[index]['userid'],value: snapshot.data!.docs[index]['title'] ) ; 
                                                  },
                                                  icon: Icon(Icons.remove_circle),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                );
              },
            )
          : Center(child: Text('User email_id is null')),
    );
  }
}
