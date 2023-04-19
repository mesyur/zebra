class OpenConversionModel {
  OpenConversionModel({
    required this.data,
  });
  late final Data data;

  OpenConversionModel.fromJson(Map<String, dynamic> json){
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
    required this.zebraUserData,
    required this.zebraProviderUserId,
    required this.zebraProviderUserFirstName,
    required this.zebraProviderUserListName,
    required this.price,
    required this.selectedDay,
    required this.t2,
    required this.homeRomsText,
    required this.cleanTimeText,
    required this.noteController,
  });
  late final ZebraUserData zebraUserData;
  late final int zebraProviderUserId;
  late final String zebraProviderUserFirstName;
  late final String zebraProviderUserListName;
  late final int price;
  late final String selectedDay;
  late final String t2;
  late final String homeRomsText;
  late final String cleanTimeText;
  late final String noteController;

  Data.fromJson(Map<String, dynamic> json){
    zebraUserData = ZebraUserData.fromJson(json['zebraUserData']);
    zebraProviderUserId = json['zebraProviderUserId'];
    zebraProviderUserFirstName = json['zebraProviderUserFirstName'];
    zebraProviderUserListName = json['zebraProviderUserListName'];
    price = json['price'];
    selectedDay = json['selectedDay'];
    t2 = json['t2'];
    homeRomsText = json['homeRomsText'];
    cleanTimeText = json['cleanTimeText'];
    noteController = json['noteController'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['zebraUserData'] = zebraUserData.toJson();
    _data['zebraProviderUserId'] = zebraProviderUserId;
    _data['zebraProviderUserFirstName'] = zebraProviderUserFirstName;
    _data['zebraProviderUserListName'] = zebraProviderUserListName;
    _data['price'] = price;
    _data['selectedDay'] = selectedDay;
    _data['t2'] = t2;
    _data['homeRomsText'] = homeRomsText;
    _data['cleanTimeText'] = cleanTimeText;
    _data['noteController'] = noteController;
    return _data;
  }
}

class ZebraUserData {
  ZebraUserData({
    required this.user,
  });
  late final User user;

  ZebraUserData.fromJson(Map<String, dynamic> json){
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
  late final String identityNumber;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phone;
  late final int gender;
  late final String birthDate;
  late final int isCitizen;
  late final int isActive;

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