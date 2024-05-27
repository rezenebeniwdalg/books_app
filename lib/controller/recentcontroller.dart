

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class recentcontroller{
   static List reverselist = [];
  static List recentlistkeys = [];
  static var box = Hive.box('recent');

   static Future<void> clearHiveStorage() async {
  //  if (box != null) {
    //    await box.clear();
      await box.clear();
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //   SnackBar(content: Text('Hive storage cleared')),
      // );
    // }
  }

  
static getinitkeys(){
  recentlistkeys = box.keys.toList().reversed.toList();
  // reverselist = box.keys.toList();
}

static Future<void> deleterecent(var key)async{
  await box.deleteAt(key);
   recentlistkeys = box.keys.toList();
  // reverselist =recentlistkeys.reversed.toList();
 
  
}
  static Future<void> addrecent({
required String title,
required String author,
required String url,
required String image,
  })async{
await box.add({
'title': title,
'author': author,
'url': url,
'image': image,

});


recentlistkeys = box.keys.toList().reversed.toList();
// reverselist = recentlistkeys.reversed.toList();
  }
}