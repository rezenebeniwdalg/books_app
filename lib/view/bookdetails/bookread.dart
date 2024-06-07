import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class bookread extends StatefulWidget {
  const bookread({super.key,this.bookfile,this.title_});
final bookfile;
final title_;

  @override
  State<bookread> createState() => _bookreadState();
}

class _bookreadState extends State<bookread> {
  bool lock = true;
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
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title_),
        centerTitle: true,
        actions: [
          Tooltip(
            message: 'Wakelock',
            child: IconButton(icon: Icon((lock == true) ? Icons.lock : Icons.lock_open_outlined),onPressed: _toggleWakelock,)
            )
        ],
        // centerTitle: true,
      ),
      body: SfPdfViewer.network(widget.bookfile,scrollDirection: PdfScrollDirection.horizontal,pageLayoutMode: PdfPageLayoutMode.single,enableDoubleTapZooming: true,) ,
      // body: ,
    );
  }
}