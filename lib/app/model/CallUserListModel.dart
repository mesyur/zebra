class CallUserListModel {
  CallUserListModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  CallUserListModel.fromJson(Map<String, dynamic> json){
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
    required this.phone,
  });
  late final int userId;
  late final String firstName;
  late final String lastName;
  late final String phone;

  Data.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['phone'] = phone;
    return _data;
  }
}