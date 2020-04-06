import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:driver/models/responseapi.dart';
import 'package:driver/models/transaction.dart';
import 'package:driver/models/user_notification.dart';
import 'package:driver/utils/prefs.dart';

class ApiProvider{
  Dio _dio = new Dio();

  Future<List<UserNotification>> getUserNotification(String token) async{
    Response response = await _dio.get("$apiURL/users-notification",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':'Bearer $token'
        }
      )
    );
    
    final body =  ResponseApi.fromJson(response.data);
    final List rawData = jsonDecode(jsonEncode(body.data));
    List<UserNotification> listUserNotificationModel = rawData.map((f)=>UserNotification.fromMap(f)).toList();
    // print(api.data);
    return listUserNotificationModel;
  }

  Future<List> getUserTransaksi(String token) async{
    Response response = await _dio.get("$apiURL/driver/lasttransaksi",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':'Bearer $token'
        }
      ),
    );
    final body = ResponseApi.fromJson(response.data);
    final List rawData = jsonDecode(jsonEncode(body.data));
    List<Trx> listTransaksi =rawData.map((f)=>Trx.fromJson(f)).toList();
    // final List listTransaksi = [
      
    // ];
    return listTransaksi;
  }
}