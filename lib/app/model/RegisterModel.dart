class RegisterModel {
  RegisterModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final Data data;

  RegisterModel.fromJson(Map<String, dynamic> json){
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
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.privacyPolicy,
    required this.userType,
    required this.userAgreement,
    required this.userId,
  });
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final int privacyPolicy;
  late final int userType;
  late final int userAgreement;
  late final int userId;

  User.fromJson(Map<String, dynamic> json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    privacyPolicy = json['privacyPolicy'];
    userType = json['userType'];
    userAgreement = json['userAgreement'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['phone'] = phone;
    _data['privacyPolicy'] = privacyPolicy;
    _data['userType'] = userType;
    _data['userAgreement'] = userAgreement;
    _data['userId'] = userId;
    return _data;
  }
}