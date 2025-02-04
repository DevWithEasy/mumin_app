import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mumin/app/models/Country.dart';
import 'package:mumin/app/services/shared_data.dart';

class LocationSettings extends StatefulWidget {
  const LocationSettings({super.key});

  @override
  State<LocationSettings> createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {
  List<Country> _countries = [];
  String? selectedCountry;
  List<String>? selectedCities;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/countries.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      final countries = jsonData.map((json) => Country.fromJson(json)).toList();

      final savedCountry = await SharedData.getString('country');
      final savedCity = await SharedData.getString('city');

      if (savedCountry != null) {
        setState(() {
          _countries = countries;
          selectedCountry = savedCountry;
          selectedCities = List<String>.from(
              countries.firstWhere((c) => c.country == savedCountry).cities);
        });
      } else {
        setState(() {
          _countries = countries;
        });
      }
      if (savedCity != null) {
        setState(() {
          selectedCity = savedCity;
        });
      }
    } catch (e) {
      // Handle any errors during loading or parsing
      print('Error loading or parsing JSON: $e');
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
    await SharedData.setString('country', selectedCountry!);
    await SharedData.setString('city', selectedCity!);
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
        actions: [
          ElevatedButton(
            onPressed: fetchPrayersTime,
            child: Text('সেইভ করুন'),
            style: ElevatedButton.styleFrom(
            )
          ),
          SizedBox(width: 10)
        ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: _countries.isEmpty
                ? Center(child: const CircularProgressIndicator())
                : Column(children: [
                    Text(
                        'সালাত ও ইফতার-সাহরির সঠিক সময় হিসাব করার জন্য আপনার লোকেশন সেট করুন'),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                      isExpanded: true,
                      value: selectedCountry,
                      decoration: InputDecoration(
                        labelText: "আপনার দেশ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      hint: const Text('আপনার দেশ'),
                      items: _countries
                          .map((country) {
                            return DropdownMenuItem(
                              value: country.country,
                              child: Text(country.country),
                            );
                          })
                          .toSet()
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCountry = value;

                            selectedCities = List<String>.from(_countries
                                .firstWhere((c) => c.country == value)
                                .cities);

                            if (selectedCity == null ||
                                !selectedCities!.contains(selectedCity)) {
                              selectedCity = null;
                            }
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                      isExpanded: true,
                      value: selectedCity,
                      decoration: InputDecoration(
                        labelText: "আপনার জেলা",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.blue, width: 2), 
                        ),
                      ),
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
        ));
  }
}
