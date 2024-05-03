import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class logcrcontroller with ChangeNotifier{
  bool isloading = true;
 Future <bool> login(
  
  {required BuildContext context, required String email,required String password}
 )async{
 try {
  isloading = true;
  notifyListeners();
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
    
  );
  if (credential.user?.uid != null) {
    isloading = false;
  notifyListeners();
    return true;
  }
 }on FirebaseAuthException catch (e) {
  log(e.code);
  if (e.code == 'invalid-credential') {
    print('No user found for that email.');
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("user with this email not found")));
    isloading = false;
  notifyListeners();
    return false;
    }
     else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("wrong password")));
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