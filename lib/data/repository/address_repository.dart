import 'package:flutter_application_seau/data/model/address.dart';
import 'package:flutter_application_seau/data/repository/base_remote_repository.dart';

class AddressRepository extends BaseRemoteRepository {
  // 내 주소 목록 조회
  Future<List<Address>?> getMyAddressList() async {
    try {
      final response = await client.get('/api/address');
      if (response.statusCode == 200) {
        final content = response.data['content'] as List<dynamic>;
        return content.map((e) => Address.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      print('주소 목록 조회 실패: $e');
      return null;
    }
  }

  // 이름으로 주소 검색
  Future<List<Address>> searchAddressByName(String query) async {
    try {
      final response = await client.get(
        '/api/address/search',
        queryParameters: {'query': query},
      );
      if (response.statusCode == 200) {
        final content = response.data['content'] as List<dynamic>;
        return content.map((e) => Address.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print('주소 검색 실패: $e');
      rethrow;
    }
  }

  // 위도/경도로 주소 검색
  Future<Address?> searchAddressByLatLng(double lat, double lng) async {
    try {
      final response = await client.get(
        '/api/address/reverse-geocode',
        queryParameters: {'lat': lat, 'lng': lng},
      );
      if (response.statusCode == 200) {
        return Address.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('위치 기반 주소 검색 실패: $e');
      rethrow;
    }
  }
}
