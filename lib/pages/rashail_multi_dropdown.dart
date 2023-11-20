import 'package:flutter/material.dart';
import 'package:rashail_multi_dropdown/rashail_multi_dropdown.dart';

class RashailMulitDropDown extends StatelessWidget {
  const RashailMulitDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('rashail_multi_dropdown')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('WRAP', style: _headerStyle),
              const SizedBox(
                height: 4,
              ),
              RashailMultiDropdown(
                borderRadius: 4,
                inputDecoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.purple,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
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
                chipConfig: const ChipConfig(
                  wrapType: WrapType.wrap,
                  backgroundColor: Colors.purple,
                ),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(
                  Icons.checklist,
                  color: Colors.pink,
                ),
                selectedOptionTextColor: Colors.purple,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('SCROLL', style: _headerStyle),
              const SizedBox(
                height: 4,
              ),
              RashailMultiDropdown(
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
              const Text('FROM NETWORK', style: _headerStyle),
              const SizedBox(
                height: 4,
              ),
              RashailMultiDropdown.network(
                dropdownHeight: 200,
                onOptionSelected: (options) {
                  debugPrint(options.toString());
                },
                networkConfig: NetworkConfig(
                  url: 'https://jsonplaceholder.typicode.com/users',
                  method: RequestMethod.get,
                  headers: {
                    'Content-Type': 'application/json',
                  },
                ),
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                responseParser: (response) {
                  debugPrint('Response: $response');

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
                    child: Text('Oops! Error fetching the data'),
                  );
                }),
              ),
              RashailMultiDropdown(
                selectionType: SelectionType.single,
                suffixIcon: Icons.check_box,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  );
}
