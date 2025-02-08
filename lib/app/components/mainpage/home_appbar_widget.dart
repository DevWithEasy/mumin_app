import 'package:flutter/material.dart';
import 'package:mumin/app/providers/app_provider.dart';
import 'package:mumin/app/screens/loactionSettings.dart';
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
    print(appProvider.city);
    print(appProvider.country);
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
                appProvider.city,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              Text(
                appProvider.country,
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
