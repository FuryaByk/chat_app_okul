import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'listview_kullanimi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyC2OgK9ucOY9ardLndqlKQP8etWWhwTpy4",
        appId: "1:1016066838635:android:5d83ae6e55b0a82d7b612e",
        messagingSenderId: "1016066838635",
        projectId: "mirciler-chat-app-ysmn"),
  );
  runApp(MaterialApp(
    home: WelcomeScreen(),
  ));
}

// void main() {
//   runApp(MaterialApp(
//     home: WelcomeScreen(),
//   ));
// }
