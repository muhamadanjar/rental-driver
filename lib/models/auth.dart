
class Auth {
  int id;
  String accessToken;
  String refreshToken;


  Auth({this.id,this.accessToken,this.refreshToken});

  factory Auth.fromJson(Map<String, dynamic> map) {
    return Auth(
        id: map['id'],
        accessToken: map['accessToken'],
        refreshToken: map['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["accessToken"] = accessToken;
    map["refreshToken"] = refreshToken;

    return map;
  }
}