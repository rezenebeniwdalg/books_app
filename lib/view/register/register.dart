import 'package:books_app/controller/register_controller.dart';
import 'package:books_app/view/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController _email = TextEditingController();
     TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
       final providerobj = context.watch<regscrcontroller>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset("assets/weblogo.png",scale: 2.5,),
                SizedBox(height: 20,),
              Container(
                child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    
                  ),
              ),
               SizedBox(height: 20,),
               providerobj.isloading
               ? CircularProgressIndicator() :
              ElevatedButton(
                onPressed: (){  if (_email.text.isNotEmpty &&
                          _pass.text.isNotEmpty) {
                        // registration funciton
                        context
                            .read<regscrcontroller>()
                            .register(
                                context: context,
                                email: _email.text,
                                password: _pass.text)
                            .then((value) async{
                              // final user = FirebaseAuth.instance.currentUser;
                              // await user?.updateDisplayName("jane q user");
                          if (value == true) {
                            // login success
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Registration Successs")));
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                                (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Registration Failed")));
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Enter a valid email and password")));
                      }
                    },
                child: Container(
                      child: Text("Register")
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("aleady have an account? ",style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.6)),),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                      },
                      child: Text("Login",style: TextStyle(color: Colors.blue))),
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