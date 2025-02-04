import 'package:flutter/material.dart';
import 'package:mumin/app/screens/loactionSettings.dart';
import 'package:mumin/app/services/shared_data.dart';

class HomeAppBarActions extends StatefulWidget {
  const HomeAppBarActions({super.key});

  @override
  State<HomeAppBarActions> createState() => _HomeAppBarActionsState();
}

class _HomeAppBarActionsState extends State<HomeAppBarActions> {
  bool _saveLocation = false;
  String _country = '';
  String _city = '';

  Future<void> checking() async {
    try {
      String? country = await SharedData.getString('country');
      String? city = await SharedData.getString('city');
      if (country != null && city != null) {
        setState(() {
          _country = country;
          _city = city;
          _saveLocation = true;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    checking();
  }

  @override
  Widget build(BuildContext context) {
    print(_saveLocation);
    print(_country);
    print(_city);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationSettings()),
        );
      },
      child: _saveLocation ?
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.place, color: Colors.blueGrey),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Dhaka',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              Text(
                'Bangladesh',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(width: 16)
        ],
      ) :
      Icon(Icons.location_searching, size: 24, color: Colors.grey),
    );
  }
}
