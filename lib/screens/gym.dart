import 'package:flutter/material.dart';

class GymPage extends StatelessWidget {
  const GymPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text("Gym Page"),centerTitle: true,),// created an app bar for the gym screen
      body: Center(child:Text("Let's get them gains!"),),); // placeholder text in center of the screen
  }
}