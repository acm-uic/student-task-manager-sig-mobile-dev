import 'package:flutter/material.dart';

import '../widgets/general/bottom_tab_navigator.dart';

class ThoughtsPage extends StatelessWidget {
  const ThoughtsPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return (
       Scaffold (
        appBar: AppBar(
          title: Text("Thoughts Page"), 
          centerTitle: true,
        ),
        body: const Center (
          child: Text ("Let's think big thoughts.")
        ),
        bottomNavigationBar: bottomTabNavigator(),
      )
    );
  }
}