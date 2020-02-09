
class Auth {
  int id;
  String name;
  String accessToken;
  String refreshToken;


  Auth({this.id,this.accessToken,this.name,this.refreshToken});

  factory Auth.fromJson(Map<String, dynamic> map) {
    return Auth(
        id: map['id'],
        name:map['name'],
        accessToken: map['accessToken'],
        refreshToken: map['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["accessToken"] = accessToken;
    map["refreshToken"] = refreshToken;

    return map;
  }
}