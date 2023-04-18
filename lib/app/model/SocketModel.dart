class SocketModel {
  SocketModel({
    required this.data,
  });
  late final Data data;

  SocketModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.price,
    required this.homeRomsText,
    required this.cleanTimeText,
    required this.selectedDay,
    required this.t2,
    required this.currentUuid,
    required this.userData,
  });
  late final int id;
  late final int price;
  late final String homeRomsText;
  late final String cleanTimeText;
  late final String selectedDay;
  late final String t2;
  late final String currentUuid;
  late final UserData userData;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    homeRomsText = json['homeRomsText'];
    cleanTimeText = json['cleanTimeText'];
    selectedDay = json['selectedDay'];
    t2 = json['t2'];
    currentUuid = json['currentUuid'];
    userData = UserData.fromJson(json['userData']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['price'] = price;
    _data['homeRomsText'] = homeRomsText;
    _data['cleanTimeText'] = cleanTimeText;
    _data['selectedDay'] = selectedDay;
    _data['t2'] = t2;
    _data['currentUuid'] = currentUuid;
    _data['userData'] = userData.toJson();
    return _data;
  }
}

class UserData {
  UserData({
    required this.id,
    required this.identityNumber,
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phone,
    required this.gender,
    this.birthDate,
    required this.isCitizen,
    required this.isActive,
  });
  late final int id;
  late final String identityNumber;
  late final String firstName;
  late final String lastName;
  late final Null email;
  late final String phone;
  late final int gender;
  late final Null birthDate;
  late final int isCitizen;
  late final int isActive;

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    identityNumber = json['identityNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = null;
    phone = json['phone'];
    gender = json['gender'];
    birthDate = null;
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