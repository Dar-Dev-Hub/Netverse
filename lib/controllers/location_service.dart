// location_service.dart

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocationService {
  static Future<String> getUserCountry() async {
    var coutryCode = ''.obs;
    final box = GetStorage();
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      print(
          'Location permission: $permission'); // Print location permission status
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Use a geocoding service to determine the country from the coordinates.
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        String? country = placemarks.isNotEmpty
            ? placemarks[0].isoCountryCode
            : 'Country not found';
        coutryCode.value = country!;
        box.write('CounrtyCode', country);
        print('User country: $country'); // Print user's country
        return country ?? 'Country not found';
      } else {
        return 'Location permission denied';
      }
    } catch (e) {
      print('Error: $e'); // Print any errors that occur
      return 'Error: $e';
    }
  }
}
