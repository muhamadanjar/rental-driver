import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/models/auth_mode.dart';
import 'package:driver/models/responseapi.dart';
import 'package:driver/models/user.dart';
import 'package:driver/models/user_notification.dart';
import 'package:driver/models/viewstate.dart';
import 'package:driver/utils/api_provider.dart';
import 'package:driver/utils/prefs.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MainModel extends Model with ConnectedModel,UtilityModel,UserModel{}

mixin ConnectedModel on Model {
  ResponseApi globResult = new ResponseApi();
  ApiProvider _apiProvider =  new ApiProvider(); 
  User _authenticatedUser;
  
  
  Dio dio = new Dio();
  

  ViewState _state;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
  
}

mixin UserModel on ConnectedModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  Future<List<UserNotification>> get getDataNotifFromApi => _apiProvider.getUserNotification(_authenticatedUser.token); 
  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<ResponseApi> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    setState(ViewState.Busy);
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    Response response;
    
    if (mode == AuthMode.Login) {
      response = await dio.post(
        ResourceLink.loginUrl,
        data: json.encode(authData),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    } else {
      response = await dio.post(
        ResourceLink.registerUrl,
        data: json.encode(authData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        
      );
    }
    
    final Map<String, dynamic> responseData = json.decode(json.encode(response.data));
    print(responseData['data']);
    
    
    String message = 'Something went wrong.';
    globResult = ResponseApi.fromJson(responseData);
    print(globResult);
    if (globResult.status == 'error') {
      message = globResult.message;
    
    }
    
    if (globResult.data != null) {
      var data = globResult.data;
      int ex = (data['expireTime'] != null)? data['expireTime']:3600;
    
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: responseData['id'],
          email: email,
          name: email,
      );
      setAuthTimeout(ex);
      _userSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime = now.add(Duration(seconds: ex));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['access_token']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['id']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    }
    
    setState(ViewState.Retrieved);
    notifyListeners();
    
    return globResult;
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final String name = prefs.getString('name');
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(id: userId,name:name, email: userEmail, token: token);
      _userSubject.add(true);
      setAuthTimeout(tokenLifespan);
      notifyListeners();
    }
  }

  void logout() async {
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }

  Future<ResponseApi> getUserNotifikasi() async{
    await dio.get("$apiURL/user-notifiacations",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authenticatedUser.token}'
        }
      )
    );
  }
}

mixin UtilityModel on ConnectedModel {}