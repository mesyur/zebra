class RegisterRequestDto {
  final String firstName;
  final String lastName;
  final String phone;
  final int userType = 0;
  final int privacyPolicy = 1;
  final int userAgreement = 1;

  RegisterRequestDto({
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'userType': userType,
      'privacyPolicy': privacyPolicy,
      'userAgreement': userAgreement,
    };
  }
}
