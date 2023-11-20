import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'drop_down_list.dart';
import 'multi_dropdown.dart';
import 'multiple_search_selection.dart';
import 'multiselect.dart';

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
      title: 'Flutter Demo',
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
        title: const Text('DropDown'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DropDownListExample(),
              ));
            },
            child: const Text('DropDownList'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MultipleSearchSelectionPage(
                  title: 'MultipleSearchSelectionPage',
                ),
              ));
            },
            child: const Text('MultipleSearchSelectionPage'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MultiSelectPage(
                  title: 'MultiSelectPage',
                ),
              ));
            },
            child: const Text('MultiSelectPage'),
          ),
        ],
      ),
    );
  }
}
