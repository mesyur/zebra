class FavoriteListModel {
  FavoriteListModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  FavoriteListModel.fromJson(Map<String, dynamic> json){
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
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.phone,
    required this.callId,
    required this.createdDate,
  });
  late final int userId;
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String phone;
  late final int callId;
  late final String createdDate;

  Data.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    name = json['name'];
    phone = json['phone'];
    callId = json['callId'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['callId'] = callId;
    _data['createdDate'] = createdDate;
    return _data;
  }
}