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
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Image.asset("assets/weblogo.png",scale: 2.5,),
            SizedBox(height: 50,),
                Container(
                  child: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: "e-mail",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    
                  ),
            
                ),
                 SizedBox(height: 20,),
                TextFormField(
                  
                  controller: _pass,
                   decoration: InputDecoration(
                      hintText: "password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                  ),
                    obscureText: true,
                ),
                 SizedBox(height: 20,),
                ElevatedButton(
                 
                  
                    onPressed: ()async{
                    if(_email.text.isNotEmpty && _pass.text.isNotEmpty){
                      context.read<logcrcontroller>().login(context: context, email: _email.text, password: _pass.text).then((value) {
            if (value == true) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.greenAccent,content: Text("Success")));
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScr(emailid: _email,)), (route) => false);
            }else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("LOGIN Failed")));
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
                SizedBox(height: 20,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account? ",style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.6)),),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> register()));
                        },
                        child: Text("Register",style: TextStyle(color: Colors.blue))),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}