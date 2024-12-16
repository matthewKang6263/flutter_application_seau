import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  // 위치 권한 확인
  static bool _isDenied(LocationPermission permission) {
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  // 현재 위치 조회
  static Future<Position?> getPositon() async {
    try {
      // 위치 서비스 활성화 확인
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('위치 서비스가 비활성화되어 있습니다.');
      }

      // 위치 권한 확인
      final permission = await Geolocator.checkPermission();
      if (_isDenied(permission)) {
        final request = await Geolocator.requestPermission();
        if (_isDenied(request)) {
          return null;
        }
      }

      // 위치 설정
      final locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      // 현재 위치 조회
      return await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
    } catch (e) {
      print('위치 정보 조회 실패: $e');
      rethrow;
    }
  }
}
