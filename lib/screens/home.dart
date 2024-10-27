import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text("Home Page"),centerTitle: true,),// created an app bar for the home screen
      body: Center(child:Text("Welcome to the UIC Student Task Manager!"),),); // placeholder text in center of the screen
}
}