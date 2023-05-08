
import 'package:flutter_auth/models/jwt_tokens.dart';
import 'package:dio/dio.dart';

import '../provider_container.dart';
import '../states/jwt_state.dart';


class AccessTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    // Although reading the riverpod container directly is not recommended, it is the easiest way
    // to get the current state.
    //
    // This interceptor automatically adds the access token to the request header if the user is
    // authenticated, otherwise it does nothing.
    // 
    // Conditions for adding the access token:
    //  1. access_token is not null.
    //  2. The header does not contain the Authorization key yet.
    JwtTokens jwtTokens = providerContainer.read(jwtStateProvider);
    if (
      jwtTokens.accessToken == null ||
      options.headers.containsKey("Authorization")
    ) return handler.next(options);

    options.headers['Authorization'] = 'Bearer ${jwtTokens.accessToken}';
    return handler.next(options);
  }
}