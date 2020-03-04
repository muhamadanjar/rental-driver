import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/models/auth.dart';
import 'package:driver/models/auth_mode.dart';
import 'package:driver/models/order.dart';
import 'package:driver/models/responseapi.dart';
import 'package:driver/models/user.dart';
import 'package:driver/models/user_notification.dart';
import 'package:driver/models/viewstate.dart';
import 'package:driver/utils/api_provider.dart';
import 'package:driver/utils/dbhelper.dart';
import 'package:driver/utils/prefs.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MainModel extends Model with ConnectedModel,UtilityModel,UserModel,OrderModel,RequestSaldo{}

mixin ConnectedModel on Model {
  ResponseApi globResult = new ResponseApi();
  ApiProvider _apiProvider =  new ApiProvider(); 
  User _authenticatedUser;
  Auth _auth;
  String message = 'Something went wrong.';
  Dio dio = new Dio();
  

  ViewState _state;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
  
}

mixin RequestSaldo on ConnectedModel{
  Future<Map<String,dynamic>> uploadBukti(FormData formData) async{
    setState(ViewState.Busy);
    notifyListeners();
    bool hasError = true;
    String message = 'Something went wrong.';

    FormData reqData = formData;

    Response response = await dio.post("$apiURL/topup/bukti",data: reqData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_authenticatedUser.token}'
          }
        )
    );

    final int statusCode = response.statusCode;
//    final bool status = response.data.status;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }


    setState(ViewState.Idle);
    notifyListeners();
    return {'success': !hasError, 'message': message};
  } 
}

mixin UserModel on ConnectedModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();
  DBHelper dbHelper = DBHelper();
  Future<List<UserNotification>> get getDataNotifFromApi => _apiProvider.getUserNotification(_authenticatedUser.token); 
  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<ResponseApi> authenticate(String email, String password,[AuthMode mode = AuthMode.Login]) async {
    setState(ViewState.Busy);
    notifyListeners();
    final Map<String, dynamic> authData = {
      'username': email,
      'password': password,
      'returnSecureToken': true
    };
    Response response;
    
    if (mode == AuthMode.Login) {
      response = await dio.post(
        ResourceLink.loginGrantPassword,
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
    print("response $responseData['access_token]");
    
    if (responseData != null && responseData['status'] == 'success') {
      globResult = ResponseApi.fromJson(responseData);
      int ex = (responseData['accessTokenExpiration'] != null)? responseData['accessTokenExpiration']:31622400;
    
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: responseData['id'],
          email: email,
          name: email,
          token: responseData['access_token']
      );
      setAuthTimeout(ex);
      _userSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime = now.add(Duration(seconds: ex));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
//      Auth _authData = Auth(id: responseData['id'],name: email, accessToken: responseData['access_token'],refreshToken: responseData['refresh_token']);
//      dbHelper.insert(_authData);
      prefs.setString('token', responseData['access_token']);
//      prefs.setString('userEmail', email);
//      prefs.setString('userId', responseData['id']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
      setState(ViewState.Retrieved);
    }

    setState(ViewState.Idle);
    notifyListeners();
    
    return globResult;
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    // print("token : $token $expiryTimeString");
    if (token != null) {
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.getString('userEmail');
      final int userId = int.parse(prefs.getString('userId'));
      final String name = prefs.getString('name');
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      print(userId);
//      print("user id = $userId");
      _authenticatedUser = User(id: userId,name:name, email: userEmail, token: token);
      // print(_authenticatedUser.toJson());r
      _userSubject.add(true);
      setAuthTimeout(tokenLifespan);
      notifyListeners();
    }
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    dbHelper.truncate("auth");
    print("deleting user ${_auth.id}");
    _auth = null;

    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    prefs.remove('name');
    prefs.clear();
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }

  Future<ResponseApi> getUserNotifikasi() async{
    Response response = await dio.get("$apiURL/user-notifiacations",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authenticatedUser.token}'
        }
      )
    );

    if(response.statusCode == 200){
      Map map = json.decode(json.encode(response.data));
      return ResponseApi.fromJson(map);
    }
    return ResponseApi(code: 400,message: message,data: null,status: 'error');

  }

  Future<ResponseApi> getUser() async{

    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final String name = prefs.getString('name');
      final String token = prefs.getString("token");
      const url = "$apiURL/auth/user";
//     _auth = await dbHelper.findOne('1');
      print(token);
      // print("Auth $_auth");
      if(token != null){
        Response response = await dio.get(url,
            options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer ${token}'
                }
            )
        );
        print("status code ${response.statusCode}");
        print(response.data);
        if(response.statusCode == 200){
          print(response.data);
          Map map = json.decode(json.encode(response.data));
          map['data']['access_token'] = token;
          ResponseApi ra = ResponseApi.fromJson(map);
          _authenticatedUser = User.fromJson(ra.data);

          if(userEmail == null && userId == null && name == null){
            prefs.setString("userId", ra.data.id);
            prefs.setString("userEmail", ra.data.email);
            prefs.setString("name", ra.data.name);
          }
          notifyListeners();
          return ra;
        }
        return ResponseApi(code: 400,message: message,data: null,status: 'error');
      }
    }catch (e){
      return ResponseApi.errorJson();
    }


  }

  Future<void> updateLocation() async{
    Response response = await dio.get(ResourceLink.updateLocation,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authenticatedUser.token}'
        }
      )
    );
    ResponseApi.fromJson(response.data);
  }

  Future<void> setAktivity() async{
    Response response = await dio.get(ResourceLink.updateActivity,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authenticatedUser.token}'
        }
      )
    );
    ResponseApi.fromJson(response.data);
  }



}

mixin OrderModel on ConnectedModel{
  List<Order> history;
  Order currentOrder; 
  bool isOrdered = false;
  Future<void> getHistoryUser()async{
    Response response = await dio.post(ResourceLink.getHistoryBookingUser,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authenticatedUser.token}'
        }
      )
    );
    print(response.data);
    ResponseApi ra =  ResponseApi.fromJson(response.data);
    history =  ra.data;
    notifyListeners();

  }

  Future<ResponseApi> changeStatusOrder(FormData data) async {
    Response response = await dio.post(ResourceLink.postUpdateOrderStatus,
    data: data,
      options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_authenticatedUser.token}'
            }
        )
    );
    ResponseApi ra = ResponseApi.fromJson(response.data);
    notifyListeners();
    // print(response.statusCode);
    // print(response.data);
    return ra;
  }
  Future<void> checkOrder() async {
    try {
      final String url = ResourceLink.getDriverStatusOrder;
      print(url);
      print("${_authenticatedUser.token}");
      Response response = await dio.post(url,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${_authenticatedUser.token}'
              }
          )
      );
      print(response.data);
      var ra = ResponseApi.fromJson(response.data);
      print("ra ${ra.data}");
      setState(ViewState.Busy);
      if(ra.code == 200 && ra.status == 'success'){
        isOrdered = true;
        currentOrder = Order.fromJson(ra.data);
        print(currentOrder.orderCode);
        setState(ViewState.Retrieved);
      }
      setState(ViewState.Idle);
      notifyListeners();
    } catch (e) {
      print(e);
    }
    

  }
}
mixin UtilityModel on ConnectedModel {}