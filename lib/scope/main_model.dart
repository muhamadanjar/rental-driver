import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/models/auth.dart';
import 'package:driver/models/auth_mode.dart';
import 'package:driver/models/order.dart';
import 'package:driver/models/responseapi.dart';
import 'package:driver/models/user.dart';
import 'package:driver/models/user_notification.dart';
import 'package:driver/models/user_saldo.dart';
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
  UserSaldo _userAccount;
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

  UserSaldo get account{
    return _userAccount;
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
    globResult = ResponseApi.errorJson();
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
      prefs.setString('userId', responseData['id'].toString());
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
      final String userId = prefs.getString('userId');
      final String name = prefs.getString('name');
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      print(userId);
//      print("user id = $userId");
      _authenticatedUser = User(id: int.parse(userId),name:name, email: userEmail, token: token);
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
    // print("deleting user ${_auth.id}");

    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    prefs.remove('name');
    // prefs.clear();
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }

  Future<String> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token");
    if(token != null){
      return token;
    }
    logout();
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

  void getUser() async{

    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final String name = prefs.getString('name');
      final String token = prefs.getString("token");
      const url = "$apiURL/auth/user";
      print(token);
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
        // print(response.data);
        if(response.statusCode == 200){
          // print(response.data);
          Map map = json.decode(json.encode(response.data));
          print(map);
          map['data']['access_token'] = token;
          print("statuscode ${map['code']}");
          ResponseApi ra = ResponseApi.fromJson(map);
          _authenticatedUser = User.fromJson(ra.data);
          _userAccount = UserSaldo.fromJson(map['data']['account']);
          print("akun ${_userAccount.saldo}");
          print("Response api ${ra.data}");
          // print("email $userEmail");
          // print("name $name");
          // print("user id $userId");
          // print(_authenticatedUser.account);
          if(userId == null){
            // print("userId = ${map['data']['id']}");
            prefs.setString("userId", map['data']['id'].toString());
            prefs.setString("userEmail", map['data']['email']);
            prefs.setString("name", map['data']['name']);
          // print("current userid ${prefs.getString('name')}");
          }
          notifyListeners();
          // return ra;
        }
        // return ResponseApi(code: 400,message: message,data: null,status: 'error');
      }
      // return ResponseApi.errorJson();
    }catch (e){
      throw new Exception(e);
      // return ResponseApi.errorJson();
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
  List transactions;
  Order currentOrder; 
  bool isOrdered = false;
  Future getHistoryUser()async{
    Response response = await dio.post(ResourceLink.getHistoryBookingUser,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authenticatedUser.token}'
        }
      )
    );
    final body = ResponseApi.fromJson(response.data);    
    final List rawData = jsonDecode(jsonEncode(body.data));
    // print(rawData);
    List<Order> list = rawData.map((f) => Order.fromJson(f)).toList();
    // history = list;
    // notifyListeners();
    return list;
  }

  Future<ResponseApi> changeStatusOrder(FormData data) async {
    final String url = ResourceLink.postUpdateOrderStatus;
    print(url);
    Response response = await dio.post(url,
    data: data,
      options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_authenticatedUser.token}'
            }
        )
    );
    ResponseApi ra = ResponseApi.fromJson(response.data);
    currentOrder = Order.fromJson(ra.data);
    notifyListeners();
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
  void getLastTransaksi() async{

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString("token");
      var list = await _apiProvider.getUserTransaksi(token);
      print(list);
    } catch (e) {
    }
  }
}
mixin UtilityModel on ConnectedModel {
}