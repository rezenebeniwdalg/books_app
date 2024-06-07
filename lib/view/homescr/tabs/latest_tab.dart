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
        title: Text('Latest Data'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('books')
            .orderBy('timestamp', descending: true)
            .limit(10) // Limit the number of documents to retrieve
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              // Customize how you want to display the data
              return ListTile(
                title: Text(document['title']),
                subtitle: Text(document['description']),
              );
            },
          );
        },
      ),
    );
  }
}
