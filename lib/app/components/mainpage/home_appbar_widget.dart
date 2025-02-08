import 'package:flutter/material.dart';
import 'package:mumin/app/screens/loactionSettings.dart';
import 'package:mumin/app/services/shared_data.dart';

class HomeAppBarActions extends StatefulWidget {
  const HomeAppBarActions({super.key});

  @override
  State<HomeAppBarActions> createState() => _HomeAppBarActionsState();
}

class _HomeAppBarActionsState extends State<HomeAppBarActions> {
  String _country = '';
  String _city = '';

  Future<void> _checking() async {
    try {
      // Check if location is saved automatically
      bool? _saveLocation = await SharedData.getBool('isAuto');

      // Fetch city and country based on the value of _saveLocation
      String? city;
      String? country;

      if (_saveLocation == true) {
        city = await SharedData.getString('auto_city');
        country = await SharedData.getString('country');
      } else {
        city = await SharedData.getString('city');
        country = await SharedData.getString('country');
      }

      // Debugging: Print fetched values
      print("Fetched City: $city");
      print("Fetched Country: $country");

      // Update state with fallback values if necessary
      setState(() {
        _city = city ?? 'Unknown City'; // Provide a fallback value if null
        _country = country ?? 'Unknown Country'; // Provide a fallback value if null
      });
    } catch (e) {
      print("Error in _checking: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _checking(); // Fetch data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationSettings()),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.place, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _city, // Use the actual variable here
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              Text(
                _country, // Use the actual variable here
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}