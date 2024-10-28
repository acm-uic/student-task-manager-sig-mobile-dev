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
  List<Thought> thoughts = [];
  List<Thought> get filteredThoughts {
    return tag.isEmpty
        ? thoughts
        : thoughts.where((thought) => thought.tag == tag).toList()
      ..sort((a, b) => a.content.compareTo(b.content));
  }

  void thoughtCategory() {
    // Add functionality here, such as navigating or filtering thoughts
    print("Category filter tapped");
  }

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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                  const SizedBox(height: 100),
                  const Align(
                    alignment: Alignment.center,
                    child: Text("Let's think big thoughts."),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                onPressed: addThought,
                icon: const Icon(Icons.add),
                label: const Text('Add Thought'),
              ),
            )
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
