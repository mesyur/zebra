class OfferListModel {
  OfferListModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  OfferListModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.firstName,
    required this.lastName,
    required this.serviceOfferId,
    required this.detail,
    required this.serviceDate,
    required this.serviceTime,
    required this.note,
    this.bid,
  });
  late final String firstName;
  late final String lastName;
  late final int serviceOfferId;
  late final String detail;
  late final String? serviceDate;
  late final String serviceTime;
  late final String note;
  late final Null bid;

  Data.fromJson(Map<String, dynamic> json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    serviceOfferId = json['serviceOfferId'];
    detail = json['detail'];
    serviceDate = json['serviceDate'] == null ? '' : json['serviceDate'];
    serviceTime = json['serviceTime'];
    note = json['note'];
    bid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['serviceOfferId'] = serviceOfferId;
    _data['detail'] = detail;
    _data['serviceDate'] = serviceDate;
    _data['serviceTime'] = serviceTime;
    _data['note'] = note;
    _data['bid'] = bid;
    return _data;
  }
}