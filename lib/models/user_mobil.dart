class UserMobil {
  int id;
  String noPlat;
  String name;
  String merk;
  String type;
  String warna;
  int harga;
  int hargaPerjam;
  int tahun;
  String foto;
  int userId;
  int isselected;
  String status;
  String createdAt;
  String updatedAt;

  UserMobil(
      {this.id,
      this.noPlat,
      this.name,
      this.merk,
      this.type,
      this.warna,
      this.harga,
      this.hargaPerjam,
      this.tahun,
      this.foto,
      this.userId,
      this.isselected,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserMobil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noPlat = json['no_plat'];
    name = json['name'];
    merk = json['merk'];
    type = json['type'];
    warna = json['warna'];
    harga = json['harga'];
    hargaPerjam = json['harga_perjam'];
    tahun = json['tahun'];
    foto = json['foto'];
    userId = json['user_id'];
    isselected = json['isselected'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_plat'] = this.noPlat;
    data['name'] = this.name;
    data['merk'] = this.merk;
    data['type'] = this.type;
    data['warna'] = this.warna;
    data['harga'] = this.harga;
    data['harga_perjam'] = this.hargaPerjam;
    data['tahun'] = this.tahun;
    data['foto'] = this.foto;
    data['user_id'] = this.userId;
    data['isselected'] = this.isselected;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}