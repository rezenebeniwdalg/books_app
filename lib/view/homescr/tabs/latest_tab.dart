import 'package:books_app/view/homescr/card/book%20_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LatestDataScreen extends StatefulWidget {
  @override
  _LatestDataScreenState createState() => _LatestDataScreenState();
}

class _LatestDataScreenState extends State<LatestDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recently added books'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('books')
            .orderBy('timestamp', descending: true)
            .limit(20) // Limit the number of documents to retrieve
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }
          
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 45,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
    var document = snapshot.data!.docs[index];
              var data = document.data() as Map<String, dynamic>;
              
              // Check for null values in your fields to avoid the null issue
              var title = data['title'] ?? 'No title';
              var description = data['description'] ?? 'No description';
        //        var latestDoc = snapshot.data!.docs.first;
        // var data = latestDoc.data() as Map<String, dynamic>;
        //       var document = snapshot.data!.docs[index];
              // Customize how you want to display the data
              return Book_card(
              
               thumbnail: snapshot.data!.docs[index]['image'] ,
title: snapshot.data!.docs[index]['title'],
author: snapshot.data!.docs[index]['auth'],
bookfile:snapshot.data!.docs[index]['file'] ,
bookid: snapshot.data!.docs[index].id

              );
            },
          );
        },
      ),
    );
  }
}
