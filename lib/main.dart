import 'package:drop_down_testapp/pages/animated_custom_dropdown.dart';
import 'package:drop_down_testapp/pages/drop_down_list.dart';
import 'package:drop_down_testapp/pages/multi_dropdown.dart';
import 'package:drop_down_testapp/pages/multiple_search_selection.dart';
import 'package:drop_down_testapp/pages/multiselect.dart';
import 'package:drop_down_testapp/pages/multiselect_nested.dart';
import 'package:drop_down_testapp/pages/ninja_dropdown.dart';
import 'package:drop_down_testapp/pages/rashail_multi_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['ANON_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Dropdown Demo',
      home: MyRealPage(),
    );
  }
}

class MyRealPage extends StatelessWidget {
  const MyRealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DropDown Test App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DropDownListExample(),
                ));
              },
              child: const Text('drop_down_list'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MultipleSearchSelectionPage(),
                ));
              },
              child: const Text('multiple_search_selection'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MultiSelectPage(),
                ));
              },
              child: const Text('multiselect'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MultiDropdownApp(),
                ));
              },
              child: const Text('multi_dropdown'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MultiSelectNestedPage(),
                ));
              },
              child: const Text('multiselect_nested'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NinjaDropdownApp(),
                ));
              },
              child: const Text('ninja_dropdown'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RashailMulitDropDown(),
                ));
              },
              child: const Text('rashail_multi_dropdown'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AnimatedCustomDropdownApp(),
                ));
              },
              child: const Text('animated_custom_dropdown'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
