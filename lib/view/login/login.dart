import 'package:books_app/controller/login_controller.dart';
import 'package:books_app/view/homescr/homescr.dart';
import 'package:books_app/view/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebasetrial/controller/logcontroller.dart';
// import 'package:firebasetrial/home.dart';
// import 'package:firebasetrial/view/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   TextEditingController _email = TextEditingController();
     TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                child: Text("LOGIN"),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _email,
              ),
               SizedBox(height: 20,),
              TextFormField(
                controller: _pass,
                  obscureText: true,
              ),
               SizedBox(height: 20,),
              InkWell(
               
                
                  onTap: ()async{
                  if(_email.text.isNotEmpty&&_pass.text.isNotEmpty){
                    context.read<logcrcontroller>().login(context: context, email: _email.text, password: _pass.text).then((value) {
if (value == true) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.greenAccent,content: Text("Success")));
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScr()), (route) => false);
}else {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     backgroundColor: Colors.red,
                        //     content: Text("Registration Failed")));
                      }
                    });
//                   try {
//   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: _email.text,
//     password: _pass.text,
    
//   );
//   if (credential.user?.uid != null) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.greenAccent,content: Text("registered")));
//   }
//    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Login()), (route) => false);
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//     print('The password provided is too weak.');
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("weak password")));
//   } else if (e.code == 'email-already-in-use') {
//     print('The account already exists for that email.');
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("account exists")));
//   }
// } catch (e) {
//   print(e);
// }
    // }           
                                
      
    //             },
                    } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Enter a valid email and password")));
                  }
                },
               
                child: Container(
                      child: Text("Login")
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text("Dont have an account ? "),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> register()));
                      },
                      child: Text("Register")),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}