import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:drop_down_testapp/main.dart';
import 'package:flutter/material.dart';

class AnimatedCustomDropdownApp extends StatefulWidget {
  const AnimatedCustomDropdownApp({super.key});

  @override
  State<AnimatedCustomDropdownApp> createState() =>
      _AnimatedCustomDropdownAppState();
}

class _AnimatedCustomDropdownAppState extends State<AnimatedCustomDropdownApp> {
  // This should be a call to the api or service or similar
  Future<List<Pair>> _getFakeRequestData(String query) async {
    return await Future.delayed(const Duration(seconds: 1), () {
      return _pairList.where((e) {
        return e.text.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<List<SupabaseType>> _getSupabaseData(String query) async {
    final data = await supabase
        .from('customer')
        .select()
        .ilike('name', '%$query%') as List;
    return data.map((e) {
      return SupabaseType(value: e, visibleText: e['name']);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('animated_custom_dropdown')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Search with supabase'),
              const SizedBox(height: 16),
              CustomDropdown<SupabaseType>.searchRequest(
                futureRequest: _getSupabaseData,
                hintText: 'Search customers',
                items: const [],
                onChanged: (value) {
                  debugPrint('changing value to: $value');
                },
              ),
              const SizedBox(height: 16),
              const Text('Default'),
              const SizedBox(height: 16),
              CustomDropdown<String>(
                hintText: 'Select job role',
                items: _list,
                initialItem: _list[0],
                onChanged: (value) {
                  debugPrint('changing value to: $value');
                },
              ),
              const SizedBox(height: 16),
              const Text('Search'),
              const SizedBox(height: 16),
              CustomDropdown<Job>.search(
                hintText: 'Select job role',
                items: _jobList,
                excludeSelected: false,
                onChanged: (value) {
                  debugPrint('changing value to: $value');
                },
              ),
              const SizedBox(height: 16),
              const Text('Search Request'),
              const SizedBox(height: 16),
              CustomDropdown<Pair>.searchRequest(
                futureRequest: _getFakeRequestData,
                hintText: 'Search pair',
                items: _pairList,
                onChanged: (value) {
                  debugPrint('changing value to: $value');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> _list = [
  'Developer',
  'Designer',
  'Consultant',
  'Student',
];

const List<Job> _jobList = [
  Job('Developer', Icons.developer_mode),
  Job('Designer', Icons.design_services),
  Job('Consultant', Icons.account_balance),
  Job('Student', Icons.school),
];

class Job with CustomDropdownListFilter {
  final String name;
  final IconData icon;

  const Job(this.name, this.icon);

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}

class Pair {
  final String text;
  final IconData icon;

  const Pair(this.text, this.icon);

  @override
  String toString() {
    return text;
  }
}

const List<Pair> _pairList = [
  Pair('Developer', Icons.developer_board),
  Pair('Designer', Icons.deblur_sharp),
  Pair('Consultant', Icons.money_off),
  Pair('Student', Icons.edit),
];

class SupabaseType {
  final Map<String, dynamic> value;
  final String visibleText;

  const SupabaseType({required this.value, required this.visibleText});

  @override
  String toString() {
    return visibleText;
  }
}
