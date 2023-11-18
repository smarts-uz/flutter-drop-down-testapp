import 'package:drop_down_testapp/rashail_multi_dropdown.dart';
import 'package:flutter/material.dart';

import 'ninja_dropdown.dart';

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
      home: Example1(title: 'Ninja Dropdown'),
    );
  }
}
