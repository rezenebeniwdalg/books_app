import 'package:books_app/view/homescr/homescr.dart';
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
   Container(
    color: Colors.amberAccent,
   ),
   Container(color: Colors.lightBlueAccent,),
   Container(color: Colors.lightGreenAccent,),
   Container(color: Colors.pinkAccent,)
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screesList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: [
          const BottomNavigationBarItem(
            
            icon: Icon(Icons.home),
            label:  "HOME",
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
         

          // center bottm nav  button
          // BottomNavigationBarItem(
          //     icon: Container(
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(5),
          //             border: Border.all()),
          //         child: const Icon(Icons.add)),
          //     label: ""),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: "FAVOURITE"),
                const BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "RECENT"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "SETTINGS"),
        ],
      ),
    );
  }
}