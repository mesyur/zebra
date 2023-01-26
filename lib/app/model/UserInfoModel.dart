class UserInfoModel {
  UserInfoModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final Data data;

  UserInfoModel.fromJson(Map<String, dynamic> json){
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
    required this.identityNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.isCitizen,
    required this.isActive,
  });
  late final int id;
  late final String? identityNumber;
  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? phone;
  late final int? gender;
  late final String? birthDate;
  late final int? isCitizen;
  late final int? isActive;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    identityNumber = json['identityNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    isCitizen = json['isCitizen'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['identityNumber'] = identityNumber;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['gender'] = gender;
    _data['birthDate'] = birthDate;
    _data['isCitizen'] = isCitizen;
    _data['isActive'] = isActive;
    return _data;
  }
}