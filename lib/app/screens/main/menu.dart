import 'package:flutter/material.dart';
import 'package:mumin/app/services/shared_data.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try{
                  bool? isAuto = await SharedData.getBool('isAuto');
                print(isAuto);
                String? city = await SharedData.getString('city');
                String? country = await SharedData.getString('country');
                print(city);
                print(country);
                }catch(e){
                  print(e);
                }
              },
              child: Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
