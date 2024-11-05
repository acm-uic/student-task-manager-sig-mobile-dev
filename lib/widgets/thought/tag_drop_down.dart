import 'package:flutter/material.dart';

class TagDropdown extends StatelessWidget {
  final String tag;
  final ValueChanged<String?> onChanged;

  // Constructor for CategoryDropdown
  const TagDropdown({
    super.key,
    required this.tag,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: tag.isEmpty ? 'All' : tag,
      onChanged: onChanged,
      items: <String>['All', 'College', 'Work', 'Personal']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      icon: const Icon(
        Icons.filter_list,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      selectedItemBuilder: (BuildContext context) {
        return <String>['All', 'College', 'Work', 'Personal']
            .map((String value) {
          return Row(
            children: [
              const SizedBox(width: 8), // Space between icon and text
              Text(value),
              const SizedBox(width: 10),
            ],
          );
        }).toList();
      },
    );
  }
}
