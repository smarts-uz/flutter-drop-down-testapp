import 'package:flutter/material.dart';
import 'multiple_search_selection.dart';
import 'multiselect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MultipleSearchSelectionPage(
        title: 'MultipleSearchSelection',
      ),
    );
  }
}
