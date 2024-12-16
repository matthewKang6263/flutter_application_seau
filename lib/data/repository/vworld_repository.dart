import 'package:dio/dio.dart';

class VWorldRepository {
  final Dio _client = Dio(BaseOptions(
    validateStatus: (status) => true,
  ));
  static const String _apiKey = '7CBEC662-DC88-3817-823E-321FF3AB3781';

  Future<List<String>> findByName(String query) async {
    final response = await _client.get(
      'https://api.vworld.kr/req/search',
      queryParameters: {
        'service': 'search',
        'request': 'search',
        'key': _apiKey,
        'query': query,
        'type': 'DISTRICT',
        'category': 'L4',
        'size': 100,
      },
    );

    if (response.statusCode == 200 &&
        response.data['response']['status'] == 'OK') {
      return List.of(response.data['response']['result']['items'])
          .map((e) => e['title'].toString())
          .toList();
    }
    return [];
  }

  Future<List<String>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    final response = await _client.get(
      'https://api.vworld.kr/req/data',
      queryParameters: {
        'service': 'data',
        'request': 'GetFeature',
        'data': 'LT_C_ADEMD_INFO',
        'key': _apiKey,
        'geomfilter': 'POINT($lng $lat)',
        'geometry': 'false',
        'size': 100,
      },
    );

    if (response.statusCode == 200 &&
        response.data['response']['status'] == 'OK') {
      return List.of(response.data['response']['result']['featureCollection']
              ['features'])
          .map((e) => e['properties']['full_nm'].toString())
          .toList();
    }
    return [];
  }
}
