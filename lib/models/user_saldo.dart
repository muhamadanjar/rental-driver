class UserSaldo {
  int userId;
  int saldo;
  String noAnggota;

  UserSaldo({this.userId, this.saldo, this.noAnggota});

  UserSaldo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    saldo = json['saldo'];
    noAnggota = json['no_anggota'];
  } 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['saldo'] = this.saldo;
    data['no_anggota'] = this.noAnggota;
    return data;
  }
}
