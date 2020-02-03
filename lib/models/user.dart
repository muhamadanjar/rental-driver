import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String email;
  String token;
  String refreshToken;
  String file;

  User({@required this.id, this.email = "email",this.name = 'User',this.token,this.refreshToken,this.file});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        token: json['access_token'],
        refreshToken: json['refresh_token'],
        file: json['file']
    );
  }
  
}