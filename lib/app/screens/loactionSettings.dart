import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mumin/app/models/Country.dart';
import 'package:mumin/app/providers/app_provider.dart';
import 'package:mumin/app/services/shared_data.dart';
import 'package:provider/provider.dart';

class LocationSettings extends StatefulWidget {
  const LocationSettings({super.key});

  @override
  State<LocationSettings> createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {
  bool _isAuto = false;
  List<Country> _countries = [];
  String? selectedCountry;
  List<String> selectedCities = [];
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/countries.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      final countries = jsonData.map((json) => Country.fromJson(json)).toList();

      final savedCountry = await SharedData.getString('country');
      final savedCity = await SharedData.getString('city');
      final isAuto =
          await SharedData.getBool('isAuto'); // Get saved isAuto value

      setState(() {
        _countries = countries;
        _isAuto = isAuto ?? false; // Use stored value or default to false

        if (savedCountry != null) {
          selectedCountry = savedCountry;
          selectedCities = _countries
              .firstWhere((c) => c.country == savedCountry,
                  orElse: () =>
                      Country(country: '', cities: [], iso2: '', iso3: ''))
              .cities
              .toSet()
              .toList(); // Ensure unique values
        }

        if (savedCity != null && selectedCities.contains(savedCity)) {
          selectedCity = savedCity;
        }
      });
    } catch (e) {
      print('Error loading or parsing JSON: $e');
    }
  }

  Future<void> fetchPrayersTime() async {
    if (selectedCity == null || selectedCountry == null) {
      showError('Please select both a city and a country.');
      return;
    }

    await SharedData.setString('country', selectedCountry!);
    await SharedData.setString('city', selectedCity!);

    Provider.of<AppProvider>(context,listen: false).setCity(selectedCity!);
    Provider.of<AppProvider>(context,listen: false).setCountry(selectedCountry!);

    var url =
        'https://api.aladhan.com/v1/timingsByCity?city=$selectedCity&country=$selectedCountry';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
      } else {
        showError(
            'Failed to load prayer times. Status code: ${response.statusCode}');
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
        elevation: 1,
        backgroundColor: Colors.white,
        shadowColor: Colors.blueGrey,
        actions: [
          ElevatedButton(
            onPressed: fetchPrayersTime,
            child: const Text('সেইভ করুন'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: _countries.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const Text(
                        'সালাত ও ইফতার-সাহরির সঠিক সময় হিসাব করার জন্য আপনার লোকেশন সেট করুন'),
                    const SizedBox(height: 16),

                    /// **Dropdown for Country Selection**
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: selectedCountry,
                      decoration: InputDecoration(
                        labelText: "আপনার দেশ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      hint: const Text('আপনার দেশ'),
                      items: _countries
                          .map((country) => country.country)
                          .toSet()
                          .map((countryName) {
                        return DropdownMenuItem<String>(
                          value: countryName,
                          child: Text(countryName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                          selectedCities = _countries
                              .firstWhere((c) => c.country == value,
                                  orElse: () => Country(
                                      country: '',
                                      cities: [],
                                      iso2: '',
                                      iso3: ''))
                              .cities
                              .toSet()
                              .toList(); // Ensure unique values

                          // Reset selectedCity if it's not in the new city list
                          if (!selectedCities.contains(selectedCity)) {
                            selectedCity = null;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    /// **Dropdown for City Selection**
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: selectedCity,
                      decoration: InputDecoration(
                        labelText: "আপনার জেলা",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      hint: const Text('আপনার জেলা'),
                      items: selectedCities.map((city) {
                        return DropdownMenuItem<String>(
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
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: Text('অটোমেটিক লোকেশন টাইম'),
                      value: _isAuto,
                      onChanged: (value) async {
                        await SharedData.setBool('isAuto', value!);
                        setState(() {
                          _isAuto = value;
                        });
                      },
                      tristate: false,
                      controlAffinity: ListTileControlAffinity.leading,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
