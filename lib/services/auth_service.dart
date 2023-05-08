
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import './dio_service.dart';
import '../common/riverpod_service.dart';
import '../states/jwt_state.dart';
import '../states/user_state.dart';
import '../models/user.dart';
import '../models/jwt_tokens.dart';


final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));




class AuthService extends RiverpodService {

  DioService get _dioService => ref.read(dioServiceProvider);
  JwtTokens get _jwtTokens => ref.read(jwtStateProvider);
  JwtStateNotifier get _jwtStateNotifier => ref.read(jwtStateProvider.notifier);
  UserStateNotifier get _userStateNotifier => ref.read(userStateProvider.notifier);


  AuthService(ProviderRef ref): super(ref);


  Future<void> login() async {
    JwtTokens jwtTokensState = _jwtTokens;
    if (jwtTokensState.accessToken != null) throw Exception('AuthService.login: Already authenticated');
  
    _userStateNotifier.setLoading();

    try {
      JwtTokens tokenResponseDTO = await _postSignin();

      // I have to set the access token and refresh token first, because the getProfile() method
      // needs the access token to get the user data.
      _jwtStateNotifier.setJwtTokens(
        accessToken: tokenResponseDTO.accessToken,
        refreshToken: tokenResponseDTO.refreshToken
      );

      User user = await _getProfile();
      _userStateNotifier.setUser(user);

    } on DioError catch (error, stackTrace) {
      print(error.response);
      _userStateNotifier.setError(error, stackTrace);
    }
  }


  Future<void> logout() async {
    JwtTokens jwtTokensState = _jwtTokens;
    if (jwtTokensState.accessToken == null) throw Exception('AuthService.logout: Not authenticated');

    _userStateNotifier.setLoading();

    try {
      await _postSignout();
      _userStateNotifier.setUser(null);
      _jwtStateNotifier.clearJwtTokens();

    } on DioError catch (error, stackTrace) {
      print(error.response);
      _userStateNotifier.setError(error, stackTrace);
    }
  }


  Future<void> get() async {
    JwtTokens jwtTokensState = _jwtTokens;
    if (jwtTokensState.accessToken == null) throw Exception('AuthService.get: Not authenticated');

    _userStateNotifier.setLoading();

    try {
      User user = await _getProfile();
      _userStateNotifier.setUser(user);

    } on DioError catch (error, stackTrace) {
      print(error.response);
      _userStateNotifier.setError(error, stackTrace);
    }
  }





  Future<JwtTokens> _postSignin() async {
    Response tokenResponse = await _dioService.baseUrlDio.post(
      '/auth/signin',
      data: {
        "phoneNumber": "1111111111",
        "password": "1234"
      },
    );

    return JwtTokens(
      accessToken: tokenResponse.data['access_token'],
      refreshToken: tokenResponse.data['refresh_token'],
    );
  }


  Future<User> _getProfile() async {
    Response userResponse = await _dioService.baseUrlDio.get('/user/profile');
    return User.fromJson(userResponse.data);
  }


  Future<void> _postSignout() async {
    await _dioService.baseUrlDio.post('/auth/signout');
  }
}