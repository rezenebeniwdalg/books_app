import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final Map<String, bool> _favoriteStatus = {};

  bool isFavorite(String bookId) {
    return _favoriteStatus[bookId] ?? false;
  }

  final CollectionReference collectionRef = FirebaseFirestore.instance.collection("favourites");

  void toggleFavorite({
    required String userid,
    required String bookId,
    required String title,
    required String author,
    required String image,
    required String file,
  }) async {
    if (_favoriteStatus[bookId] == true) {
      await _removeFromFavorites(userid, bookId, title);
      _favoriteStatus[bookId] = false;
      log('Removed from favorites');
    } else {
      await _addToFavorites(userid, bookId, title, author, image, file);
      _favoriteStatus[bookId] = true;
      log('Added to favorites');
    }
    notifyListeners();
  }

  Future<void> _addToFavorites(String userid, String bookId, String title, String author, String image, String file) async {
    await collectionRef.add({
      "userid": userid,
      "bookId": bookId,
      "title": title,
      "auth": author,
      "image": image,
      "file": file,
    });
  }

  Future<void> _removeFromFavorites(String userid, String bookId, String title) async {
    QuerySnapshot querySnapshot = await collectionRef
        .where("title", isEqualTo: title)
        .where("userid", isEqualTo: userid)
        .where("bookId", isEqualTo: bookId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
        log('Document with "bookId" = $bookId and "title" = $title deleted');
        
      }
    } else {
      log('No document found with "bookId" = $bookId and "title" = $title');
    }
  }
}
