import 'package:flutter_application_seau/data/repository/base_remote_repository.dart';

class VWorldRepository extends BaseRemoteRepository {
  // API 키 상수
  static const String _apiKey = '7CBEC662-DC88-3817-823E-321FF3AB3781';

  // 주소명으로 검색
  Future<List<String>> findByName(String query) async {
    if (query.length < 2) {
      // 최소 2글자 이상일 때만 검색
      return [];
    }

    try {
      print('검색 쿼리: $query');
      final response = await client.get(
        '/search', // baseUrl이 이미 포함되어 있으므로 상대 경로만 작성
        queryParameters: {
          'service': 'search',
          'request': 'search',
          'key': _apiKey,
          'query': query,
          'type': 'DISTRICT',
          'category': 'L4',
          'size': 100,
          'format': 'json',
        },
      );

      print('API 응답: ${response.data}');

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final items = response.data['response']['result']['items'] as List;
        return items.map((e) => e['title'].toString()).toList();
      }

      print('검색 실패: ${response.data['response']['error']?['text']}');
      return [];
    } catch (e) {
      print('주소 검색 실패: $e');
      return [];
    }
  }

  // 위도/경도로 주소 검색
  Future<List<String>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    try {
      print('위치 검색: lat=$lat, lng=$lng'); // 디버깅용 로그

      final response = await client.get(
        '/data', // baseUrl이 이미 포함되어 있으므로 상대 경로만 작성
        queryParameters: {
          'service': 'data',
          'request': 'GetFeature',
          'data': 'LT_C_ADEMD_INFO',
          'key': _apiKey,
          'geomfilter': 'POINT($lng $lat)',
          'geometry': 'false',
          'size': 1,
          'format': 'json',
        },
      );

      print('API 응답: ${response.data}'); // 디버깅용 로그

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final features = response.data['response']['result']
            ['featureCollection']['features'] as List;
        return features
            .map((e) => e['properties']['full_nm'].toString())
            .toList();
      }

      print('검색 실패: ${response.data['response']['error']?['text']}');
      return [];
    } catch (e) {
      print('위치 기반 주소 검색 실패: $e');
      return [];
    }
  }
}
