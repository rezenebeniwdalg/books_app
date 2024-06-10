// import 'package:flutter/material.dart';

// class SearchScr extends StatelessWidget {
//   const SearchScr({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(height: 30,),
       
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//         IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
//                 Container(
//                   height: MediaQuery.sizeOf(context).height * .1,
//                   width: MediaQuery.sizeOf(context).width * .8,
//                   child: TextFormField(
                    
//                     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:books_app/view/bookdetails/bookdetails.dart';
import 'package:books_app/view/homescr/card/book%20_card.dart';
import 'package:books_app/view/homescr/tabs/all_tab.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScr extends StatefulWidget {
const SearchScr({super.key,this.email_id});
final email_id;

  @override
  _SearchScrState createState() => _SearchScrState();
}

class _SearchScrState extends State<SearchScr> {
  TextEditingController _searchController = TextEditingController();
  Stream<QuerySnapshot>? searchResults;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchResults = searchInFirestore(_searchController.text);
      });
    });
  }

  Stream<QuerySnapshot> searchInFirestore(String searchText) {
    // Example query: Search documents in 'books' collection where the title contains searchText
    return FirebaseFirestore.instance
        .collection('books')
        .where('title', isGreaterThanOrEqualTo: searchText)
        .where('title', isLessThanOrEqualTo: searchText + '\uf8ff')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: searchResults != null
          ? StreamBuilder(
              stream: searchResults,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No results found'));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 20),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    // Display search results here
                   
                   return Book_card(
                    title: document['title'],
                    author: document['auth'],
                    thumbnail: document['image'],
    bookfile: document['file'],
    bookid: document.id,
                   );
                    // return ListTile(
                    //   title: Text(document['title']),
                    //   subtitle: Text(document['auth']),
                    //   // Add more fields as needed
                    // );
                  },
                );
              },
            )
          : All_tab_scr(),
    );
  }
}
