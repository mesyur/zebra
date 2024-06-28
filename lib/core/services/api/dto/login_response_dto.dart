// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDto {
  final int id;
  final String firstName;
  final String lastName;
  final String? email;
  final String phone;
  final int userType;
  final int pin;
  final int? gender;
  final int isActive;
  final int privacyPolicy;
  final int userAgreement;
  final String? createdDate;
  final String? updatedDate;
  final String? token;
  // late final List<DeviceData> deviceData;

  UserDto({
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
    this.token,
  });

  UserDto copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    int? userType,
    int? pin,
    int? gender,
    int? isActive,
    int? privacyPolicy,
    int? userAgreement,
    String? createdDate,
    String? updatedDate,
    String? token,
  }) {
    return UserDto(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userType: userType ?? this.userType,
      pin: pin ?? this.pin,
      gender: gender ?? this.gender,
      isActive: isActive ?? this.isActive,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      userAgreement: userAgreement ?? this.userAgreement,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'userType': userType,
      'pin': pin,
      'gender': gender,
      'isActive': isActive,
      'privacyPolicy': privacyPolicy,
      'userAgreement': userAgreement,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'token': token,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] as String,
      userType: map['userType'] as int,
      pin: map['pin'] as int,
      gender: map['gender'] != null ? map['gender'] as int : null,
      isActive: map['isActive'] as int,
      privacyPolicy: map['privacyPolicy'] as int,
      userAgreement: map['userAgreement'] as int,
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as String : null,
      updatedDate:
          map['updatedDate'] != null ? map['updatedDate'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDto(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, userType: $userType, pin: $pin, gender: $gender, isActive: $isActive, privacyPolicy: $privacyPolicy, userAgreement: $userAgreement, createdDate: $createdDate, updatedDate: $updatedDate, token: $token)';
  }

  @override
  bool operator ==(covariant UserDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phone == phone &&
        other.userType == userType &&
        other.pin == pin &&
        other.gender == gender &&
        other.isActive == isActive &&
        other.privacyPolicy == privacyPolicy &&
        other.userAgreement == userAgreement &&
        other.createdDate == createdDate &&
        other.updatedDate == updatedDate &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        userType.hashCode ^
        pin.hashCode ^
        gender.hashCode ^
        isActive.hashCode ^
        privacyPolicy.hashCode ^
        userAgreement.hashCode ^
        createdDate.hashCode ^
        updatedDate.hashCode ^
        token.hashCode;
  }
}

class LoginResponseDto {
  final UserDto? user;
  final String page;

  LoginResponseDto({
    this.user,
    required this.page,
  });

  LoginResponseDto copyWith({
    UserDto? user,
    String? page,
  }) {
    return LoginResponseDto(
      user: user ?? this.user,
      page: page ?? this.page,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'page': page,
    };
  }

  factory LoginResponseDto.fromMap(Map<String, dynamic> map) {
    return LoginResponseDto(
      user: map['user'] != null
          ? UserDto.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      page: map['page'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseDto.fromJson(String source) =>
      LoginResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginResponseDto(user: $user, page: $page)';

  @override
  bool operator ==(covariant LoginResponseDto other) {
    if (identical(this, other)) return true;

    return other.user == user && other.page == page;
  }

  @override
  int get hashCode => user.hashCode ^ page.hashCode;
}
