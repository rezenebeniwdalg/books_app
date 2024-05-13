// import 'dart:js_interop';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:books_app/view/homescr/tabs/for_u_tab.dart';
import 'package:books_app/view/login/login.dart';
import 'package:books_app/view/searchscr/searchscr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AdminHomeScr extends StatefulWidget {
  const AdminHomeScr({super.key,this.email_id});
  final  email_id;

  @override
  State<AdminHomeScr> createState() => _AdminHomeScrState();
}

class _AdminHomeScrState extends State<AdminHomeScr> {
  FilePickerResult? result;
  PlatformFile? pickedfile;
  File? filetodisplay;
   var currentTabIndex = 0;
   var bookurl;
  
   final user = FirebaseAuth.instance.currentUser;
     XFile? file;
var url;
TextEditingController title = TextEditingController();
    TextEditingController author = TextEditingController();
     CollectionReference CollectionRef = FirebaseFirestore.instance.collection("books");
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      appBar: AppBar(
    
        // leading: Builder(builder: (context)=>Padding(
        //   padding: const EdgeInsets.only(left: 10),
        //   child: InkWell(
        //     onTap: () {
        //       Scaffold.of(context).openDrawer();
        //     },
        //     child: Icon(Icons.menu,size: 35,)
        //     // Image.asset("assets/weblogo.png",scale: 1,),
        //     // child: SvgPicture.asset("assets/audible-svgrepo-com.svg")
        //     ),
        // ),),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 20,top: 20,right: 80),
          child: Image.asset("assets/logo1.png",),
        ),
        // title: Text("ONBOOKS",style: TextStyle(fontWeight: FontWeight.w900),),
        actions: [
          // IconButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScr()));
          // },icon: Icon(Icons.search,size: 30,),),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child:
             Builder(builder: (context)=>
             InkWell(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
             ),
          )
        ],
      ),
      // drawer: Padding(
      //   padding: const EdgeInsets.only(top: 38,bottom: 20,left: 10),
      //   child: Drawer(
      //      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
              
      //         children: [
      //           DrawerHeader(
                  
      //             child: Container(
      //             color: Colors.amber,
      //           )),
      //           InkWell(
      //             onTap: () {
                    
      //             },
      //             child: Container(
      //               width: double.infinity,
      //               child: Text("RECOMMENDED"),
      //             ),
      //           ),
      //          InkWell(
      //             onTap: () {
                    
      //             },
      //             child: Container(
      //               width: double.infinity,
      //               child: Text("ALL"),
      //             ),
      //           ), InkWell(
      //             onTap: () {
                    
      //             },
      //             child: Container(
      //               width: double.infinity,
      //               child: Text("LATEST"),
      //             ),
      //           ),
      //         ],
      //       ),
          // ),
        // ),
      // ),
      endDrawer: Padding(
        padding: const EdgeInsets.only(top: 80,bottom: 200,right: 10),
        
        child: Drawer(
         backgroundColor: Colors.amberAccent,
        
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          width: MediaQuery.sizeOf(context).width * .8,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                child: UserAccountsDrawerHeader(
                  
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                  currentAccountPicture: CircleAvatar(radius: 20, backgroundImage: NetworkImage("https://images.pexels.com/photos/2295744/pexels-photo-2295744.jpeg?auto=compress&cs=tinysrgb&w=400"),),
                  accountName: Text("ADMIN",style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),),
                   accountEmail: Text(user!.email.toString(),style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold)))
                 ),
              Center(child: Text("data")),
              IconButton(onPressed: ()async{
          await FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Login()), (route) => false);
        }, icon: Icon(Icons.logout))
            ],
          ),
        ),
      ),
      // body:   SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       TabBar(
              
      //                 indicatorWeight: 1,
      //                 dividerHeight: 0,
      //                 indicatorColor: Colors.black,
      //                 labelColor: Colors.black,
      //                 unselectedLabelColor:
      //                     Colors.black.withOpacity(.3),
      //                 indicatorSize: TabBarIndicatorSize.tab,
      //                 onTap: (index) {
      //                   setState(() {
      //                     currentTabIndex = index;
      //                   });
      //                 },
      //                 tabs: [
      //                   Tab(
      //                     text: "FOR U"
      //                   ),
      //                   Tab(
      //                     text: "ALL"
      //                   ),
      //                    Tab(
      //                     text: "LATEST"
      //                   )
      //                 ]),
      //                 Container(
      //              height: MediaQuery.sizeOf(context).height *.9,
      //                   child: TabBarView(children: [
      //                    For_u_tab(),
      //                     Container
      //                     (decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/introbg.jpg",),fit: BoxFit.cover)),),
      //                     Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/introbg.jpg",),fit: BoxFit.cover)),),
      //                   ]),
      //                 )
      //     ],
      //   ),
      // ),
                
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/introbg.jpg",),fit: BoxFit.cover)),
      child: Column(
        children: [
          ElevatedButton(onPressed: ()async{
            final result = await FilePicker.platform.pickFiles();
            type: FileType.any;
            setState(() {
              
            });
            if (result == null) {
              return;
            }
             pickedfile = result.files.first;
             filetodisplay = File(pickedfile!.path.toString());
             final storagerefb = FirebaseStorage.instance.ref();
            var folderrefb = storagerefb.child("Books");
            var uploadrefb = folderrefb.child(pickedfile!.name);
            await uploadrefb.putFile(File(pickedfile!.path.toString()));
            url = await uploadrefb.getDownloadURL();
             bookurl = url;
            log(url.toString());
            print("name:${pickedfile?.name}");
            print("name:${pickedfile?.bytes}");
            print("name:${pickedfile?.size}");
            print("name:${pickedfile?.extension}");
            print("name:${pickedfile?.path}");
            // await saveFilePermanently(file);///
          //    var uniquename = DateTime.now().millisecondsSinceEpoch;
          //    final storageref = FirebaseStorage.instance.ref();
          //   var folderref = storageref.child("BookFiles");
          //   var uploadref = folderref.child("$uniquename.pdf");
          // await uploadref.putFile(File(result!.path));
            // openFile(file);
          }, child: Text("PICK FILE"),),
          Container(
            // child: ,
          ),
          // if(pickedfile != null)
          // SizedBox(
          //   height: 200,
          //   width: 200,
          //   child: File.file(filetodisplay!),
          // ),
          ElevatedButton(onPressed: ()async{
             file = await ImagePicker().pickImage(source: ImageSource.gallery);
               setState(() {
                      
                    });
                      if(file != null){
                      var uniquename = DateTime.now().millisecondsSinceEpoch;
                      // root reference
                      final storageref = FirebaseStorage.instance.ref();
// folder creation
var folderref = storageref.child("Images");

// upload ref
var uploadref = folderref.child("$uniquename.jpg");
await uploadref.putFile(File(file!.path));
 url = await uploadref.getDownloadURL();
log(url.toString());
                    }
                    
          }, child: Column(
            children: [
              Text("pick image"),
              
            ],
          )),
          Container(
                    child: file != null ? CircleAvatar(
                      radius: 40, backgroundImage: FileImage(File(file!.path)),)
                    : CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person),
                    )
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
                       decoration: InputDecoration(
                          filled: true,
                    fillColor: Colors.deepOrangeAccent,
                        hintText: "title",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                                       ),
                                       controller: title,
                                     ),
                   ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      
                       decoration: InputDecoration(
                        filled: true,
                    fillColor: Colors.deepOrangeAccent,
                        hintText: "author name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                    ),
                                 controller: author,
                                    ),
                                 
                  ),
                   ElevatedButton(onPressed: (){CollectionRef.add({"title": title.text, "auth":author.text,"image":url ?? "","file": bookurl ?? ""});
                title.clear();
                author.clear();
                file == null;
                
                
                }, child: Text("add") ),

        ],
      ),
      
      )
    );
//     Future<File> saveFilePermanently(PlatformFile file)async{
// final appstorage =await getApplicationDocumentsDirectory();
// final newFile = File('${appstorage.path}')
//     }
    void openFile(PlatformFile file){
      OpenFile.open(file.path!);
    }
  }
}