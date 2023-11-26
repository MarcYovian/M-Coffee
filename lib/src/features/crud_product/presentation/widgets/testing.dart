import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Example',
      home: DropdownExample(),
    );
  }
}

class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String category = "";
  List<String> categories = [
    "Coffee",
    "Noodle",
    "Rice",
    "Snack",
    "Spaghetti",
    "Tea",
    "Toast"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton(
              value: category,
              items: buildDropdownMenuItems(),
              onChanged: (value) {
                setState(() {
                  category = value.toString();
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Selected Category: $category'),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems() {
    return categories.map((String value) {
      return DropdownMenuItem(
        child: Text(value),
        value: value,
      );
    }).toList();
  }
}
