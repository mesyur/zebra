class LastCallModel {
  LastCallModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  LastCallModel.fromJson(Map<String, dynamic> json){
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
    required this.isBlocked,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.createdDate,
    required this.callId,
    required this.isAnswered,
    required this.callType,
    required this.isFavorited,
  });
  late final int isBlocked;
  late final int userId;
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String createdDate;
  late final int callId;
  late final int isAnswered;
  late final String callType;
  late final int isFavorited;

  Data.fromJson(Map<String, dynamic> json){
    isBlocked = json['isBlocked'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    name = json['name'];
    createdDate = json['createdDate'];
    callId = json['callId'];
    isAnswered = json['isAnswered'];
    callType = json['callType'];
    isFavorited = json['isFavorited'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isBlocked'] = isBlocked;
    _data['userId'] = userId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['name'] = name;
    _data['createdDate'] = createdDate;
    _data['callId'] = callId;
    _data['isAnswered'] = isAnswered;
    _data['callType'] = callType;
    _data['isFavorited'] = isFavorited;
    return _data;
  }
}