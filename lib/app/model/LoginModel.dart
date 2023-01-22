class LoginModel {
  LoginModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final Data data;

  LoginModel.fromJson(Map<String, dynamic> json){
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
    required this.page,
  });
  late final User? user;
  late final String page;

  Data.fromJson(Map<String, dynamic> json){
    user = json['user'] == null ? null : User.fromJson(json['user']);
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user?.toJson();
    _data['page'] = page;
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
    this.createdDate,
    this.updatedDate,
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
  late final String? createdDate;
  late final String? updatedDate;

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
    createdDate = null;
    updatedDate = null;
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
    _data['updatedDate'] = updatedDate;
    return _data;
  }
}