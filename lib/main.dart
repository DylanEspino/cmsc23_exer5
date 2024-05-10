import 'form.dart';
import 'package:exer5/friends.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List friendsList = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exercise 5",
      home: FriendsList(friendsList),
      onGenerateRoute: (settings) {
        List friendsList = settings.arguments as List; 
        if(settings.name == FriendsList.routename){
          return MaterialPageRoute(builder: (context) => FriendsList(friendsList));
        }

        if(settings.name == SlambookForm.routename){
          return MaterialPageRoute(builder: (context) => SlambookForm(friendsList));
        }
      },
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}