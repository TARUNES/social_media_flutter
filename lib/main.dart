import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/auth/auth.dart';
import 'package:social_media/auth/login_register.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/pages/Homepage.dart';
import 'package:social_media/pages/Profilepage.dart';
import 'package:social_media/pages/user_page.dart';

import 'package:social_media/theme/dark_mode.dart';
import 'package:social_media/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Wall',
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        "/login_register": (context) => LoginOrRegister(),
        "/home_page": (context) => HomePage(),
        "/profile_page": (context) => ProfilePage(),
        "/users_page": (context) => UsersPage(),
        "/auth_page": (context) => AuthPage()
      },
    );
  }
}
