import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ott_photo_play/view/login/login_view.dart';
//import 'package:ott_photo_play/view/login/register_view.dart';
//import 'package:ott_photo_play/view/main_tab/main_tab_view.dart';
// import 'package:ott_photo_play/view/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTT Photo Play',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Gotham",
        useMaterial3: true,
      ),
      home: const LoginView(), 
    );
  }
}



