
import 'package:flutter/material.dart';


@immutable
class JwtTokens {
  final String? accessToken;
  final String? refreshToken;

  const JwtTokens({
    this.accessToken,
    this.refreshToken,
  });
}