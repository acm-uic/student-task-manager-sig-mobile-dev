import 'package:flutter/material.dart';
import '../widgets/thought/tag_drop_down.dart';
import '../widgets/general/bottom_tab_navigator.dart';

class ThoughtsPage extends StatefulWidget {
  const ThoughtsPage({super.key});

  @override
  ThoughtsPageState createState() => ThoughtsPageState();
}

class ThoughtsPageState extends State<ThoughtsPage> {
  String tag = '';

  void addThought() {
    // TODO: create a popup screen for adding new thought
    //       The screen includes title, tags to choose, color picker,
    //        a text field to enter thought, cancel and add button
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text("UIC Task Manager"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Thought Tank',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search_rounded),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2.0), // Border when focused
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(30), // Rounded corners
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 2
                    ), // Border color and width
                  ),
                  child: TagDropdown(
                      tag: tag,
                      onChanged: (String? value) {
                        setState(() {
                          tag = value ?? '';
                        });
                      },
                    ),
                )),
                const SizedBox(height: 20),
                //Add CategoryBox for different thought categories
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.horizontal(),
                    border: Border.all(color: Colors.black, width:2),
                  ),
                  child: const Text(
                    'Work', //hardcoded text for the category
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                //Box for the thought input
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.horizontal(),
                    border: Border.all(color: Colors.black, width:2),
                  ),
                  child: const Text(
                   'My boss was really mean today...', //hardcoded text for thought box
                   style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Let\'s think big thoughts'),
                  ]
                )
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                onPressed: addThought,
                icon: const Icon(Icons.add),
                label: const Text('Add Thought'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomTabNavigator(),
    ));
  }
}

class Thought {
  String content;
  String tag;
  Color color;

  Thought({required this.content, required this.tag, required this.color});
}
