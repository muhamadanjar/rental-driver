import 'package:driver/models/user_meta.dart';
import 'package:driver/models/user_notification.dart';
import 'package:driver/models/user_saldo.dart';
import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String email;
  String phonenumber;
  String token;
  String refreshToken;
  String file;
  
  List<UserMeta> metas;
  UserSaldo saldo;
  UserNotification userNotification;

  User({@required this.id, this.email = "email",this.name = 'User',this.phonenumber = "0",this.token,this.refreshToken,this.file,this.metas,this.saldo,this.userNotification});
  factory User.fromJson(Map<String, dynamic> json) {
    List<UserMeta> usermetas = new List<UserMeta>();
    if (json['meta'] != null) {
      json['meta'].forEach((v) {
        usermetas.add(new UserMeta.fromJson(v));
      });
    }
    
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        token: json['access_token'],
        refreshToken: json['refresh_token'],
        file: json['file'],
        saldo: json['saldo'] != null ? new UserSaldo.fromJson(json['saldo']) : null,
        metas: usermetas,
    );
  }
  
}