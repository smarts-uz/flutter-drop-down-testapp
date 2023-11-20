import 'package:flutter/material.dart';
import 'package:ninja_dropdown/ninja_dropdown.dart';

class NinjaDropdownApp extends StatefulWidget {
  const NinjaDropdownApp({super.key});

  @override
  State<NinjaDropdownApp> createState() => _NinjaDropdownAppState();
}

class _NinjaDropdownAppState extends State<NinjaDropdownApp> {
  @override
  Widget build(BuildContext context) {
    List fruitList = [
      "Banana",
      "Apple",
      "kiwi",
      "Orange",
      "Grapes",
      "Custard apple"
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('ninja_dropdown')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: NinjaDropdown(
              hintText: "hell0",
              itemList: fruitList,
              onTap: (int val) {
                print(val);
              },
              onOpenTrailingIcon: Icons.grade,
              onCloseTrailingIcon: Icons.cloud,
              // menuBorderRadius: const BorderRadius.only(
              //     topLeft: Radius.circular(50),
              //     bottomRight: Radius.circular(50)),
              textBoxDecoration: const BoxDecoration(
                  color: Colors.amber,
                  gradient: RadialGradient(
                      colors: [Colors.white, Colors.blue], radius: 5),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              menuColor: Colors.blue[100]!,
              selectedItemColor: Colors.blue[300]!,
            ),
          ),
        ],
      ),
    );
  }
}
