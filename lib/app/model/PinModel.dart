class PinModel {
  PinModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final Data data;

  PinModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.user,
  });
  late final User user;

  Data.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phone,
    required this.userType,
    required this.pin,
    this.gender,
    required this.isActive,
    required this.privacyPolicy,
    required this.userAgreement,
    required this.createdDate,
    required this.token,
    required this.deviceData,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String? email;
  late final String phone;
  late final int userType;
  late final int pin;
  late final int? gender;
  late final int isActive;
  late final int privacyPolicy;
  late final int userAgreement;
  late final String createdDate;
  late final String token;
  late final List<DeviceData> deviceData;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    userType = json['userType'];
    pin = json['pin'];
    gender = json['gender'];
    isActive = json['isActive'];
    privacyPolicy = json['privacyPolicy'];
    userAgreement = json['userAgreement'];
    createdDate = json['createdDate'];
    token = json['token'];
    deviceData = List.from(json['deviceData']).map((e)=>DeviceData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['userType'] = userType;
    _data['pin'] = pin;
    _data['gender'] = gender;
    _data['isActive'] = isActive;
    _data['privacyPolicy'] = privacyPolicy;
    _data['userAgreement'] = userAgreement;
    _data['createdDate'] = createdDate;
    _data['token'] = token;
    _data['deviceData'] = deviceData.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class DeviceData {
  DeviceData({
    required this.id,
    required this.userId,
    required this.fcmToken,
    required this.model,
    required this.os,
    required this.brand,
    required this.isActive,
  });
  late final int id;
  late final int userId;
  late final String fcmToken;
  late final String model;
  late final String os;
  late final String brand;
  late final int isActive;

  DeviceData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    fcmToken = json['fcmToken'];
    model = json['model'];
    os = json['os'];
    brand = json['brand'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['fcmToken'] = fcmToken;
    _data['model'] = model;
    _data['os'] = os;
    _data['brand'] = brand;
    _data['isActive'] = isActive;
    return _data;
  }
}