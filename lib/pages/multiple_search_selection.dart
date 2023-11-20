import 'package:flutter/material.dart';
import 'package:multiple_search_selection/helpers/create_options.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MultipleSearchSelectionPage extends StatefulWidget {
  const MultipleSearchSelectionPage({Key? key}) : super(key: key);

  @override
  State<MultipleSearchSelectionPage> createState() =>
      _MultipleSearchSelectionPageState();
}

class _MultipleSearchSelectionPageState
    extends State<MultipleSearchSelectionPage> {
  final _future = Supabase.instance.client
      .from('rental')
      .select<List<Map<String, dynamic>>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('multiple_search_selection'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
            children: [
              MultipleSearchSelection<Country>.creatable(
                title: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Countries',
                    style: kStyleDefault.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // maxSelectedItems: 5,
                showItemsButton: const Text('ShowItemsButton'),
                showClearAllButton: true,
                onItemAdded: (c) {},
                showClearSearchFieldButton: true,
                createOptions: CreateOptions(
                  createItem: (text) {
                    return Country(name: text, iso: text);
                  },
                  onItemCreated: (c) => print('Country ${c.name} created'),
                  createItemBuilder: (text) => Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Create "$text"'),
                    ),
                  ),
                  pickCreatedItem: true,
                ),
                items: optionNames
                    .map((option) => Country(
                          name: option,
                          iso: option,
                        ))
                    .toList(),
                // List<Country>
                fieldToCheck: (c) {
                  return c.name;
                },
                itemBuilder: (country, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 12,
                        ),
                        child: Text(country.name),
                      ),
                    ),
                  );
                },
                pickedItemBuilder: (country) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(country.name),
                    ),
                  );
                },
                sortShowedItems: true,
                sortPickedItems: true,
                selectAllButton: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select All',
                        style: kStyleDefault,
                      ),
                    ),
                  ),
                ),
                clearAllButton: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Clear All',
                        style: kStyleDefault,
                      ),
                    ),
                  ),
                ),
                caseSensitiveSearch: false,
                fuzzySearch: FuzzySearch.none,
                itemsVisibility: ShowedItemsVisibility.alwaysOn,
                showSelectAllButton: true,
                maximumShowItemsHeight: 200,
              ),
            ],
          );
        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

TextStyle kStyleDefault = const TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class Country {
  final String name;
  final String iso;

  const Country({
    required this.name,
    required this.iso,
  });
}
