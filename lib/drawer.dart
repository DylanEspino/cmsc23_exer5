import 'form.dart';
import 'package:exer5/friends.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final List friendsList;
  const DrawerWidget(this.friendsList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 8, 3, 255)),
            child: Text("Exercise 5: Menu, Routes, and Navigation", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: const Text("Friends List"),
            onTap: (){
              Navigator.pushNamed(context, FriendsList.routename, arguments: friendsList);
            }
          ),
          ListTile(
            title: const Text("Slambook Form"),
            onTap: (){
              Navigator.pushNamed(context, SlambookForm.routename, arguments: friendsList);
            }
          )
        ]
      ),
    );
  }
}