class Order {
  int _orderId;
  String _orderCode;
  int _orderUserId;
  String _orderAddressOrigin;
  String _orderAddressOriginLat;
  String _orderAddressOriginLng;
  String _orderAddressDestination;
  String _orderAddressDestinationLat;
  String _orderAddressDestinationLng;
  int _orderDriverId;
  String _orderJenis;
  int _orderNominal;
  String _orderTglPesanan;
  String _orderWaktuJemput;
  String _orderWaktuBerakhir;
  String _orderKeterangan;
  int _orderStatus;
  String _createdBy;
  String _updatedBy;

  static final String STATUS_PENDING = '0';
  static final String STATUS_COMPLETE = '4';
  static final String STATUS_CANCEL = '5';
  static final String STATUS_DECLINE = '6';

  Order(
      {int orderId,
        String orderCode,
        int orderUserId,
        String orderAddressOrigin,
        String orderAddressOriginLat,
        String orderAddressOriginLng,
        String orderAddressDestination,
        String orderAddressDestinationLat,
        String orderAddressDestinationLng,
        int orderDriverId,
        String orderJenis,
        int orderNominal,
        String orderTglPesanan,
        String orderWaktuJemput,
        String orderWaktuBerakhir,
        String orderKeterangan,
        int orderStatus,
        String createdBy,
        String updatedBy}) {
    this._orderId = orderId;
    this._orderCode = orderCode;
    this._orderUserId = orderUserId;
    this._orderAddressOrigin = orderAddressOrigin;
    this._orderAddressOriginLat = orderAddressOriginLat;
    this._orderAddressOriginLng = orderAddressOriginLng;
    this._orderAddressDestination = orderAddressDestination;
    this._orderAddressDestinationLat = orderAddressDestinationLat;
    this._orderAddressDestinationLng = orderAddressDestinationLng;
    this._orderDriverId = orderDriverId;
    this._orderJenis = orderJenis;
    this._orderNominal = orderNominal;
    this._orderTglPesanan = orderTglPesanan;
    this._orderWaktuJemput = orderWaktuJemput;
    this._orderWaktuBerakhir = orderWaktuBerakhir;
    this._orderKeterangan = orderKeterangan;
    this._orderStatus = orderStatus;
    this._createdBy = createdBy;
    this._updatedBy = updatedBy;
  }

  int get orderId => _orderId;
  set orderId(int orderId) => _orderId = orderId;
  String get orderCode => _orderCode;
  set orderCode(String orderCode) => _orderCode = orderCode;
  int get orderUserId => _orderUserId;
  set orderUserId(int orderUserId) => _orderUserId = orderUserId;
  String get orderAddressOrigin => _orderAddressOrigin;
  set orderAddressOrigin(String orderAddressOrigin) =>
      _orderAddressOrigin = orderAddressOrigin;
  String get orderAddressOriginLat => _orderAddressOriginLat;
  set orderAddressOriginLat(String orderAddressOriginLat) =>
      _orderAddressOriginLat = orderAddressOriginLat;
  String get orderAddressOriginLng => _orderAddressOriginLng;
  set orderAddressOriginLng(String orderAddressOriginLng) =>
      _orderAddressOriginLng = orderAddressOriginLng;
  String get orderAddressDestination => _orderAddressDestination;
  set orderAddressDestination(String orderAddressDestination) =>
      _orderAddressDestination = orderAddressDestination;
  String get orderAddressDestinationLat => _orderAddressDestinationLat;
  set orderAddressDestinationLat(String orderAddressDestinationLat) =>
      _orderAddressDestinationLat = orderAddressDestinationLat;
  String get orderAddressDestinationLng => _orderAddressDestinationLng;
  set orderAddressDestinationLng(String orderAddressDestinationLng) =>
      _orderAddressDestinationLng = orderAddressDestinationLng;
  int get orderDriverId => _orderDriverId;
  set orderDriverId(int orderDriverId) => _orderDriverId = orderDriverId;
  String get orderJenis => _orderJenis;
  set orderJenis(String orderJenis) => _orderJenis = orderJenis;
  int get orderNominal => _orderNominal;
  set orderNominal(int orderNominal) => _orderNominal = orderNominal;
  String get orderTglPesanan => _orderTglPesanan;
  set orderTglPesanan(String orderTglPesanan) =>
      _orderTglPesanan = orderTglPesanan;
  String get orderWaktuJemput => _orderWaktuJemput;
  set orderWaktuJemput(String orderWaktuJemput) =>
      _orderWaktuJemput = orderWaktuJemput;
  String get orderWaktuBerakhir => _orderWaktuBerakhir;
  set orderWaktuBerakhir(String orderWaktuBerakhir) =>
      _orderWaktuBerakhir = orderWaktuBerakhir;
  String get orderKeterangan => _orderKeterangan;
  set orderKeterangan(String orderKeterangan) =>
      _orderKeterangan = orderKeterangan;
  int get orderStatus => _orderStatus;
  set orderStatus(int orderStatus) => _orderStatus = orderStatus;
  String get createdBy => _createdBy;
  set createdBy(String createdBy) => _createdBy = createdBy;
  String get updatedBy => _updatedBy;
  set updatedBy(String updatedBy) => _updatedBy = updatedBy;

  Order.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _orderCode = json['order_code'];
    _orderUserId = json['order_user_id'];
    _orderAddressOrigin = json['order_address_origin'];
    _orderAddressOriginLat = json['order_address_origin_lat'];
    _orderAddressOriginLng = json['order_address_origin_lng'];
    _orderAddressDestination = json['order_address_destination'];
    _orderAddressDestinationLat = json['order_address_destination_lat'];
    _orderAddressDestinationLng = json['order_address_destination_lng'];
    _orderDriverId = json['order_driver_id'];
    _orderJenis = json['order_jenis'];
    _orderNominal = json['order_nominal'];
    _orderTglPesanan = json['order_tgl_pesanan'];
    _orderWaktuJemput = json['order_waktu_jemput'];
    _orderWaktuBerakhir = json['order_waktu_berakhir'];
    _orderKeterangan = json['order_keterangan'];
    _orderStatus = json['order_status'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this._orderId;
    data['order_code'] = this._orderCode;
    data['order_user_id'] = this._orderUserId;
    data['order_address_origin'] = this._orderAddressOrigin;
    data['order_address_origin_lat'] = this._orderAddressOriginLat;
    data['order_address_origin_lng'] = this._orderAddressOriginLng;
    data['order_address_destination'] = this._orderAddressDestination;
    data['order_address_destination_lat'] = this._orderAddressDestinationLat;
    data['order_address_destination_lng'] = this._orderAddressDestinationLng;
    data['order_driver_id'] = this._orderDriverId;
    data['order_jenis'] = this._orderJenis;
    data['order_nominal'] = this._orderNominal;
    data['order_tgl_pesanan'] = this._orderTglPesanan;
    data['order_waktu_jemput'] = this._orderWaktuJemput;
    data['order_waktu_berakhir'] = this._orderWaktuBerakhir;
    data['order_keterangan'] = this._orderKeterangan;
    data['order_status'] = this._orderStatus;
    data['created_by'] = this._createdBy;
    data['updated_by'] = this._updatedBy;
    return data;
  }
}