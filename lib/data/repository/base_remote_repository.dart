import 'package:dio/dio.dart';

abstract class BaseRemoteRepository {
  // Dio 클라이언트 getter
  Dio get client => _client;

  // 토큰 getter
  String? get bearerToken => interceptor.bearerToken;

  // Dio 클라이언트 초기화
  static final Dio _client = Dio(
    BaseOptions(
      baseUrl: 'https://api.vworld.kr/req', // VWorld API 기본 URL
      validateStatus: (status) => true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 6),
      sendTimeout: const Duration(seconds: 6),
    ),
  )..interceptors.add(interceptor);

  static final AuthInterceptor interceptor = AuthInterceptor();
}

// 인증 인터셉터 클래스
class AuthInterceptor extends Interceptor {
  String? bearerToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (bearerToken != null) {
      options.headers.addAll({
        'Authorization': bearerToken,
      });
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.realUri.path == '/login' && response.statusCode == 200) {
      final token = response.headers['Authorization'];
      bearerToken = token?.first;
      print('로그인 성공: $bearerToken');
    }
    super.onResponse(response, handler);
  }
}
