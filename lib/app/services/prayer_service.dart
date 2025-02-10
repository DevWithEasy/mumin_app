import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mumin/app/models/PrayerTimes.dart';
import 'package:mumin/app/services/shared_data.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class PrayerService {
  // Request location permission
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

  // Get current location and return prayer times
  static Future<PrayerTimes> getCurrentLocation() async {
    bool permissionGranted = await requestLocationPermission();
    if (permissionGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Save location data
        SharedData.setString('latitude', position.latitude.toString());
        SharedData.setString('longitude', position.longitude.toString());
        SharedData.setString('city', 'Dhaka'); // Default to Dhaka
        SharedData.setString('country', 'Bangladesh');

        return await getPrayersTime(); // Ensure return
      } catch (e) {
        print("Error getting location: $e");
        throw Exception("Failed to get current location.");
      }
    } else {
      throw Exception("Location permission denied.");
    }
  }

  // Get address from latitude & longitude
  static Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      SharedData.setString('auto_city', place.subAdministrativeArea ?? "");
      SharedData.setString('city', 'Dhaka'); // Default to Dhaka
      SharedData.setString('country', place.country ?? "");

      print("Country: ${place.country}");
    } catch (e) {
      print("Error getting address: $e");
    }
  }

  // Get prayer times (auto or manual)
  static Future<PrayerTimes> getPrayersTime() async {
    try {
      bool? isAuto = await SharedData.getBool('isAuto');
      PrayerTimes? prayerTimes;

      if (isAuto == true) {
        String? latitude = await SharedData.getString('latitude');
        String? longitude = await SharedData.getString('longitude');

        if (latitude != null && longitude != null) {
          prayerTimes = await getTimeByPosition(latitude, longitude);
        } else {
          prayerTimes = await getTimeByCity('Dhaka', 'Bangladesh');
        }
      } else {
        String? country = await SharedData.getString('country');
        String? city = await SharedData.getString('city');

        if (country != null && city != null) {
          prayerTimes = await getTimeByCity(city, country);
        } else {
          prayerTimes = await getTimeByCity('Dhaka', 'Bangladesh');
        }
      }
      return prayerTimes;
    } catch (e) {
      print('Error fetching prayer times: $e');
      throw Exception("Error fetching prayer times.");
    }
  }

  // Fetch prayer times by location (latitude & longitude)
  static Future<PrayerTimes> getTimeByPosition(
      String latitude, String longitude) async {
    final String apiUrl =
        "https://api.aladhan.com/v1/timings/${DateTime.now().millisecondsSinceEpoch ~/ 1000}?latitude=$latitude&longitude=$longitude&method=2";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        SharedData.setString('prayer_time', jsonEncode(data['data']));
        return PrayerTimes.fromJson(data['data']);
      } else {
        throw Exception("Failed to fetch prayer times by position.");
      }
    } catch (e) {
      print("Error fetching prayer times by position: $e");
      throw Exception("Error fetching prayer times by position.");
    }
  }

  // Fetch prayer times by city & country
  static Future<PrayerTimes> getTimeByCity(String city, String country) async {
    final String apiUrl =
        "https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=2";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        SharedData.setString('prayer_time', jsonEncode(data['data']));
        return PrayerTimes.fromJson(data['data']);
      } else {
        throw Exception("Failed to fetch prayer times for $city, $country.");
      }
    } catch (e) {
      print("Error fetching prayer times by city: $e");
      throw Exception("Error fetching prayer times by city.");
    }
  }
}
