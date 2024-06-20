import 'package:books_app/controller/recentcontroller.dart';
import 'package:books_app/view/bookdetails/bookread.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class recentscr extends StatefulWidget {
  const recentscr({super.key});

  @override
  State<recentscr> createState() => _recentscrState();
}

class _recentscrState extends State<recentscr> {

  var box = Hive.box('recent');
   void clearHiveStorage()async{
    
    
     await box.clear();
    setState(() {
      recentcontroller.recentlistkeys.clear();
    });;
    
  }


   
@override
void initState(){
  recentcontroller.getinitkeys();
  super.initState();
 var box = Hive.box('recent');
}


  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed:
          clearHiveStorage, 
          // ()async{
          //    clearHiveStorage;
          //    setState(() {
               
          //    });
          //   // recentcontroller.clearHiveStorage;
          //   showDialog(context: context, builder: (context)=> AlertDialog(
          //     title: Text("Recent"),
          //     content: Text("Are you sure you want to clear all recent data?"),
          //     contentPadding: EdgeInsets.all(20.0),
          //     actions: [
          //       TextButton(onPressed:()async{
          //         clearHiveStorage;
          //         setState(() {
                    
          //         });
          //         Navigator.of(context).pop();
          //       },child: Text('ok'),),
          //     ],
          //   ));

          // },
           icon: Row(
             children: [
               Icon(Icons.remove_circle_outline_outlined,size: 18,),
               Text("clear all"),
             ],
           ))
        ],),
        body: Container(
          height: double.infinity,
          child: ListView.builder(
           
            itemCount: recentcontroller.recentlistkeys.length,
            itemBuilder: (context, index) {
            final currentkey = recentcontroller.recentlistkeys[index];
            final currentelement =recentcontroller.box.get(currentkey);
            return InkWell(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => bookread(
                            bookfile: currentelement['url'],
                            title_: currentelement['title'],
                            // author: widget.author,
                            // image: widget.thumbnail,
                          ),
                        ),
                      );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                 
                  child: Row(children: [
                    CircleAvatar(
                      child: Image.network(currentelement['image'],height: 100,width: 100,fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 10),
                    Text(currentelement['title']),
                    SizedBox(width: 10),
                    Text('|'),
                    SizedBox(width: 10),
                    Text(currentelement['author']),
                    
                    // IconButton(onPressed: (){
                    //   recentcontroller.box.delete(currentkey);
                    //   recentcontroller.deleterecent(currentkey);
                    //   setState(() {
                        
                    //   });
                    // }, icon: Icon(Icons.remove_circle_outline))
                    
                  ],),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}