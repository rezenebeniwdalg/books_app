import 'package:books_app/view/favourite/favourite.dart';
import 'package:books_app/view/homescr/homescr.dart';
import 'package:books_app/view/recent/recent.dart';
import 'package:books_app/view/searchscr/searchscr.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key,this.emailid});
   final  emailid;

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
 
  List<Widget> screesList = [
    HomeScr(),
  //  SearchScr(),
  FavTabScreen(),
   recentscr(),
   Container(color: Colors.pinkAccent,)
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home),
      // Icon(Icons.search),
      Icon(Icons.favorite_border_outlined),
      Icon(Icons.history),
       Icon(Icons.settings),
    ];
    return Container(
      color: Colors.orange,
      child: SafeArea(
        top: false,
        // bottom: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            body: screesList[selectedIndex],
            bottomNavigationBar: 
            
            Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData( color: Colors.white),
                
              ),
              child: CurvedNavigationBar(
                
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: Color.fromARGB(209, 9, 43, 212),
                color: Color.fromARGB(225, 255, 115, 0),
                height: 60,
                
                onTap: (value) {
                  // if (value != 2) {
                    
                    selectedIndex = value;
                    setState(() {});
                  // } else {
                  //   // Navigator.push(
                  //   //     context,
                  //   //     MaterialPageRoute(
                  //   //       builder: (context) => CreatePostScreen(),
                  //   //     ));
                  // }
                },
                // type: BottomNavigationBarType.fixed,
                // currentIndex: selectedIndex,
                items: items,
                // [
              
                  // const BottomNavigationBarItem(
                    
                  //   icon: Icon(Icons.home),
                  //   label:  "HOME",
                  // ),
                  // const BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
                 
              
                  // // center bottm nav  button
                  // // BottomNavigationBarItem(
                  // //     icon: Container(
                  // //         decoration: BoxDecoration(
                  // //             borderRadius: BorderRadius.circular(5),
                  // //             border: Border.all()),
                  // //         child: const Icon(Icons.add)),
                  // //     label: ""),
                  // const BottomNavigationBarItem(
                  //     icon: Icon(Icons.favorite_border_outlined), label: "FAVOURITE"),
                  //       const BottomNavigationBarItem(
                  //     icon: Icon(Icons.history), label: "RECENT"),
                  // const BottomNavigationBarItem(
                  //     icon: Icon(Icons.settings),
                  //     label: "SETTINGS"),
                // ]
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}