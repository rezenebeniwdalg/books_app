import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class favcontroller with ChangeNotifier{
  bool isloading = false;
 Future <bool> isfav(
  
  {
    required BuildContext context,
  
   
   required email_id,
   required author,
   required bookfile,
   required bookid,
   required thumbnail
   }
 )async{
 try {
  isloading = true;
  notifyListeners();
 final QuerySnapshot snapshot = await 
FirebaseFirestore.instance.collection('favourites').where("userid", isEqualTo:email_id).where("bookfile", isEqualTo: bookfile).get();
 if (snapshot.docs.isNotEmpty) {
        isloading = false;
        notifyListeners();
        return true;
      } else {
        isloading = false;
        notifyListeners();
        return false;
      }

  // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //   email: email,
  //   password: password,
    
    
  // );
  // if (credential.user?.uid != null) {
  //   isloading = false;
  // notifyListeners();
  //   return true;
  // }
 }on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("weak password")));
    isloading = false;
  notifyListeners();
    return false;
    }
     else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("account exists")));
   isloading = false;
  notifyListeners();
    return false;
  }
  } catch (e) {
  print(e);
  isloading = false;
  notifyListeners();
  return false;
}
isloading = false;
  notifyListeners();
return false;
}


}