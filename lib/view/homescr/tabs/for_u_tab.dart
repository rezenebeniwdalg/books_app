import 'package:flutter/material.dart';

class For_u_tab extends StatefulWidget {
  const For_u_tab({super.key});

  @override
  State<For_u_tab> createState() => _For_u_tabState();
}

class _For_u_tabState extends State<For_u_tab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/introbg.jpg",),
            fit: BoxFit.cover)
            ),
            child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Recommended",style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold,fontSize: 15),),
                    )),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Recommended",style: TextStyle(color: Colors.orangeAccent),),
                    )),
                ),
              ],
            ),
            ),
    );
  }
}