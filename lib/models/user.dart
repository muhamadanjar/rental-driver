import 'package:driver/models/user_meta.dart';
import 'package:driver/models/user_mobil.dart';
import 'package:driver/models/user_notification.dart';
import 'package:driver/models/user_saldo.dart';
import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  String email;
  String phonenumber;
  String token;
  String refreshToken;
  String file;
  
  List<UserMeta> metas;
  UserSaldo account;
  UserNotification userNotification;
  UserMobil mobil;

  User({@required this.id, this.email = "email",this.name = 'User',this.phonenumber = "0",this.token,this.refreshToken,this.file,this.metas,this.account,this.userNotification,this.mobil});
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
        account: json['account'] != null ? new UserSaldo.fromJson(json['account']) : null,
        metas: usermetas,
    );
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    
    return data;
  }
}