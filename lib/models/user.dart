class User {
  int id;
  String name;
  String email;

  User({@required this.id, this.email = "email",this.name = 'User'});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
    );
  }
  
}