import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';


class GymPage extends StatelessWidget {
  const GymPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return (
        Scaffold (
          appBar: AppBar(
            title: Text("UIC Task Manager"),
            centerTitle: true,
          ),
          body: const Center (
            child: Text ("Let's get them gains!")
          ),
          bottomNavigationBar: bottomTabNavigator(),
        )
      );
    }
  }