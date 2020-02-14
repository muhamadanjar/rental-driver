class UserMeta {
  String id;
  String metaKey;
  String metaValue;
  String metaUsers;
  String createdAt;
  String updatedAt;

  UserMeta(
      {this.id,
      this.metaKey,
      this.metaValue,
      this.metaUsers,
      this.createdAt,
      this.updatedAt});

  UserMeta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metaKey = json['meta_key'];
    metaValue = json['meta_value'];
    metaUsers = json['meta_users'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meta_key'] = this.metaKey;
    data['meta_value'] = this.metaValue;
    data['meta_users'] = this.metaUsers;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}