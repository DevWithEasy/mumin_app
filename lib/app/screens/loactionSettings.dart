import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationSettings extends StatefulWidget {
  const LocationSettings({super.key});

  @override
  State<LocationSettings> createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {
  List countries = [];
  String? selectedCountry;
  List<String>? selectedCities;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    const url = 'https://countriesnow.space/api/v0.1/countries';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final List<dynamic> countryData = data['data'];

        setState(() {
          countries = countryData;
        });
      } else {
        showError(
            'Failed to load countries. Status code: ${response.statusCode}');
      }
    } catch (error) {
      showError('An error occurred: $error');
    }
  }

  Future<void> fetchPrayersTime() async {
    if (selectedCity == null ||
        selectedCity!.isEmpty ||
        selectedCountry == null ||
        selectedCountry!.isEmpty) {
      showError('Please select both a city and a country.');
      return; // Exit the function early
    }
    var url =
        'https://api.aladhan.com/v1/timingsByCity?city=$selectedCity&country=$selectedCountry';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        // final List<dynamic> countryData = data['data'];

        // setState(() {
        //   countries = countryData;
        // });
      } else {
        showError(
            'Failed to load countries. Status code: ${response.statusCode}');
      }
    } catch (error) {
      showError('An error occurred: $error');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('লোকেশন সেটিংস', style: TextStyle(fontSize: 16)),
        elevation: 0.1,
        backgroundColor: Colors.white,
        shadowColor: Colors.blueGrey,
      ),
      body: countries.isEmpty
          ? Center(child: const CircularProgressIndicator())
          : Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
                Expanded(
                  child: Column(children: [
                    DropdownButton(
                      isExpanded: true,
                      value: selectedCountry,
                      hint: const Text('আপনার দেশ'),
                      items: countries
                          .map((country) {
                            return DropdownMenuItem(
                              value:
                                  country['country'], // Use a unique identifier
                              child: Text(country['country']),
                            );
                          })
                          .toSet()
                          .toList(), // Convert to Set to avoid duplicates
                      onChanged: (value) {
                        if (value != null && value is String) {
                          // Ensure value is a String
                          setState(() {
                            selectedCountry = value;
                            selectedCities = List<String>.from(
                                countries.firstWhere(
                                    (c) => c['country'] == value)['cities']);
                          });
                        }
                      },
                    ),
                    DropdownButton(
                      isExpanded: true,
                      value: selectedCity,
                      hint: const Text('আপনার জেলা'),
                      items: selectedCities?.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: fetchPrayersTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    child: Text('Save'),
                  ),
                )
              ]),
          ),
    );
  }
}
