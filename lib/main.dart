import 'package:flutter/material.dart';
import 'package:news/auth_gate.dart';
//import 'package:news/news_screen.dart';
import 'package:news/news_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final NewsService newsService=NewsService();

  
  @override
  Widget build(BuildContext context) {
    newsService.fetchnews('technology','en');
    return  MaterialApp(
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Authgate(),
        debugShowCheckedModeBanner: false,
      );
      
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text("Welcome ${user?.email ?? 'User'}")),
      body: Center(child: Text("You're signed in!")),
    );
  }
}
