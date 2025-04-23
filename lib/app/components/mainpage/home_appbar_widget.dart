import 'package:flutter/material.dart';
import 'package:mumin/app/providers/app_provider.dart';
import 'package:mumin/app/screens/location_calculation/location_area.dart';
import 'package:provider/provider.dart';

class HomeAppBarActions extends StatefulWidget {

  const HomeAppBarActions({ super.key});

  @override
  State<HomeAppBarActions> createState() => _HomeAppBarActionsState();
}

class _HomeAppBarActionsState extends State<HomeAppBarActions> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationSettings()),
        );
      },
      child: appProvider.isAuto ?
      LocationName(Icons.gps_fixed,'GPS','Automatic')
      : LocationName(Icons.place,appProvider.city,appProvider.country)
    );
  }

  Row LocationName(IconData icon,String city,String country) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blueGrey),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              city,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            Text(
              country,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
