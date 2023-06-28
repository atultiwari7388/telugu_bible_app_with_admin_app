import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telugu_admin/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    //run for web
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBF0mnoQm8nMJGgwM2ae47zuUBkTfiIvn4",
        authDomain: "telugu-bible-1a907.firebaseapp.com",
        // databaseURL: ,
        projectId: "telugu-bible-1a907",
        storageBucket: "telugu-bible-1a907.appspot.com",
        messagingSenderId: "241293524966",
        appId: "1:241293524966:web:ee10864d4decda3e076027",
      ),
    );
  } else {
    //run for android
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telugu Bible',
      theme: ThemeData(
        primaryColor: const Color(0xFFEEEEEE),
      ),
      home: const SplashScreen(),
    );
  }
}
