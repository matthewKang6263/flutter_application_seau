import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static bool _idDenied(LocationPermission permission) {
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  static Future<Position?> getPositon() async {
    final permission = await Geolocator.checkPermission();
    if (_idDenied(permission)) {
      final request = await Geolocator.requestPermission();
      if (_idDenied(request)) {
        return null;
      }
    }

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    return position;
  }
}
