import 'package:flutter/material.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
          title: const Text("UIC Task Manager"),
          backgroundColor: Colors.red,
          centerTitle: true,
      ),
      body: Center(
        child: sectionList(),
      ),
      bottomNavigationBar: bottomTabNavigator(),
    ); // placeholder text in center of the screen
  }
}

Widget sectionList() {
  return ListView.builder(
    itemCount: 5,
    itemBuilder: (context, sectionIndex) {
      return Column(
        children: [
          ListTile(
            title: Text('Section $sectionIndex'),
          ),
          subsectionList(sectionIndex),
        ],
      );
    }
  );
}

Widget subsectionList(int sectionIndex) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: 5,
    itemBuilder: (context, subsectionIndex) {
      return subsectionTask(subsectionIndex);
    },
  );
}

Widget subsectionTask(int subsectionIndex) {
  return Card(
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      splashColor: Colors.red.withAlpha(30),
      onTap: () {
        debugPrint('Card $subsectionIndex tapped.'); /* if needed: clicking on card goes here */
      },
      child: ListTile(
        title: Text('Task $subsectionIndex'),
      ),
    ),
  );
}
