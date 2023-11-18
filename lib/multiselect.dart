import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class MultiSelectPage extends StatefulWidget {
  const MultiSelectPage({super.key, required this.title});

  final String title;

  @override
  State<MultiSelectPage> createState() => _MultiSelectPageState();
}

class _MultiSelectPageState extends State<MultiSelectPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: DropDownMultiSelect(
          selected_values_style: const TextStyle(color: Colors.black),
          onChanged: (List<String> x) {
            setState(() {
              selected = x;
            });
          },
          readOnly: true,
          icon: const Icon(Icons.access_alarm_outlined),
          options: const ['a', 'b', 'c', 'd', 're', 'name', 'what'],
          selectedValues: selected,
          whenEmpty: 'Select Something',
        ),
      ),
    ));
  }
}
