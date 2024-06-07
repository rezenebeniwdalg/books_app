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
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    // Display search results here
                   
                   return InkWell(
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> Bookdetails(email_id: widget.email_id,thumbnail:snapshot.data!.docs[index]['image'] ,title:snapshot.data!.docs[index]['title'] ,author: snapshot.data!.docs[index]['auth'],bookfile:snapshot.data!.docs[index]['file'] ,bookid: snapshot.data!.docs[index].id)));
                    },
                     child: Container(
                      child: Row(
                        children: [
                           Container(
                            height: 100,
                            child: Image.network(document['image'])),
                          Column(
                            children: [
                              Text(document['title']),
                              Text(document['auth']),
                             
                            ],
                          ),
                        ],
                      ),
                     ),
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
          : Center(child: Text('Enter a search query')),
    );
  }
}
