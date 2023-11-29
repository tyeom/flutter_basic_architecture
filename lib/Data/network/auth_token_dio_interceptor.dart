import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String ACCESS_TOKEN_KEY = 'authToken';

/// Dio Request, Response, Error시 가로채기
/// Request시 onRequest를 가로채어, accessToken이 필요한 API Url인 경우 헤더에 accessToken을 대체해서 Request 처리 한다.
class AuthTokenDioInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  AuthTokenDioInterceptor({required this.storage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[Dio REQ] [${options.method}] ${options.uri}');

    // 요청 헤더
    // 헤더에 accessToken가 있는 경우 인증 토큰 필요 API
    // ApiService 클래스에 Headers 어노테이션으로 정의 되어 있음.
    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      // 실제 토큰 대체
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[Dio RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[Dio ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    // 인증 처리가 AccessToken / RefreshToken 사용시
    // 여기서 인증 오류(Status 401)인 경우 AccessToken 만료시 RefreshToken 으로 AccessToken 재발급 처리를 한다.
    // AccessToken 재발급 후 AccessToken과 RefreshToken을 secure storage에 다시 기록후
    // 헤더에 AccessToken을 대체하고 다시 요청한다.(fetch)

    // When using AccessToken / RefreshToken for authentication processing
    // If there is an authentication error (Status 401) here,
    // the AccessToken is reissued using RefreshToken when the AccessToken expires.

    /***********************************************/

    // final isStatus401 = err.response?.statusCode == 401;
    // final isPathRefresh = err.requestOptions.path == '/auth/token';

    // // AccessToken 재발급
    // if (isStatus401 && !isPathRefresh) {
    //   final dio = Dio();
    //   try {
    //     final resp = await dio.post(
    //       'AccessToken 재발급 url',
    //       options: Options(
    //         headers: {'authorization': 'Bearer $refreshToken'},
    //       ),
    //     );

    //     // 재발급 받은 AccessToken 등록
    //     final accessToken = resp.data['accessToken'];

    //     // AccessToken 만료로 요청 실패 했던 옵션
    //     final options = err.requestOptions;
    //     // 재발급 AccessToken 으로 교체
    //     options.headers.addAll({'authorization': 'Bearer $accessToken'});
    //     // secure storage에 다시 보관
    //     await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

    //     final response = await dio.fetch(options);

    //     return handler.resolve(response);
    //   } catch (e) {
    //     return handler.reject(err);
    //   }
    // }

    super.onError(err, handler);
  }
}
