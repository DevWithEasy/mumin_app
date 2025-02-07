import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mumin/app/services/shared_data.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class PrayerService {
  static Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status == PermissionStatus.granted) return true;

    if (status == PermissionStatus.permanentlyDenied) {
      return openAppSettings();
    }

    PermissionStatus permission = await Permission.location.request();
    if (permission == PermissionStatus.granted) {
      SharedData.setBool('isAuto', true);
      return true;
    } else {
      return false;
    }
  }

  static Future<void> getCurrentLocation() async {
    bool permissionGranted = await requestLocationPermission();
    if (permissionGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        getAddressFromLatLng(position);
        SharedData.setString('latitude', position.latitude.toString());
        SharedData.setString('longitude', position.longitude.toString());
        getPrayersTime();
      } catch (e) {
        print(e);
      }
    } else {
      print("Location permission denied");
    }
  }

  static Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      SharedData.setString('city', place.subAdministrativeArea.toString());
      SharedData.setString('country', place.country.toString());
    } catch (e) {
      print(e);
    }
  }

  static Future<void> getPrayersTime() async {
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
}
