class LoginRequestDto {
  final String phone;

  LoginRequestDto({
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
    };
  }
}
