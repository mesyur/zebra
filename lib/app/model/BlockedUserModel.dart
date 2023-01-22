class BlockedUserModel {
  BlockedUserModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  BlockedUserModel.fromJson(Map<String, dynamic> json){
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
    required this.blockedUserId,
    required this.firstName,
    required this.lastName,
  });
  late final int blockedUserId;
  late final String firstName;
  late final String lastName;

  Data.fromJson(Map<String, dynamic> json){
    blockedUserId = json['blockedUserId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['blockedUserId'] = blockedUserId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    return _data;
  }
}