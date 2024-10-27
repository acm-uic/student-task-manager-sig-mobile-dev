import 'package:flutter/material.dart';

class ThoughtsPage extends StatelessWidget {
  const ThoughtsPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text("Thoughts Page"),centerTitle: true,),// created an app bar for the thoughts screen
      body: Center(child:Text("Uhh think I guess..."),),); // placeholder text in center of the screen
  }
}