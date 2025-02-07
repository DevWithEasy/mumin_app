import 'dart:convert';
import 'package:mumin/app/services/shared_data.dart';
import 'package:http/http.dart' as http;

Future<void> getPrayersTime() async {
  try {
    bool? isAuto = await SharedData.getBool('isAuto');
    if (isAuto == true) {
      String? latitude = await SharedData.getString('latitude');
      String? longitude = await SharedData.getString('longitude');

      // Ensure latitude & longitude are not null
      if (latitude != null && longitude != null) {
        final String apiUrl =
            "https://api.aladhan.com/v1/timings/${DateTime.now().millisecondsSinceEpoch ~/ 1000}?latitude=$latitude&longitude=$longitude&method=2";

        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print('Auto Location Prayer Times:');
          print(data);
        } else {
          print('Failed to fetch auto location prayer times.');
        }
      } else {
        print('Latitude or Longitude is missing.');
      }
    } else {
      String? country = await SharedData.getString('country');
      String? city = await SharedData.getString('city');

      if (country != null && city != null) {
        final String apiUrl =
            "https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=2";

        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print('Selected City Prayer Times:');
          print(data);
        } else {
          print('Failed to fetch prayer times for selected city.');
        }
      } else {
        // Default to Dhaka, Bangladesh
        final String apiUrl =
            "https://api.aladhan.com/v1/timingsByCity?city=Dhaka&country=Bangladesh&method=2";

        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print('Default Prayer Times (Dhaka, Bangladesh):');
          print(data);
        } else {
          print('Failed to fetch default prayer times.');
        }
      }
    }
  } catch (e) {
    print('Error fetching prayer times: $e');
  }
}
