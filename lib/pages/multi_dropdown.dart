import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MultiDropdownApp extends StatefulWidget {
  const MultiDropdownApp({Key? key}) : super(key: key);

  @override
  State<MultiDropdownApp> createState() => _MultiDropdownState();

  static const _headerStyle = TextStyle(
    fontSize: 12,
    color: Colors.blue,
  );
}

class User {
  final String name;
  final int id;

  User({required this.name, required this.id});

  @override
  String toString() {
    return 'User(name: $name, id: $id)';
  }
}

class _MultiDropdownState extends State<MultiDropdownApp> {
  final MultiSelectController _controller = MultiSelectController();

  final List<ValueItem> _selectedOptions = [];

  final _future = Supabase.instance.client
      .from('rental')
      .select<List<Map<String, dynamic>>>();
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('multi_dropdown')),
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              List<Map<String, dynamic>> options = snapshot.data ?? [];
              List<String> optionNames =
                  options.map((option) => option['name'].toString()).toList();
              print(optionNames);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('With Supabase'),
                  MultiSelectDropDown(
                    onOptionSelected: (options) {
                      debugPrint(options.toString());
                    },
                    options: optionNames
                        .map((option) => ValueItem(
                              value: option,
                              label: option,
                            ))
                        .toList(),
                  ),
                  const Text('WRAP', style: MultiDropdownApp._headerStyle),
                  const SizedBox(
                    height: 4,
                  ),
                  MultiSelectDropDown(
                    showClearIcon: true,
                    controller: _controller,
                    onOptionSelected: (options) {
                      debugPrint(options.toString());
                    },
                    options: const <ValueItem>[
                      ValueItem(label: 'Option 1', value: 'value'),
                      ValueItem(label: 'Option 2', value: 'value'),
                      ValueItem(label: 'Option 3', value: 'value'),
                      ValueItem(label: 'Option 4', value: 'value'),
                      ValueItem(label: 'Option 5', value: 'value'),
                      ValueItem(label: 'Option 5', value: 'value'),
                    ],
                    maxItems: 4,
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(
                        wrapType: WrapType.wrap, backgroundColor: Colors.red),
                    dropdownHeight: 300,
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(
                      Icons.check_circle,
                      color: Colors.pink,
                    ),
                    selectedOptionTextColor: Colors.blue,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Wrap(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _controller.clearAllSelection();
                          setState(() {
                            _selectedOptions.clear();
                          });
                        },
                        child: const Text('CLEAR'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedOptions.clear();
                            _selectedOptions
                                .addAll(_controller.selectedOptions);
                          });
                        },
                        child: const Text('Get Selected Options'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_controller.isDropdownOpen) {
                            _controller.hideDropdown();
                          } else {
                            _controller.showDropdown();
                          }
                        },
                        child: const Text('SHOW/HIDE DROPDOWN'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Selected Options: $_selectedOptions',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text('SCROLL', style: MultiDropdownApp._headerStyle),
                  const SizedBox(
                    height: 4,
                  ),
                  MultiSelectDropDown(
                    onOptionSelected: (options) {
                      debugPrint(options.toString());
                    },
                    options: const <ValueItem>[
                      ValueItem(label: 'Option 1', value: '1'),
                      ValueItem(label: 'Option 2', value: '2'),
                      ValueItem(label: 'Option 3', value: '3'),
                      ValueItem(label: 'Option 4', value: '4'),
                      ValueItem(label: 'Option 5', value: '5'),
                      ValueItem(label: 'Option 6', value: '6'),
                    ],
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                    dropdownHeight: 400,
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text('FROM NETWORK',
                      style: MultiDropdownApp._headerStyle),
                  const SizedBox(
                    height: 4,
                  ),
                  MultiSelectDropDown.network(
                    onOptionSelected: (options) {},
                    networkConfig: NetworkConfig(
                      url: 'https://jsonplaceholder.typicode.com/users',
                      method: RequestMethod.get,
                      headers: {
                        'Content-Type': 'application/json',
                      },
                    ),
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    responseParser: (response) {
                      final list = (response as List<dynamic>).map((e) {
                        final item = e as Map<String, dynamic>;
                        return ValueItem(
                          label: item['name'],
                          value: item['id'].toString(),
                        );
                      }).toList();

                      return Future.value(list);
                    },
                    responseErrorBuilder: ((context, body) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Error fetching the data'),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
