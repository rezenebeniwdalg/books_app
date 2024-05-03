import 'package:books_app/controller/login_controller.dart';
import 'package:books_app/controller/register_controller.dart';
import 'package:books_app/firebase_options.dart';
import 'package:books_app/view/splashscr/splashscr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BooksApp());
}
class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => regscrcontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => logcrcontroller(),
        )
      ],
      child: MaterialApp(
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
             if (snapshot.hasData) {
              return SplashScreen(
                isalreadylogged: true,
              );
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
