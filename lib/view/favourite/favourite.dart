import 'dart:developer';

import 'package:books_app/view/bookdetails/bookdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavTabScreen extends StatefulWidget {
  const FavTabScreen({Key? key,this.email_id}) : super(key: key);
  final email_id;

  @override
  State<FavTabScreen> createState() => _FavTabScreenState();
}

class _FavTabScreenState extends State<FavTabScreen> {
  late Query query;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      query = FirebaseFirestore.instance.collection('favourites').where("userid", isEqualTo: user.email);
    } else {
      log('User email_id is null');
    }
  }

  Future<void> deleteDocumentByField({
    required String userid,
    required dynamic value,
  }) async {
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
              stream: query.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                var documents = snapshot.data!.docs;

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/introbg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Bookdetails(
                                      bookid: documents[index]['bookId'],
                                      email_id: widget.email_id,
                                      thumbnail: documents[index]['image'],
                                      title: documents[index]['title'],
                                      author: documents[index]['auth'],
                                      bookfile: documents[index]['file'],
                                      isFavorite: true,
                                      // bookid: documents[index].id,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                deleteDocumentByField(
                                  userid: documents[index]['userid'],
                                  value: documents[index]['title'],
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
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child:documents[index]['image'] != null
                    ? Image.network(
                        documents[index]['image']!,
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
                                          Positioned(
                                            top: 65,
                                            left: 150,
                                            child: Column(
                                              children: [
                                                Text(
                                                  documents[index]['title'].toString().toUpperCase(),
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
                                                Text(documents[index]['auth']),
                                              ],
                                            ),
                                          ),
                                          // Positioned(
                                          //   top: 45,
                                          //   right: 20,
                                          //   child: Column(
                                          //     children: [
                                          //       IconButton(
                                          //         onPressed: () {
                                          //           deleteDocumentByField(
                                          //             userid: documents[index]['userid'],
                                          //             value: documents[index]['title'],
                                          //           );
                                          //         },
                                          //         icon: Icon(Icons.remove_circle),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
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
