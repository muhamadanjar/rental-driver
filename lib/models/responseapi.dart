
class ResponseApi {
  String status;
  String message;
  dynamic data;
  int code;
  ResponseApi({this.status,this.message,this.data,this.code});

  factory ResponseApi.fromJson(Map<String,dynamic>json){
    return ResponseApi(
      status:json['status'],
      message:json['message'],
      data:json['data'],
      code:json['code']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    data['code'] = this.code;
    return data;
  }
}