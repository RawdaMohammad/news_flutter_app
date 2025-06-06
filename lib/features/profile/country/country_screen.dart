import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import '../../../core/constants/storage_key.dart';
import '../../../core/services/prefrences_manager.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  Country? selectedCountry;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    loadSavedCountry();
  }

  Future<void> loadSavedCountry() async {
    final savedCountry = await PreferencesManager().getString(StorageKey.country);

    if (savedCountry != null) {
      // Find the matching country from the list
      final countries = CountryService().getAll();
      final matched = countries.firstWhere(
            (country) => country.displayName == savedCountry,
        orElse: () => countries.first,
      );

      setState(() {
        selectedCountry = matched;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final countries = CountryService().getAll();

    // Filter by search
    final filteredCountries = countries.where((country) {
      return country.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Select your country')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: const Icon(Icons.search, color: Color(0xFFA0A0A0),),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  final isSelected = country == selectedCountry;

                  return ListTile(
                    leading: Text(country.flagEmoji, style: Theme.of(context).textTheme.displayLarge,),
                    title: Text(country.name),
                    trailing: Radio<Country>(
                      value: country,
                      groupValue: selectedCountry,
                      onChanged: (Country? value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        selectedCountry = country;
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:  10.0),
              child: ElevatedButton(
                onPressed: selectedCountry != null
                    ? () async{
                  await PreferencesManager().setString(StorageKey.country, selectedCountry!.displayName);
                  Navigator.pop(context, selectedCountry);
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
