import 'dart:convert';
import 'dart:html';

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
    // Response response = await _dio.get("$apiURL/driver/lasttransaksi",
    //   options: Options(
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization':'Bearer $token'
    //     }
    //   ),
    // );
    // final body = ResponseApi.fromJson(response.data);
    // final List rawData = jsonDecode(jsonEncode(body.data));
    // List<Trx> listTransaksi =rawData.map((f)=>Trx.fromJson(f)).toList();
    final List listTransaksi = [
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '10,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '11,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '12,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '13,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '14,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '15,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '16,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '55,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '15,000.00',
        date: '10-06-2019',
      ),
      Trx(
        type: 'cwdr/',
        number: '974884/9874513365478965',
        amount: '25,000.00',
        date: '10-06-2019',
      ),
    ];
    return listTransaksi;
  }
}