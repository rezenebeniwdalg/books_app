import 'package:flutter/material.dart';

class SearchScr extends StatelessWidget {
  const SearchScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
       
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
        IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
                Container(
                  height: MediaQuery.sizeOf(context).height * .1,
                  width: MediaQuery.sizeOf(context).width * .8,
                  child: TextFormField(
                    
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}