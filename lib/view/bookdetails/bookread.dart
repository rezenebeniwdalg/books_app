import 'dart:developer';

import 'package:books_app/controller/recentcontroller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class bookread extends StatefulWidget {
  const bookread({super.key,this.bookfile,this.title_,this.author,this.image,});
final bookfile;
final title_;
final author;

final image;


  @override
  State<bookread> createState() => _bookreadState();
}

class _bookreadState extends State<bookread> {
void addrecent({
required String title_,
required String author,
required String bookfile,
required String image,
required String lastReadPage,
  })async{
await box.add({
  'lastread': lastReadPage ,
'title': title_,
'author': author,
'url': bookfile,
'image': image,

});

setState(() {
   recentcontroller.recentlistkeys= box.keys.toList().reversed.toList();
});

// reverselist = recentlistkeys.reversed.toList();
  }



   var box = Hive.box('recent');
  bool lock = true;
  bool single = true;
  bool scroll = true;
   late PdfViewerController _pdfViewerController;
   var lastReadPage = 1;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable(); 
    _pdfViewerController = PdfViewerController();
    _loadLastReadPage();
  // Enable wakelock initially
  }
  Future<void> _loadLastReadPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var lastReadPage = (prefs.getInt(widget.bookfile) ?? 1);
      _pdfViewerController.jumpToPage(lastReadPage);
    });
  }
  Future<void> _saveLastReadPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(widget.bookfile, _pdfViewerController.pageNumber);
  }

  @override
  void dispose() {
    WakelockPlus.disable(); // Ensure wakelock is disabled when the widget is disposed
    super.dispose();
  }
   void _toggleWakelock() {
      setState(() {
      lock = !lock;
      if (lock) {
        WakelockPlus.enable();
        log('wake')
;      } else {
        WakelockPlus.disable();
      }
    
    });


  }
void _scrolldir(){
  setState(() {
    single = !single;
//     if(single){
// scroll==false;
//     }
//     else{
// scroll==true;
//     }
  });
}


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {

           _saveLastReadPage();
              print('Last read page for ${widget.bookfile}: ${_pdfViewerController.pageNumber}');
                addrecent(title_: widget.title_, author: widget.author, bookfile: widget.bookfile,image: widget.image,lastReadPage: lastReadPage.toString() );
              Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),

        title: Text(widget.title_),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _scrolldir,
           icon: Transform.rotate(angle: single ? 0 : 3.14/2,child: Icon(Icons.view_carousel))),

          Tooltip(
            message: 'Wakelock',
            child: IconButton(icon: Icon(lock ? Icons.lock : Icons.lock_open_outlined),onPressed: _toggleWakelock,)
            )
        ],
        // centerTitle: true,
      ),
      body: SfPdfViewer.network(widget.bookfile,
      controller: _pdfViewerController,
    
      scrollDirection: single ? PdfScrollDirection.vertical : PdfScrollDirection.horizontal
       ,
      
      pageLayoutMode: PdfPageLayoutMode.single,enableDoubleTapZooming: true,) ,
      // body: ,
    );
  }
}