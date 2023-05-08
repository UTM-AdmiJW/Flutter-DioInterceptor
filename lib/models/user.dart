

import 'package:flutter/material.dart';


@immutable
class User {
  final String id;
  final String phoneNumber;
  final String email;
  final List<String> roles;
  final String fullName;
  final String nickName;
  final int idType;
  final String idNo;
  final DateTime dob;

  const User({
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.roles,
    required this.fullName,
    required this.nickName,
    required this.idType,
    required this.idNo,
    required this.dob,
  });

  User.fromJson(Map<String, dynamic> json):
    id = json['_id'],
    phoneNumber = json['phoneNumber'],
    email = json['email'],
    roles = json['roles'].cast<String>(),
    fullName = json['fullname'],
    nickName = json['nickname'],
    idType = int.parse( json['idType'] ),
    idNo = json['idNo'],
    dob = DateTime.parse(json['dob']);
}