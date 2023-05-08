
import 'package:flutter_auth/models/jwt_tokens.dart';
import 'package:dio/dio.dart';

import '../provider_container.dart';
import '../states/jwt_state.dart';
import '../services/dio_service.dart';


class RefreshTokenInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // Although reading the riverpod container directly is not recommended, it is the easiest way
    // to get the current state.
    //
    // This interceptor automatically try to refresh the access token if there is a refresh token
    if (
      err.response == null ||
      err.response!.statusCode != 401 ||
      err.response!.data == null ||
      err.response!.data['error'] == null ||
      err.response!.data['error'] != 'jwt expired'
    ) return handler.next(err);

    JwtTokens jwtTokens = providerContainer.read(jwtStateProvider);
    if (jwtTokens.refreshToken == null) return handler.next(err);

    RequestOptions options = err.requestOptions;
    DioService dioService = providerContainer.read(dioServiceProvider);
    JwtStateNotifier jwtStateNotifier = providerContainer.read(jwtStateProvider.notifier);

    try {
      // Refresh the access token
      Response tokenResponse = await dioService.baseUrlDio.post(
        '/auth/refresh',
        options: Options(headers: {'Authorization': 'Bearer ${jwtTokens.refreshToken}'}),
      );

      // Update the access token and refresh token in riverpod state
      jwtStateNotifier.setJwtTokens(
        accessToken: tokenResponse.data['access_token'],
        refreshToken: tokenResponse.data['refresh_token']
      );

      // Retry the original request with the new access token
      options.headers['Authorization'] = 'Bearer ${tokenResponse.data['access_token']}';
      Response res = await dioService.baseUrlDio.fetch(options);
      handler.resolve(res);

    } on DioError catch (error) {
      handler.reject(error);
    }
  }
}