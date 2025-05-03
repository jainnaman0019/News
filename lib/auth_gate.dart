import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:news/main.dart';
import 'package:news/login_screen.dart';
import 'package:news/news_screen.dart';

class Authgate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      else if(!snapshot.hasData){
        return LoginScreen();
      }
      else{
        return NewsScreen();
      }
      }
    );
  }
}