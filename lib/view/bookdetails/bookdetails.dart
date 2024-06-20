// import 'dart:developer';
// import 'package:books_app/view/bookdetails/bookread.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// class Bookdetails extends StatefulWidget {
//   const Bookdetails({
//     Key? key,
//     this.email_id,
//     this.author,
//     this.thumbnail,
//     this.title,
//     this.bookfile,
//     this.bookid,
//   }) : super(key: key);
//   final String? thumbnail;
//   final String? title;
//   final String? author;
//   final String? bookfile;
//   final String? bookid;
//   final String? email_id;
//   @override
//   State<Bookdetails> createState() => _BookdetailsState();
// }
// class _BookdetailsState extends State<Bookdetails> {
//   final User? user = FirebaseAuth.instance.currentUser;
//   var box = Hive.box('recent');
//   bool isfav = false;
//   @override
//   void initState() {
//     super.initState();
//     checkIfFavorite();
//     setState(() {
//     });
//     // _toggleFavorite(userid: widget.email_id.toString(), value: widget.title.toString());
//   }
//   Future<void> checkIfFavorite() async {
//     log('Checking if book is favorite');
//      QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('favourites')
//         .where("userid", isEqualTo: user?.email)
//         .where("bookfile", isEqualTo: widget.bookfile)
//         .get();
//     if (snapshot.docs.isNotEmpty) {
//       // setState(() {
//         isfav = true;
//          log('Book is marked as favorite');
//       // });
//     } else
//     if(snapshot.docs.isEmpty)
//      {
//       setState(() {
//         isfav = false;
//         log('Book is not marked as favorite');
//       });
//     }
//   }
//   Future<void> _toggleFavorite({
//     required String userid,
//     required String value,
//   }) async {
//     log('Toggling favorite status');
//      QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('favourites')
//         .where("userid", isEqualTo: widget.email_id)
//         .where("bookfile", isEqualTo: widget.bookfile)
//         .get();
//     if (snapshot.docs.isEmpty) {
//       CollectionRef.add({
//         "userid": widget.email_id,
//         "title": widget.title,
//         "auth": widget.author,
//         "image": widget.thumbnail ?? "",
//         "file": widget.bookfile ?? ""
//       });
//       log('Added to favourites');
//       setState(() {
//         isfav = true;
//       });
//     } else {
//       deleteDocumentByField(userid, value);
//       log('Removed from favourites');
//       setState(() {
//         isfav = false;
//       });
//     }
//   }
//   CollectionReference CollectionRef =
//       FirebaseFirestore.instance.collection("favourites");
//   Future<void> deleteDocumentByField(String userid, dynamic value) async {
//     QuerySnapshot querySnapshot = await CollectionRef
//         .where("title", isEqualTo: value)
//         .where("userid", isEqualTo: userid)
//         .get();
//     if (querySnapshot.docs.isNotEmpty) {
//       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//         await doc.reference.delete();
//         log('Document with "title" = $value deleted');
//       }
//     } else {
//       log('No document found with "title" = $value');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(widget.title?.toUpperCase() ?? 'No Title'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 widget.thumbnail != null
//                     ? Image.network(
//                         widget.thumbnail!,
//                         height: 150,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return ColorFiltered(
//                             colorFilter: ColorFilter.matrix(<double>[
//                               0.2126, 0.7152, 0.0722, 0, 0, // red contribution
//                               0.2126, 0.7152, 0.0722, 0, 0, // green contribution
//                               0.2126, 0.7152, 0.0722, 0, 0, // blue contribution
//                               0, 0, 0, 1, 0, // alpha
//                             ]),
//                             child: Image.asset(
//                               "assets/weblogo.png",
//                               height: 150,
//                               fit: BoxFit.cover,
//                               filterQuality: FilterQuality.low,
//                             ),
//                           );
//                         },
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Center(
//                             child: CircularProgressIndicator(
//                               value: loadingProgress.expectedTotalBytes != null
//                                   ? loadingProgress.cumulativeBytesLoaded /
//                                       (loadingProgress.expectedTotalBytes ?? 1)
//                                   : null,
//                             ),
//                           );
//                         },
//                       )
//                     : Image.asset(
//                         "assets/weblogo.png",
//                         height: 150,
//                         fit: BoxFit.cover,
//                       ),
//                 SizedBox(width: 20),
//                 Column(
//                   children: [
//                     Text(widget.author?.toUpperCase() ?? 'No Author'),
//                   ],
//                 ),
//                 SizedBox(width: 20),
//               ],
//             ),
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Tooltip(
//                     message: 'Add to favorites',
//                     child: IconButton(
//                       onPressed: () {
//                         _toggleFavorite(
//                           userid: widget.email_id ?? '',
//                           value: widget.title ?? '',
//                         );
//                       },
//                       icon: Icon(
//                         isfav
//                             ? Icons.favorite_rounded
//                             : Icons.favorite_border_outlined,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => bookread(
//                             bookfile: widget.bookfile,
//                             title_: widget.title,
//                             author: widget.author,
//                             image: widget.thumbnail,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 100, vertical: 16),
//                       child: Text("READ"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:books_app/view/bookdetails/bookread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Bookdetails extends StatefulWidget {
  const Bookdetails({
    Key? key,
    this.email_id,
    this.author,
    this.thumbnail,
    this.title,
    this.bookfile,
    this.bookid,
  }) : super(key: key);

  final String? thumbnail;
  final String? title;
  final String? author;
  final String? bookfile;
  final String? bookid;
  final String? email_id;

  @override
  State<Bookdetails> createState() => _BookdetailsState();
}

class _BookdetailsState extends State<Bookdetails> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isfav = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    log('Checking if book is favorite');
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('favourites')
          .where("userid", isEqualTo: user?.email)
          .where("bookfile", isEqualTo: widget.bookfile)
          .get();

      setState(() {
        isfav = snapshot.docs.isNotEmpty;
        log('Book is ${isfav ? "marked" : "not marked"} as favorite');
      });
    } catch (e) {
      log('Error checking if book is favorite: $e');
    }
  }

  Future<void> _toggleFavorite() async {
    log('Toggling favorite status');
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('favourites')
          .where("userid", isEqualTo: user?.email)
          .where("bookfile", isEqualTo: widget.bookfile)
          .get();

      if (snapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('favourites').add({
          "userid": user?.email,
          "title": widget.title,
          "auth": widget.author,
          "image": widget.thumbnail ?? "",
          "bookfile": widget.bookfile,
        });
        log('Added to favorites');
      } else {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          await doc.reference.delete();
          log('Removed from favorites');
        }
      }
      // Update the favorite status after toggling
      setState(() {
        isfav = !isfav;
      });
    } catch (e) {
      log('Error toggling favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new_rounded),),
        centerTitle: true,
        title: Text(widget.title?.toUpperCase() ?? 'No Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.thumbnail != null
                    ? Image.network(
                        widget.thumbnail!,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return ColorFiltered(
                            colorFilter: ColorFilter.matrix(<double>[
                              0.2126, 0.7152, 0.0722, 0, 0, // red contribution
                              0.2126, 0.7152, 0.0722, 0, 0, // green contribution
                              0.2126, 0.7152, 0.0722, 0, 0, // blue contribution
                              0, 0, 0, 1, 0, // alpha
                            ]),
                            child: Image.asset(
                              "assets/weblogo.png",
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        "assets/weblogo.png",
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(widget.author?.toUpperCase() ?? 'No Author'),
                  ],
                ),
                SizedBox(width: 20),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                    message: 'Add to favorites',
                    child: IconButton(
                      onPressed: () {
                        _toggleFavorite();
                      },
                      icon: Icon(
                        isfav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_outlined,color: isfav ? Colors.red : Colors.grey,
                            size: 40,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => bookread(
                            bookfile: widget.bookfile,
                            title_: widget.title,
                            author: widget.author,
                            image: widget.thumbnail,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 16),
                      child: Text("READ"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
