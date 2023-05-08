
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/riverpod_state_notifier.dart';
import '../models/jwt_tokens.dart';


final jwtStateProvider = StateNotifierProvider<JwtStateNotifier, JwtTokens>(
  (ref) => JwtStateNotifier(ref),
);


class JwtStateNotifier extends RiverpodStateNotifier<JwtTokens> {

  JwtStateNotifier(StateNotifierProviderRef ref): super(
    const JwtTokens(),
    ref
  );

  void setJwtTokens({
    String? accessToken,
    String? refreshToken,
  }) {
    state = JwtTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  void clearJwtTokens() {
    state = const JwtTokens();
  }
}