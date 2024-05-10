import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, 
        children: [
        Text("Friend Slambook", style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900), )
        ]),
    );
  }
}