import 'package:dio/dio.dart';

class VWorldRepository {
  // API 관련 상수 정의
  static const String _apiKey = '7CBEC662-DC88-3817-823E-321FF3AB3781';

  // Dio 클라이언트 초기화
  final Dio _client = Dio(
    BaseOptions(
      validateStatus: (status) => true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 6),
    ),
  );

  // 주소명으로 검색
  Future<List<String>> findByName(String query) async {
    try {
      final response = await _client.get(
        'https://api.vworld.kr/req/search',
        queryParameters: {
          'service': 'search', // 필수 파라미터 추가
          'request': 'search',
          'key': _apiKey,
          'query': query,
          'type': 'DISTRICT',
          'category': 'L4',
          'size': 100,
          'format': 'json',
        },
      );

      // 응답 확인 및 데이터 파싱
      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final items = response.data['response']['result']['items'] as List;
        return items.map((e) => e['title'].toString()).toList();
      }

      print('검색 실패: ${response.data['response']['error']['text']}');
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
      final response = await _client.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'service': 'data', // 필수 파라미터 추가
          'request': 'GetFeature',
          'data': 'LT_C_ADEMD_INFO',
          'key': _apiKey,
          'geomfilter': 'POINT($lng $lat)', // 대문자 POINT로 수정하고 공백으로 구분
          'geometry': 'false',
          'size': 100,
          'format': 'json',
        },
      );

      // 응답 확인 및 데이터 파싱
      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final features = response.data['response']['result']
            ['featureCollection']['features'] as List;
        return features
            .map((e) => e['properties']['full_nm'].toString())
            .toList();
      }

      print('검색 실패: ${response.data['response']['error']['text']}');
      return [];
    } catch (e) {
      print('위치 기반 주소 검색 실패: $e');
      return [];
    }
  }
}






// import 'package:dio/dio.dart';

// class VWorldRepository {
//   final Dio _client = Dio(BaseOptions(
//     // 설정안할 시 실패 응답 시 throw
//     validateStatus: (status) => true,
//   ));

//   Future<List<String>> findByName(String query) async {
//     final response = await _client.get(
//       'https://api.vworld.kr/req/search',
//       queryParameters: {
//         'request': 'search',
//         'key': '6D3D0CF6-EDAC-3C0B-BDC6-4FCDF597CE1E',
//         'query': query,
//         'type': 'DISTRICT',
//         'category': 'L4',
//         'size': 100, // Optional
//       },
//     );

//     if (response.statusCode == 200 &&
//         response.data['response']['status'] == 'OK') {
//       // 행정주소 외 정보는 쓰지 않아서 모델생성 X(개인취향)
//       // 써드파티 API(외부 API) 모델링 시 프로젝트에 외부 모델이 추가가되어 관리 힘듦
//       return List.of(response.data['response']['result']['items'])
//           .map((e) => e['title'].toString())
//           .toList();
//     }

//     return [];
//   }

//   Future<List<String>> findByLatLng({
//     required double lat,
//     required double lng,
//   }) async {
//     final response = await _client.get(
//       'https://api.vworld.kr/req/data',
//       queryParameters: {
//         'request': 'GetFeature',
//         'data': 'LT_C_ADEMD_INFO',
//         'key': '6D3D0CF6-EDAC-3C0B-BDC6-4FCDF597CE1E',
//         'geomfilter': 'point($lng $lat)',
//         'geometry': 'false',
//         'size': 100, // Optional
//       },
//     );

//     if (response.statusCode == 200 &&
//         response.data['response']['status'] == 'OK') {
//       // 행정주소 외 정보는 쓰지 않아서 모델생성 X(개인취향)
//       // 써드파티 API(외부 API) 모델링 시 프로젝트에 외부 모델이 추가가되어 관리 힘듦
//       return List.of(response.data['response']['result']['featureCollection']
//               ['features'])
//           .map((e) => e['properties']['full_nm'].toString())
//           .toList();
//     }

//     return [];
//   }
// }
