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
      body: SingleChildScrollView(
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
              children: [
                Text('with Supabase'),
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
                Text('Without Supabase'),

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
                  items: countries,
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
                ), //
              ],
            );
          },
        ),
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

List<String> countryNames = [
  "United States",
  "Canada",
  "Afghanistan",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antarctica",
  "Antigua and/or Barbuda",
  "Argentina",
  "Armenia",
  "Aruba",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bermuda",
  "Bhutan",
  "Bolivia",
  "Bosnia and Herzegovina",
  "Botswana",
  "Bouvet Island",
  "Brazil",
  "British Indian Ocean Territory",
  "Brunei Darussalam",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cambodia",
  "Cameroon",
  "Cape Verde",
  "Cayman Islands",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Christmas Island",
  "Cocos (Keeling) Islands",
  "Colombia",
  "Comoros",
  "Congo",
  "Cook Islands",
  "Costa Rica",
  "Croatia (Hrvatska)",
  "Cuba",
  "Cyprus",
  "Czech Republic",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "East Timor",
  "Ecudaor",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Ethiopia",
  "Falkland Islands (Malvinas)",
  "Faroe Islands",
  "Fiji",
  "Finland",
  "France",
  "France, Metropolitan",
  "French Guiana",
  "French Polynesia",
  "French Southern Territories",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Gibraltar",
  "Greece",
  "Greenland",
  "Grenada",
  "Guadeloupe",
  "Guam",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Heard and Mc Donald Islands",
  "Honduras",
  "Hong Kong",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran (Islamic Republic of)",
  "Iraq",
  "Ireland",
  "Israel",
  "Italy",
  "Ivory Coast",
  "Jamaica",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Korea, Democratic People's Republic of",
  "Korea, Republic of",
  "Kosovo",
  "Kuwait",
  "Kyrgyzstan",
  "Lao People's Democratic Republic",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libyan Arab Jamahiriya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macau",
  "Macedonia",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Martinique",
  "Mauritania",
  "Mauritius",
  "Mayotte",
  "Mexico",
  "Micronesia, Federated States of",
  "Moldova, Republic of",
  "Monaco",
  "Mongolia",
  "Montserrat",
  "Morocco",
  "Mozambique",
  "Myanmar",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "Netherlands Antilles",
  "New Caledonia",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "Niue",
  "Norfork Island",
  "Northern Mariana Islands",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Pitcairn",
  "Poland",
  "Portugal",
  "Puerto Rico",
  "Qatar",
  "Reunion",
  "Romania",
  "Russian Federation",
  "Rwanda",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Vincent and the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Senegal",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Georgia South Sandwich Islands",
  "South Sudan",
  "Spain",
  "Sri Lanka",
  "St. Helena",
  "St. Pierre and Miquelon",
  "Sudan",
  "Suriname",
  "Svalbarn and Jan Mayen Islands",
  "Swaziland",
  "Sweden",
  "Switzerland",
  "Syrian Arab Republic",
  "Taiwan",
  "Tajikistan",
  "Tanzania, United Republic of",
  "Thailand",
  "Togo",
  "Tokelau",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Turks and Caicos Islands",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States minor outlying islands",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Vatican City State",
  "Venezuela",
  "Vietnam",
  "Virigan Islands (British)",
  "Virgin Islands (U.S.)",
  "Wallis and Futuna Islands",
  "Western Sahara",
  "Yemen",
  "Yugoslavia",
  "Zaire",
  "Zambia",
  "Zimbabwe"
];

List<Country> countries = List<Country>.generate(
  countryNames.length,
  (index) => Country(
    name: countryNames[index],
    iso: countryNames[index].substring(0, 2),
  ),
);
