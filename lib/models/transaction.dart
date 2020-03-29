class Trx {
  final String type, number, amount, date;
  Trx({this.type, this.amount, this.date, this.number});

  factory Trx.fromJson(Map<String,dynamic>json){
    return Trx(type: json['kode_transaksi'],number: json['nomor_transaksi'],amount: json['nominal'],date: json['date']);
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['number'] = this.number;
    data['date'] = this.date;
    return data;
  }
}