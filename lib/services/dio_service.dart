
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import '../common/riverpod_service.dart';
import '../interceptors/access_token_interceptor.dart';
import '../interceptors/refresh_token_interceptor.dart';


final dioServiceProvider = Provider<DioService>((ref) => DioService(ref));


class DioService extends RiverpodService {

  // Constructor. Interceptors are registered here.
  DioService(ProviderRef ref): super(ref) {
    _baseUrlDio.interceptors.add(AccessTokenInterceptor());
    _baseUrlDio.interceptors.add(RefreshTokenInterceptor());
  }

  final Dio _baseUrlDio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL']!,
  ));


  Dio get baseUrlDio => _baseUrlDio;
}